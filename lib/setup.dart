import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:fritter/constants.dart';
import 'package:fritter/generated/l10n.dart';
import 'package:fritter/utils/urls.dart';
import 'package:pref/pref.dart';

class WizardPage {
  final String title;
  final Widget child;

  WizardPage(this.title, this.child);
}

class SetupWizard extends StatelessWidget {
  final PageController _pageController = PageController();

  SetupWizard({Key? key}) : super(key: key);

  void onStepComplete() {
    var page = _pageController.page;
    if (page == null) {
      return;
    }

    _pageController.nextPage(duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: L10n
    final wizardPages = [
      WizardPage('Welcome to Fritter!', Step1(onComplete: onStepComplete)),
      WizardPage('Errors', Step2(onComplete: onStepComplete)),
      WizardPage('TODO', Step1(onComplete: onStepComplete)),
    ];

    return Scaffold(
      appBar: AppBar(
        title: AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            var page = _pageController.page;
            if (page == null) {
              return Container();
            }

            return Text(wizardPages[page.toInt()].title);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: wizardPages.map((e) => e.child).toList(),
          ),
        ),
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          var page = _pageController.page;
          if (page == null) {
            return Container();
          }

          Widget prevButton;
          if (page > 0) {
            prevButton = TextButton.icon(
                label: Text(L10n.current.back),
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _pageController.previousPage(duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
                });
          } else {
            prevButton =
                TextButton.icon(label: Text(L10n.current.back), icon: const Icon(Icons.arrow_back), onPressed: null);
          }

          Widget nextButton;
          if (page == wizardPages.length - 1) {
            nextButton = TextButton.icon(
                label: Text(L10n.current.finish),
                icon: const Icon(Icons.done),
                onPressed: () async {
                  // TODO: Store the prefs and stuff
                  await PrefService.of(context).set(optionWizardCompleted, true);
                });
          } else {
            nextButton = TextButton.icon(
                label: Text(L10n.current.next),
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  _pageController.nextPage(duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
                });
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              prevButton,
              nextButton,
            ],
          );
        },
      ),
    );
  }
}

typedef StepComplete = Function();

class Step1 extends StatelessWidget {
  final StepComplete onComplete;

  const Step1({Key? key, required this.onComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('step 1'),
        TextButton.icon(
          label: Text('Hi'),
          icon: Icon(Icons.face),
          onPressed: () => onComplete(),
        )
      ],
    );
  }
}

class Step2 extends StatelessWidget {
  final StepComplete onComplete;

  const Step2({Key? key, required this.onComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Whenever something goes wrong with Fritter, an error report will be generated. The report can be sent to the Fritter developers to help fix the problem.'),
            const SizedBox(height: 16),
            Text(
              L10n.of(context).would_you_like_to_enable_automatic_error_reporting,
            ),
            const SizedBox(height: 16),
            Text(
              L10n.of(context).your_report_will_be_sent_to_fritter_sentry_project,
            ),
            const SizedBox(height: 16),
            InkWell(
              child: const Text('https://fritter.cc/privacy', style: TextStyle(color: Colors.blue)),
              onTap: () async => await openUri('https://fritter.cc/privacy'),
            ),
            const SizedBox(height: 16),
            const Text('Please note that this can also be enabled or disabled later, in the Settings screen.', style: TextStyle(
              fontStyle: FontStyle.italic
            )),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AsyncButtonBuilder(
              successDuration: const Duration(days: 1),
              builder: (context, child, callback, buttonState) {
                return TextButton.icon(
                  label: Text(L10n.current.no),
                  icon: child,
                  onPressed: callback,
                );
              },
              onPressed: () async {
                // return PrefService.of(context).set(optionErrorsSentryEnabled, false);
                onComplete();
              },
              child: const Icon(Icons.close),
            ),
            TextButton.icon(
              label: Text(L10n.current.yes_please),
              icon: Icon(Icons.check),
              onPressed: () {
                PrefService.of(context).set(optionErrorsSentryEnabled, true);
              },
            ),
          ],
        ),
      ],
    );
  }
}
