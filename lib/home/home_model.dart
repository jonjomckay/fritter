import 'package:flutter_triple/flutter_triple.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/group/group_model.dart';
import 'package:fritter/home/home_screen.dart';
import 'package:fritter/utils/iterables.dart';
import 'package:pref/pref.dart';

class HomePage {
  final String id;
  bool selected;
  final NavigationPage page;

  HomePage(this.id, this.selected, this.page);
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

      // First, add all of our saved pages, in the correct order
      for (var id in saved) {
        var page = available.firstWhereOrNull((e) => e.id == id);
        if (page == null) {
          continue;
        }

        pages.add(HomePage(id, true, page));
      }

      // Then add all the other available pages, unselected, to the end of the list, for the settings screen
      for (var page in available) {
        if (saved.contains(page.id)) {
          continue;
        }

        pages.add(HomePage(page.id, false, page));
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