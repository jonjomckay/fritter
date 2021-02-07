import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models.dart';

var countries = {
  'BG': Country('\u{1F1E7}\u{1F1EC}', 'Bulgaria'),
  'DE': Country('\u{1F1E9}\u{1F1EA}', 'Germany'),
  'ES': Country('\u{1F1EA}\u{1F1F8}', 'Spain'),
  'FI': Country('\u{1F1EB}\u{1F1EE}', 'Finland'),
  'FR': Country('\u{1F1EB}\u{1F1F7}', 'France'),
  'IN': Country('\u{1F1EE}\u{1F1F3}', 'India'),
  'NL': Country('\u{1F1F3}\u{1F1F1}', 'Netherlands'),
  'RS': Country('\u{1F1F7}\u{1F1F8}', 'Serbia'),
  'US': Country('\u{1F1FA}\u{1F1F8}', 'United States of America'),
};

var instances = {
  'BG': [
    Instance('nitter.himiko.cloud', '\u{1F1E7}\u{1F1EC}'),
  ],
  'DE': [
    Instance('nitter.net', '\u{1F1E9}\u{1F1EA}'),
    Instance('nitter.nixnet.services', '\u{1F1E9}\u{1F1EA}'),
    Instance('nitter.13ad.de', '\u{1F1E9}\u{1F1EA}'),
    Instance('nitter.pussthecat.org', '\u{1F1E9}\u{1F1EA}'),
    Instance('nitter.mastodont.cat', '\u{1F1E9}\u{1F1EA}'),
    Instance('nitter.cattube.org', '\u{1F1E9}\u{1F1EA}'),
    Instance('nitter.namazso.eu', '\u{1F1E9}\u{1F1EA}'),
  ],
  'FI': [
    Instance('nitter.eu', '\u{1F1EB}\u{1F1EE}'),
  ],
  'FR': [
    Instance('nitter.42l.fr', '\u{1F1EB}\u{1F1F7}'),
    Instance('nitter.tedomum.net', '\u{1F1EB}\u{1F1F7}'),
    Instance('nitter.fdn.fr', '\u{1F1EB}\u{1F1F7}'),
    Instance('nitter.ethibox.fr', '\u{1F1EB}\u{1F1F7}'),
  ],
  'IN': [
    Instance('nitter.kavin.rocks', '\u{1F1EE}\u{1F1F3}'),
  ],
  'NL': [
    Instance('nitter.unixfox.eu', '\u{1F1F3}\u{1F1F1}'),
  ],
  'RS': [
    Instance('nitter.cc', '\u{1F1F7}\u{1F1F8}'),
  ],
  'ES': [
    Instance('nitter.vxempire.xyz', '\u{1F1EA}\u{1F1F8}'),
  ],
  'US': [
    Instance('nitter.dark.fail', '\u{1F1FA}\u{1F1F8}'),
    Instance('nitter.1d4.us', '\u{1F1FA}\u{1F1F8}'),
    Instance('tweet.lambda.dance', '\u{1F1FA}\u{1F1F8}'),
    Instance('nitter.weaponizedhumiliation.com', '\u{1F1FA}\u{1F1F8}'),
    Instance('nitter.domain.glass', '\u{1F1FA}\u{1F1F8}'),
  ],
};

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

    for (var entry in instances.entries) {
      var country = countries[entry.key];

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