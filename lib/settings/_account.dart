import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:pref/pref.dart';

import '../WebFlowAuth/webFlowAuth_model.dart';


class SettingsAccountFragment extends StatelessWidget {
  const SettingsAccountFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.read<WebFlowAuthModel>();
    return Scaffold(
      appBar: AppBar(title: Text(L10n.current.account)),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(children: [
          Row(
            children: [
              Flexible(
                child: PrefLabel(
                  title: Text(L10n.of(context).loginNameTwitterAcc),
                ),
              ),
              Flexible(
                child: PrefText(
                  label: '',
                  pref: optionLoginNameTwitterAcc,
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

          Row(
            children: [
              Flexible(
                child: PrefLabel(
                  title: Text(L10n.of(context).passwordTwitterAcc),
                ),
              ),
              Flexible(
                child: PrefText(
                  obscureText: true,
                  label: '',
                  pref: optionPasswordTwitterAcc,
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
          Row(
            children: [
              Flexible(
                child: PrefLabel(
                  title: Text(L10n.of(context).emailTwitterAcc),
                ),
              ),
              Flexible(
                child: PrefText(
                  label: '',
                  pref: optionEmailTwitterAcc,
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

          OutlinedButton(onPressed: () async {
            await model.DeleteAllCookies();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  L10n.of(context).twitterCookiesDeleted,
                ),
              ),
            );
          }, child: Text(L10n.of(context).DeleteTwitterCookies))

        ]),
      ),
    );
  }
}
