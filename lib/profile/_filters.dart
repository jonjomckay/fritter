import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/user.dart';
import 'package:provider/provider.dart';
import 'package:pref/pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'filter_model.dart';

class Filters extends StatelessWidget {
  final UserWithExtra user;
  const Filters({Key? key,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FilterModel model= FilterModel(this.user.idStr!,PrefService.of(context));
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(children: [
          Row(
            children: [
              Flexible(
                flex: 3,
                child: PrefLabel(
                  title: Text(L10n.of(context).loadTweetCounterMaximum,overflow: TextOverflow.visible),
                  subtitle: Text(L10n.of(context).loadTweetCounterMaximumSubtitle,overflow: TextOverflow.visible),
                ),

              ),
              Flexible(
                child:  Container(
                  child: PrefText(
                    label: '',
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    pref: model.prefLoadTweetsCounter(),
                    //style: const TextStyle(fontSize: 16,height:1),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(3, 0, 16, 3),
                      isDense: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color:Theme.of(context).colorScheme.primary),
                      ),
                      focusedBorder:UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color:Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Flexible(
                child: PrefLabel(
                  title: Text(L10n.of(context).regex),
                  subtitle: Text(L10n.of(context).regexSubtitle),
                ),
              ),

            ],
          ),
          Row(
            children: [
              Flexible(
                child: PrefText(
                  label: '',
                  pref: model.prefRegex(),
                  maxLines: 10,
                  //style: const TextStyle(fontSize: 16,height:1),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(3, 0, 16, 3),
                    isDense: true,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color:Theme.of(context).colorScheme.primary),
                    ),
                    focusedBorder:UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color:Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
              ),
            ],
          ),


        ]),
      ),
    );
  }
}