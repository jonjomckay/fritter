import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/subscription_group.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'home_model.dart';
import 'options.dart';
import 'tweet.dart';
import 'user.dart';

class _Tab {
  final String title;
  final IconData icon;

  _Tab(this.title, this.icon);
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final List<_Tab> _tabs = [
    _Tab('Trending', Icons.trending_up),
    _Tab('Following', Icons.people),
  ];
  
  late TabController _tabController;
  late int _currentTabIndex;

  @override
  void initState() {
    super.initState();

    _currentTabIndex = 0;

    _tabController = TabController(vsync: this, length: _tabs.length);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

 @override
 void dispose() {
   _tabController.dispose();
   super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabs[_currentTabIndex].title),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: TweetSearch());
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => OptionsScreen()));
            },
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            ..._tabs.map((e) => Tab(
              icon: Icon(e.icon),
            ))
          ]
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => HomeModel(),
        child: TabBarView(
          controller: _tabController,
          children: [
            TrendsContent(),
            FollowingContent(),
          ],
        ),
      ),
    );
  }
}

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class TweetSearchResultList<T> extends StatelessWidget {

  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  const TweetSearchResultList({Key? key, required this.snapshot, required this.itemBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasError) {
      var error = snapshot.error as Exception;

      return Container(
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Oops! Something went wrong 🥲', style: TextStyle(
                fontSize: 18
            )),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Text('$error', style: TextStyle(
                  color: Theme.of(context).hintColor
              )),
            )
          ],
        ),
      );
    }

    var items = snapshot.data;
    if (items == null) {
      return Center(child: CircularProgressIndicator());
    }

    if (items.isEmpty) {
      return Center(child: Text('No results'));
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return itemBuilder(context, items[index]);
      },
    );
  }
}


class TweetSearch extends SearchDelegate {
  Future<List<Tweet>> searchTweets(BuildContext context, String query) async {
    if (query.isEmpty) {
      return [];
    } else {
      return await Twitter.searchTweets(query);
    }
  }

  Future<List<User>> searchUsers(BuildContext context, String query) async {
    if (query.isEmpty) {
      return [];
    } else {
      return await Twitter.searchUsers(query);
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {
        query = '';
      })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            child: TabBar(tabs: [
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.comment)),
            ]),
          ),
          Container(
            child: Expanded(child: TabBarView(children: [
              FutureBuilder<List<User>>(
                future: searchUsers(context, query),
                builder: (context, snapshot) {
                  return TweetSearchResultList<User>(snapshot: snapshot, itemBuilder: (context, item) {
                    return UserTile(
                        id: item.idStr!,
                        name: item.name!,
                        imageUri: item.profileImageUrlHttps!,
                        screenName: item.screenName!
                    );
                  });
                },
              ),
              FutureBuilder<List<Tweet>>(
                future: searchTweets(context, query),
                builder: (context, snapshot) {
                  return TweetSearchResultList<Tweet>(snapshot: snapshot, itemBuilder: (context, item) {
                    return TweetTile(
                      tweet: item,
                      clickable: true
                    );
                  });
                },
              ),
            ])),
          )
        ],
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}

class TrendsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<HomeModel>(
        builder: (context, model, child) {
          return FutureBuilder<List<Trends>>(
            future: model.loadTrends(),
            builder: (context, snapshot) {
              var data = snapshot.data;
              if (data == null) {
                return Center(child: CircularProgressIndicator());
              }

              var trends = data[0].trends;
              if (trends == null) {
                return Text('There were no trends returned. This is unexpected! Please report as a bug, if possible.');
              }

              var numberFormat = NumberFormat.compact();

              return ListView(
                children: [
                  Container(
                    child: ListTile(
                      title: Text('Worldwide trends', style: TextStyle(
                          fontWeight: FontWeight.bold
                      )),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: trends.length,
                    itemBuilder: (context, index) {
                      var trend = trends[index];

                      return ListTile(
                        dense: true,
                        leading: Text('${++index}'),
                        title: Text('${trend.name!}'),
                        subtitle: trend.tweetVolume == null
                            ? null
                            : Text('${numberFormat.format(trend.tweetVolume)} tweets'),
                        onTap: () async {
                          await showSearch(
                              context: context,
                              delegate: TweetSearch(),
                              query: Uri.decodeQueryComponent(trend.query!)
                          );
                        },
                      );
                    },
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class SubscriptionCheckboxList extends StatefulWidget {
  final List<Following> following;

  const SubscriptionCheckboxList({Key? key, required this.following}) : super(key: key);

  @override
  _SubscriptionCheckboxListState createState() => _SubscriptionCheckboxListState();
}

class _SubscriptionCheckboxListState extends State<SubscriptionCheckboxList> {
  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return ReactiveFormArray<bool>(
          formArrayName: 'subscriptions',
          builder: (context, formArray, child) {
            var children = formArray.controls
                .asMap().entries
                .map((entry) {
                  var index = entry.key;
                  var value = entry.value;

                  var e = widget.following[index];

                  // TODO: This is just copied from UserTile
                  var image = e.profileImageUrlHttps == null
                      ? Container(width: 48, height: 48)
                      : CachedNetworkImage(
                      imageUrl: e.profileImageUrlHttps!.replaceAll('normal', '200x200'),
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error), // TODO: This can error if the profile image has changed... use SWR-like
                      width: 40,
                      height: 40
                  );

                  return CheckboxListTile(
                    dense: true,
                    secondary: ClipRRect(
                      borderRadius: BorderRadius.circular(64),
                      child: image,
                    ),
                    title: Text(e.name),
                    subtitle: Text('@${e.screenName}'),
                    value: value.value ?? false,
                    onChanged: (v) {
                      if (v != null) {
                        value.value = v;
                      }
                    },
                  );
                })
                .toList(growable: false);

            return ListView(
                shrinkWrap: true,
                children: children
            );
          },
        );
      },
    );
  }
}


class FollowingContent extends StatefulWidget {
  @override
  _FollowingContentState createState() => _FollowingContentState();
}

class _FollowingContentState extends State<FollowingContent> {
  final _refreshController = RefreshController(initialRefresh: false);

  Future _onRefresh() async {
    try {
      await Future.delayed(Duration(milliseconds: 400));

      await context.read<HomeModel>().refresh();
    } finally {
      _refreshController.refreshCompleted();
    }
  }

  void openDeleteSubscriptionGroupDialog(int id, String name) {
    var model = context.read<HomeModel>();

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () async {
              await model.deleteSubscriptionGroup(id);

              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Yes'),
          ),
        ],
        title: Text('Are you sure?'),
        content: Text('Are you sure you want to delete the subscription group $name?'),
      );
    });
  }

  void openSubscriptionGroupDialog(int? id, String name) {
    var model = context.read<HomeModel>();

    showDialog(context: context, builder: (context) {
      return FutureBuilder<SubscriptionGroupEdit>(
        future: model.loadSubscriptionGroupEdit(id),
        builder: (context, snapshot) {
          var error = snapshot.error;
          if (error != null) {
            // TODO
            log('Unable to load the subscription group', error: error);
          }

          var edit = snapshot.data;
          if (edit == null) {
            // TODO: Alert
            return Center(child: CircularProgressIndicator());
          }

          final form = FormGroup({
            'name': FormControl<String>(
                value: name,
                validators: [Validators.required],
                touched: true
            ),
            'subscriptions': FormArray<bool>(
                edit.allFollowing
                    .map((e) => FormControl<bool>(value: edit.following.contains(e.id)))
                    .toList(growable: false)
            )
          });

          return ReactiveForm(
              formGroup: form,
              child: AlertDialog(
                actions: [
                  TextButton(
                    onPressed: id == null
                      ? null
                      : () => openDeleteSubscriptionGroupDialog(id, name),
                    child: Text('Delete'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  ReactiveFormConsumer(
                    builder: (context, form, child) {
                      var onPressed = () async {
                        var selectedSubscriptions = (form.control('subscriptions').value as List<bool?>)
                            .asMap().entries
                            .map((e) {
                          var index = e.key;
                          var value = e.value;
                          if (value != null && value == true) {
                            return edit.allFollowing[index];
                          }

                          return null;
                        })
                            .where((element) => element != null)
                            .cast<Following>()
                            .toList(growable: false);

                        await model.saveSubscriptionGroup(
                            id,
                            form.control('name').value,
                            selectedSubscriptions
                        );

                        Navigator.pop(context);
                      };

                      return TextButton(
                        child: Text('OK'),
                        onPressed: form.valid
                            ? onPressed
                            : null,
                      );
                    },
                  ),
                ],
                content: Container(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ReactiveTextField(
                        formControlName: 'name',
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Name'
                        ),
                        validationMessages: (control) => {
                          ValidationMessage.required: 'Please enter a name',
                        },
                      ),
                      Expanded(
                        child: SubscriptionCheckboxList(
                          following: edit.allFollowing,
                        ),
                      )
                    ],
                  ),
                ),
              )
          );
        },
      );
    });
  }

  Widget _createGroupCard(IconData icon, int id, String name, void Function()? onLongPress) {
    return Card(
      child: InkWell(
        onTap: () {
          // Open page with the group's feed
          Navigator.push(context, MaterialPageRoute(builder: (context) => SubscriptionGroupScreen(id: id)));
        },
        onLongPress: onLongPress,
        child: Column(
          children: [
            Container(
              color: Colors.white10,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Icon(icon, size: 16),
            ),
            Expanded(child: Container(
              alignment: Alignment.center,
              color: Colors.white24,
              width: double.infinity,
              padding: EdgeInsets.all(4),
              child: Text(name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold
                )
              ),
            ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<HomeModel>(
        builder: (context, model, child) {
          return FutureBuilder<List<SubscriptionGroup>>(
            future: model.listSubscriptionGroups(),
            builder: (context, snapshot) {
              var groups = snapshot.data;
              if (groups == null) {
                return Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      title: Text('Groups', style: TextStyle(
                          fontWeight: FontWeight.bold
                      )),
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: GridView.extent(
                              maxCrossAxisExtent: 120,
                              childAspectRatio: 200 / 125,
                              shrinkWrap: true,
                              children: [
                                _createGroupCard(Icons.rss_feed, -1, 'All', null),
                                ...groups.map((e) => _createGroupCard(Icons.rss_feed, e.id, e.name, () => openSubscriptionGroupDialog(e.id, e.name))),
                                Card(
                                  child: InkWell(
                                    onTap: () {
                                      openSubscriptionGroupDialog(null, '');
                                    },
                                    child: DottedBorder(
                                      color: Colors.white,
                                      child: Container(
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              // color: Colors.white10,
                                              // width: double.infinity,
                                              child: Icon(Icons.add, size: 16),
                                            ),
                                            SizedBox(height: 4),
                                            Text('New', style: TextStyle(
                                              fontSize: 11,
                                            ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                        )
                      ],
                    ),
                  ),
                  Expanded(child: Column(
                    children: [
                      ListTile(
                        title: Text('Following', style: TextStyle(
                            fontWeight: FontWeight.bold
                        )),
                      ),
                      Expanded(child: FutureBuilder<List<Following>>(
                        future: model.listFollowing(),
                        builder: (context, snapshot) {
                          var error = snapshot.error;
                          if (error != null) {
                            // TODO
                            log('Unable to list the user\'s subscriptions', error: error);
                          }

                          var data = snapshot.data;
                          if (data == null) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (data.isEmpty) {
                            return Center(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('¯\\_(ツ)_/¯', style: TextStyle(
                                      fontSize: 32
                                  )),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 16),
                                    child: Text('Try searching for some users to follow!', style: TextStyle(
                                        color: Theme.of(context).hintColor
                                    )),
                                  )
                                ])
                            );
                          }

                          return SmartRefresher(
                            controller: _refreshController,
                            enablePullDown: true,
                            enablePullUp: false,
                            onRefresh: _onRefresh,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                var user = data[index];

                                return UserTile(
                                  id: user.id.toString(),
                                  name: user.name,
                                  screenName: user.screenName,
                                  imageUri: user.profileImageUrlHttps,
                                );
                              },
                            ),
                          );
                        },
                      ))
                    ],
                  ))
                ],
              );
            },
          );
        },
      ),
    );
  }
}

