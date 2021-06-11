import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fritter/client.dart';

void main() {
  testWidgets('Converting a list of tweets to a list of threads', (WidgetTester tester) async {
    var content = jsonDecode(File('test/tweets-carmack.json').readAsStringSync());

    var tweets = Twitter.createUnconversationedChains(content, 'tweet', true);

    // Ensure we have the previous and next page cursors
    expect(tweets.cursorBottom, equals('HBaEwLDBmpX46yYAAA=='));
    expect(tweets.cursorTop, equals('HCaAgIDkneTC+SYAAA=='));

    // expect(tweets.chains.length, equals(14));

    // TODO: Quoted tweets, cards

    // 1. Pinned tweet
    expect(tweets.chains[0].isPinned, equals(true));
    expect(tweets.chains[0].id, equals('1296180686215417856'));
    expect(tweets.chains[0].tweets.length, equals(1));
    expect(tweets.chains[0].tweets[0].fullText, contains('I still feel pretty good'));
    expect(tweets.chains[0].tweets[0].idStr, contains('1296180686215417856'));

    // 2. Flawless graphics + image
    expect(tweets.chains[1].isPinned, equals(false));
    expect(tweets.chains[1].id, equals('1403201368165425158'));
    expect(tweets.chains[1].tweets.length, equals(1));
    expect(tweets.chains[1].tweets[0].fullText, contains('Flawless graphics'));
    expect(tweets.chains[1].tweets[0].idStr, contains('1403201368165425158'));

    // 3. I wonder
    expect(tweets.chains[2].isPinned, equals(false));
    expect(tweets.chains[2].id, equals('1403078945847660545'));
    expect(tweets.chains[2].tweets.length, equals(1));
    expect(tweets.chains[2].tweets[0].fullText, contains('I wonder'));

    // 4. Much is made
    expect(tweets.chains[3].isPinned, equals(false));
    expect(tweets.chains[3].id, equals('1402496694940536834'));
    expect(tweets.chains[3].tweets.length, equals(1));
    expect(tweets.chains[3].tweets[0].fullText, contains('Much is made'));
    expect(tweets.chains[3].tweets[0].idStr, contains('1402496694940536834'));

    // 5. Thread
    // 5a. Bezos + URL card
    // 5b. I'm all for
    expect(tweets.chains[4].isPinned, equals(false));
    expect(tweets.chains[4].id, equals('1402046370501046277'));
    // expect(tweets.chains[4].tweets.length, equals(2));
    expect(tweets.chains[4].tweets[0].fullText, contains('Bezos is definitely'));
    expect(tweets.chains[4].tweets[0].idStr, contains('1402046370501046277'));
    expect(tweets.chains[4].tweets[1].fullText, contains('I\'m all for people'));
    expect(tweets.chains[4].tweets[1].idStr, contains('1402050538510897158'));

    // 6. Here are a few
    expect(tweets.chains[5].isPinned, equals(false));
    expect(tweets.chains[5].id, equals('1402035761063641090'));
    expect(tweets.chains[5].tweets.length, equals(1));
    expect(tweets.chains[5].tweets[0].fullText, contains('Here are a few'));
    expect(tweets.chains[5].tweets[0].idStr, contains('1402035761063641090'));

    // 7. It is interesting
    expect(tweets.chains[6].isPinned, equals(false));
    expect(tweets.chains[6].id, equals('1401959248507047948'));
    expect(tweets.chains[6].tweets.length, equals(1));
    expect(tweets.chains[6].tweets[0].fullText, contains('It is interesting'));
    expect(tweets.chains[6].tweets[0].idStr, contains('1401959248507047948'));

    // 8. Thread
    // 8a. The vast majority
    // 8b. a good path
    // 8c. external image
    expect(tweets.chains[7].isPinned, equals(false));
    expect(tweets.chains[7].id, equals('1400930510671601666'));
    // expect(tweets.chains[7].tweets.length, equals(3));
    expect(tweets.chains[7].tweets[0].fullText, contains('The vast majority'));
    expect(tweets.chains[7].tweets[0].idStr, contains('1400930510671601666'));
    expect(tweets.chains[7].tweets[1].fullText, contains('a good path'));
    expect(tweets.chains[7].tweets[1].idStr, contains('1400930512491909121'));
    expect(tweets.chains[7].tweets[2].fullText, contains('external image'));
    expect(tweets.chains[7].tweets[2].idStr, contains('1400930514073182208'));

    // 9. Doing some work
    expect(tweets.chains[8].isPinned, equals(false));
    expect(tweets.chains[8].id, equals('1400683014229839874'));
    expect(tweets.chains[8].tweets.length, equals(1));
    expect(tweets.chains[8].tweets[0].fullText, contains('Doing some work'));
    expect(tweets.chains[8].tweets[0].idStr, contains('1400683014229839874'));

    // 10. Thread
    // 10a. Tile based rasterization
    // 10b. getting into the datacenter
    // 10c. postprocess. A "smart monitor"
    expect(tweets.chains[9].isPinned, equals(false));
    expect(tweets.chains[9].id, equals('1399949152545611778'));
    // expect(tweets.chains[9].tweets.length, equals(3));
    expect(tweets.chains[9].tweets[0].fullText, contains('Tiled based rasterization'));
    expect(tweets.chains[9].tweets[0].idStr, contains('1399949152545611778'));
    expect(tweets.chains[9].tweets[1].fullText, contains('getting into the datacenter'));
    expect(tweets.chains[9].tweets[1].idStr, contains('1399949153547993088'));
    expect(tweets.chains[9].tweets[2].fullText, contains('postprocess. A "smart monitor"'));
    expect(tweets.chains[9].tweets[2].idStr, contains('1399949154412118029'));

    // 11. On top of my recurring + quoted tweet
    expect(tweets.chains[10].isPinned, equals(false));
    expect(tweets.chains[10].id, equals('1399827603654066187'));
    expect(tweets.chains[10].tweets.length, equals(1));
    expect(tweets.chains[10].tweets[0].fullText, contains('On top of my recurring'));
    expect(tweets.chains[10].tweets[0].idStr, contains('1399827603654066187'));

    // 12. State of the art + quoted tweet
    expect(tweets.chains[11].isPinned, equals(false));
    expect(tweets.chains[11].id, equals('1399722752047730691'));
    expect(tweets.chains[11].tweets.length, equals(1));
    expect(tweets.chains[11].tweets[0].fullText, contains('State of the art'));
    expect(tweets.chains[11].tweets[0].idStr, contains('1399722752047730691'));

    // 13. Has there been any + URL card
    expect(tweets.chains[12].isPinned, equals(false));
    expect(tweets.chains[12].id, equals('1399584217030348803'));
    expect(tweets.chains[12].tweets.length, equals(1));
    expect(tweets.chains[12].tweets[0].fullText, contains('Has there been any'));
    expect(tweets.chains[12].tweets[0].idStr, contains('1399584217030348803'));

    // 14. The flexibility to add
    expect(tweets.chains[13].isPinned, equals(false));
    expect(tweets.chains[13].id, equals('1399476356354805762'));
    expect(tweets.chains[13].tweets.length, equals(1));
    expect(tweets.chains[13].tweets[0].fullText, contains('The flexibility to add'));
    expect(tweets.chains[13].tweets[0].idStr, contains('1399476356354805762'));

    // Build our app and trigger a frame.
    // await tester.pumpWidget(MyApp());
    //
    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);
    //
    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //
    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
