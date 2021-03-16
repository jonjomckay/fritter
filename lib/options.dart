import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class OptionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  List<String> _values = [];

  @override
  void initState() {
    super.initState();

    var prefs = PrefService.getStringList('instances');
    if (prefs == null) {
      PrefService.setStringList('instances', _values);
    } else {
      setState(() {
        _values = prefs;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> instanceCheckboxes = [];

    for (var entry in INSTANCES.entries) {
      var country = COUNTRIES[entry.key];

      instanceCheckboxes.add(PreferenceText('${country.name}',
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(country.flag),
            ],
          ),
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold
          )
      ));
      
      for (var instance in entry.value) {
        instanceCheckboxes.add(StatefulBuilder(builder: (context, setState) {
          var onDisable = () {
            setState(() {
              _values = _values..remove(instance.hostname);
              PrefService.setStringList('instances', _values);
            });
          };

          var onEnable = () {
            setState(() {
              _values = _values..add(instance.hostname);
              PrefService.setStringList('instances', _values);
            });
          };

          return ListTile(
            title: Text(instance.hostname),
            trailing: Checkbox(
              value: _values.contains(instance.hostname),
              onChanged: (val) {
                return val ? onEnable() : onDisable();
              },
            ),
            onTap: () {
              return _values.contains(instance.hostname)
                ? onDisable()
                : onEnable();
            },
          );
        }));
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var a = snapshot.data.getKeys();

            var i = 0;
          }

          return PreferencePage([
            PreferenceTitle('General'),
            PreferenceDialogLink(
              'Instances',
              desc: 'Select which Nitter instances to use',
              dialog: PreferenceDialog(
                instanceCheckboxes,
                title: 'Instances',
                submitText: 'OK',
                onlySaveOnSubmit: false,
              ),
            ),

            PreferenceTitle('Theme'),
            SwitchPreference(
              'True Black?',
              OPTION_THEME_TRUE_BLACK,
              desc: 'Use true black for the dark mode theme',
              onChange: () {
                PrefService.notify(OPTION_THEME_TRUE_BLACK);
              },
            )
          ]);
        },
      ),
    );
  }
}

class CheckboxPreference extends StatefulWidget {
  final String title;
  final String desc;
  final String localKey;
  final bool defaultVal;
  final bool ignoreTileTap;

  final bool disabled;

  final bool resetOnException;

  final Function onEnable;
  final Function onDisable;
  final Function onChange;

  CheckboxPreference(this.title, this.localKey,
      {this.desc,
        this.defaultVal = false,
        this.ignoreTileTap = false,
        this.resetOnException = true,
        this.onEnable,
        this.onDisable,
        this.onChange,
        this.disabled = false});

  _CheckboxPreferenceState createState() => _CheckboxPreferenceState();
}

class _CheckboxPreferenceState extends State<CheckboxPreference> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      subtitle: widget.desc == null ? null : Text(widget.desc),
      trailing: Checkbox(
        value: widget.defaultVal,
        onChanged:
        widget.disabled ? null : (val) => val ? onEnable() : onDisable(),
      ),
      onTap: (widget.ignoreTileTap || widget.disabled)
          ? null
          : () => widget.defaultVal
          ? onDisable()
          : onEnable(),
    );
  }

  onEnable() async {
    if (widget.onChange != null) widget.onChange();
    if (widget.onEnable != null) {
      try {
        await widget.onEnable();
      } catch (e) {
        if (widget.resetOnException) {
          if (mounted) setState(() {});
        }
        if (mounted) PrefService.showError(context, e.message);
      }
    }
  }

  onDisable() async {
    if (widget.onChange != null) widget.onChange();
    if (widget.onDisable != null) {
      try {
        await widget.onDisable();
      } catch (e) {
        if (widget.resetOnException) {
          if (mounted) setState(() {});
        }
        if (mounted) PrefService.showError(context, e.message);
      }
    }
  }
}