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
    List<Widget> instanceCheckboxes = [];

    var prefsService = PrefService.of(context);

    List<String> savedInstances = [];

    var prefs = prefsService.get('instances');
    if (prefs == null) {
      prefsService.set('instances', savedInstances);
    } else {
      savedInstances = List.from(prefs);
    }

    for (var entry in INSTANCES.entries) {
      var country = COUNTRIES[entry.key];

      instanceCheckboxes.add(PrefLabel(
          title: Text('${country?.name}', style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold
          )),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(country!.flag),
            ],
          ),
      ));
      
      for (var instance in entry.value) {
        instanceCheckboxes.add(StatefulBuilder(builder: (context, setState) {
          var onDisable = () {
            setState(() {
              savedInstances = savedInstances..remove(instance.hostname);
              prefsService.set('instances', savedInstances);
            });
          };

          var onEnable = () {
            setState(() {
              savedInstances = savedInstances..add(instance.hostname);
              prefsService.set('instances', savedInstances);
            });
          };

          return ListTile(
            title: Text(instance.hostname),
            trailing: Checkbox(
              value: savedInstances.contains(instance.hostname),
              onChanged: (val) {
                return (val ?? false) ? onEnable() : onDisable();
              },
            ),
            onTap: () {
              return savedInstances.contains(instance.hostname)
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
          return PrefPage(children: [
            PrefTitle(title: Text('General')),
            PrefDialogButton(
              title: Text('Instances'),
              subtitle: Text('Select which Nitter instances to use'),
              dialog: PrefDialog(
                children: instanceCheckboxes,
                title: Text('Instances'),
                submit: Text('OK'),
                onlySaveOnSubmit: false,
              ),
            ),

            PrefTitle(title: Text('Theme')),
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

// class CheckboxPreference extends StatefulWidget {
//   final String title;
//   final String desc;
//   final String localKey;
//   final bool defaultVal;
//   final bool ignoreTileTap;
//
//   final bool disabled;
//
//   final bool resetOnException;
//
//   final Function onEnable;
//   final Function onDisable;
//   final Function onChange;
//
//   CheckboxPreference(this.title, this.localKey,
//       {this.desc,
//         this.defaultVal = false,
//         this.ignoreTileTap = false,
//         this.resetOnException = true,
//         this.onEnable,
//         this.onDisable,
//         this.onChange,
//         this.disabled = false});
//
//   _CheckboxPreferenceState createState() => _CheckboxPreferenceState();
// }
//
// class _CheckboxPreferenceState extends State<CheckboxPreference> {
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(widget.title),
//       subtitle: widget.desc == null ? null : Text(widget.desc),
//       trailing: Checkbox(
//         value: widget.defaultVal,
//         onChanged:
//         widget.disabled ? null : (val) => val ? onEnable() : onDisable(),
//       ),
//       onTap: (widget.ignoreTileTap || widget.disabled)
//           ? null
//           : () => widget.defaultVal
//           ? onDisable()
//           : onEnable(),
//     );
//   }
//
//   onEnable() async {
//     if (widget.onChange != null) widget.onChange();
//     if (widget.onEnable != null) {
//       try {
//         await widget.onEnable();
//       } catch (e) {
//         if (widget.resetOnException) {
//           if (mounted) setState(() {});
//         }
//         if (mounted) PrefService.showError(context, e.message);
//       }
//     }
//   }
//
//   onDisable() async {
//     if (widget.onChange != null) widget.onChange();
//     if (widget.onDisable != null) {
//       try {
//         await widget.onDisable();
//       } catch (e) {
//         if (widget.resetOnException) {
//           if (mounted) setState(() {});
//         }
//         if (mounted) PrefService.showError(context, e.message);
//       }
//     }
//   }
// }