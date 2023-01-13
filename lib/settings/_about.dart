import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/settings/_general.dart';
import 'package:fritter/utils/urls.dart';
import 'package:pref/pref.dart';
import 'package:simple_icons/simple_icons.dart';

class SettingsAboutFragment extends StatelessWidget {
  final String appVersion;

  const SettingsAboutFragment({Key? key, required this.appVersion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.current.about)
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(children: [
          PrefLabel(
            leading: const Icon(Icons.info),
            title: Text(L10n.of(context).version),
            subtitle: Text(appVersion),
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: appVersion));

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(L10n.of(context).copied_version_to_clipboard),
              ));
            },
          ),
          PrefLabel(
            leading: const Icon(Icons.favorite),
            title: Text(L10n.of(context).contribute),
            subtitle: Text(L10n.of(context).help_make_fritter_even_better),
            onTap: () => openUri('https://github.com/jonjomckay/fritter'),
          ),
          PrefLabel(
            leading: const Icon(Icons.bug_report),
            title: Text(L10n.of(context).report_a_bug),
            subtitle: Text(
              L10n.of(context).let_the_developers_know_if_something_is_broken,
            ),
            onTap: () => openUri('https://github.com/jonjomckay/fritter/issues'),
          ),
          if (getFlavor() != 'play')
            PrefLabel(
              leading: const Icon(Icons.attach_money),
              title: Text(L10n.of(context).donate),
              subtitle: Text(L10n.of(context).help_support_fritters_future),
              onTap: () => showDonateDialog(context),
            ),
          PrefLabel(
            leading: const Icon(Icons.copyright),
            title: Text(L10n.of(context).licenses),
            subtitle: Text(L10n.of(context).all_the_great_software_used_by_fritter),
            onTap: () => showLicensePage(
                context: context,
                applicationName: L10n.of(context).fritter,
                applicationVersion: appVersion,
                applicationLegalese: L10n.of(context).released_under_the_mit_license,
                applicationIcon: Container(
                  margin: const EdgeInsets.all(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(48.0),
                    child: Image.asset(
                      'assets/icon.png',
                      height: 48.0,
                      width: 48.0,
                    ),
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}

void showDonateDialog(BuildContext context) {
  showDialog(context: context, builder: (context) => const DonateDialog());
}

class DonateDialog extends StatelessWidget {
  const DonateDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(L10n.of(context).donate),
      children: [
        SimpleDialogOption(
          child: const ListTile(
            leading: Icon(SimpleIcons.github),
            title: Text('GitHub'),
            subtitle: Text('One-time or recurring'),
          ),
          onPressed: () => openUri('https://github.com/sponsors/jonjomckay'),
        ),
        SimpleDialogOption(
          child: const ListTile(
            leading: Icon(SimpleIcons.liberapay),
            title: Text('Liberapay'),
            subtitle: Text('One-time or recurring'),
          ),
          onPressed: () => openUri('https://liberapay.com/jonjomckay'),
        ),
        SimpleDialogOption(
          child: const ListTile(
            leading: Icon(SimpleIcons.paypal),
            title: Text('PayPal'),
            subtitle: Text('One-time or recurring'),
          ),
          onPressed: () => openUri('https://paypal.me/jonjomckay'),
        ),
        SimpleDialogOption(
          child: const ListTile(
            leading: Icon(SimpleIcons.bitcoin),
            title: Text('Bitcoin'),
            subtitle: Text('One-time'),
          ),
          onPressed: () async {
            await Clipboard.setData(const ClipboardData(text: '1DaXsBJVi41fgKkKcw2Ln8noygTbdD7Srg'));

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  L10n.of(context).copied_address_to_clipboard,
                ),
              ),
            );
          },
        ),
        SimpleDialogOption(
          child: const ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Credit/debit card'),
            subtitle: Text('One time'),
          ),
          onPressed: () => openUri('https://fritter.cc/donate'),
        ),
        SimpleDialogOption(
          child: const ListTile(
            leading: Icon(Icons.more_horiz),
            title: Text('Other'),
            subtitle: Text('More ways to donate'),
          ),
          onPressed: () => openUri('https://fritter.cc/donate'),
        ),
      ],
    );
  }
}

