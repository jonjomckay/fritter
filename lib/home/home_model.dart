import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/utils/iterables.dart';
import 'package:pref/pref.dart';

class HomePage {
  final String id;
  final int order;
  bool selected;
  final NavigationPage page;

  HomePage(this.id, this.order, this.selected, this.page);
}

class HomeModel extends StreamStore<Object, List<HomePage>> {
  final BasePrefService prefs;
  final GroupsModel groupsModel;

  HomeModel(this.prefs, this.groupsModel) : super([]) {
    groupsModel.observer(onState: (state) async {
      await loadPages();
    });
  }

  Future<void> resetPages() async {
    await execute(() async {
      prefs.set(optionHomePages, defaultHomePages.map((e) => e.id).toList());
      await loadPages();
      return state;
    });
  }

  Future<void> loadPages() async {
    await execute(() async {
      var saved = prefs.getStringList(optionHomePages) ?? [];

      var available = [
        ...defaultHomePages,
        ...groupsModel.state.map((e) => NavigationPage('group-${e.id}', (c) => L10n.of(c).group_name(e.name), e.iconData)),
      ];

      var pages = <HomePage>[];
      for (var page in available) {
        var order = saved.indexWhere((element) => element == page.id);
        var exist = saved.any((element) => element == page.id);

        pages.add(HomePage(page.id, order, exist, page));
      }

      return pages;
    });
  }
  
  Future<void> movePage(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) {
      newIndex = newIndex - 1;
    }

    final page = state.removeAt(oldIndex);
    state.insert(newIndex, page);
    update(state);
  }

  Future<void> save() async {
    var pages = state
        .where((e) => e.selected)
        .sorted((a, b) => a.order.compareTo(b.order))
        .map((e) => e.id)
        .toList();

    await prefs.set(optionHomePages, pages);
  }

  Future<void> selectPage(String id, bool selected) async {
    for (var page in state) {
      if (page.id == id) {
        page.selected = selected;
        break;
      }
    }

    update(state, force: true);
  }
}