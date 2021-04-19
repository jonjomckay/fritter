import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class OptionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          return PrefPage(children: [
            PrefTitle(
              title: Text('Theme')
            ),
            PrefRadio(
              title: Text('System Theme'),
              value: 'system',
              pref: OPTION_THEME_MODE,
            ),
            PrefRadio(
              title: Text('Light Theme'),
              value: 'light',
              pref: OPTION_THEME_MODE,
            ),
            PrefRadio(
              title: Text('Dark Theme'),
              value: 'dark',
              pref: OPTION_THEME_MODE,
            ),
            PrefSwitch(
              title: Text('True Black?'),
              pref: OPTION_THEME_TRUE_BLACK,
              subtitle: Text('Use true black for the dark mode theme'),
            )
          ]);
        },
      ),
    );
  }
}