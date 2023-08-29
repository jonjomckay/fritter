import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:pref/pref.dart';

import '../constants.dart';


class FilterModel extends ChangeNotifier {
  static final log = Logger('FilterModel');
  final BasePrefService prefs;
  FilterModel(String this._screenName, this.prefs, ) : super(){
    _prefix="Filters_"+_screenName+"_";

  }
  final String _screenName;
   String _prefix="";

    String prefLoadTweetsCounter()  {
    return _prefix+"LoadTweetsCounter";
  }
    String prefRegex()  {
    return _prefix+"Regex";
  }
  String ?GetRegex()  {
    return prefs.get(_prefix+"Regex");
  }
   int GetLoadTweetsCounter()  {
    return  int.parse(prefs.get(_prefix+"LoadTweetsCounter"));
  }
  Future DeleteAllPref() async {
    return prefs.clear();
  }
}