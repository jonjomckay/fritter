// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ja';

  static String m0(name) => "購読グループ${name}を削除してもよろしいですか？";

  static String m1(fileName) => "データが${fileName}にエクスポートされました";

  static String m2(fullPath) => "データが${fullPath}にエクスポートされました";

  static String m3(timeagoFormat) => "${timeagoFormat}に終了";

  static String m4(timeagoFormat) => "${timeagoFormat}に終了";

  static String m5(snapshotData) => "${snapshotData}ユーザのインポートが完了しました";

  static String m6(snapshotData) => "${snapshotData}ユーザがインポートされました";

  static String m7(date) => "${date}に登録";

  static String m8(num, numFormatted) =>
      "${Intl.plural(num, zero: '0 票', one: '1 票', two: '2 票', few: '${numFormatted} 票', many: '${numFormatted} 票', other: '${numFormatted} 票')}";

  static String m9(errorMessage) => "インターネット接続を確認してください。\n\n${errorMessage}";

  static String m10(releaseVersion) => "タップしてダウンロード：${releaseVersion}";

  static String m11(getMediaType) => "タップして${getMediaType}を表示";

  static String m12(state) => "接続状態${state}はサポートされていません";

  static String m13(filePath) => "ファイルが存在しません。${filePath}に存在することを確認してください";

  static String m14(thisTweetUserName) => "${thisTweetUserName}がリツイート";

  static String m15(num, numFormatted) =>
      "${Intl.plural(num, zero: '0 ツイート', one: '1 ツイート', two: '2 ツイート', few: '${numFormatted} ツイート', many: '${numFormatted} ツイート', other: '${numFormatted} ツイート')}";

  static String m16(widgetPlaceName) => "${widgetPlaceName}のトレンドを読み込めませんでした";

  static String m17(e) => "購読を更新できませんでした。エラー：${e}";

  static String m18(responseStatusCode) =>
      "メディアを保存できませんでした。Twitterから返されたステータス：${responseStatusCode}";

  static String m19(e) => "Pingの送信に失敗しました。${e}";

  static String m20(statusCode) => "Pingを送信できませんでした。ステータスコード：${statusCode}";

  static String m21(releaseVersion) => "F-Droidクライアントから${releaseVersion}に更新";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Fritterについて"),
        "account_suspended": MessageLookupByLibrary.simpleMessage("凍結済みアカウント"),
        "add_to_group": MessageLookupByLibrary.simpleMessage("グループに追加"),
        "all": MessageLookupByLibrary.simpleMessage("すべて"),
        "all_the_great_software_used_by_fritter":
            MessageLookupByLibrary.simpleMessage("Fritterが使用するすばらしいソフトウェア"),
        "an_error_was_reported_to_sentry_thank_you":
            MessageLookupByLibrary.simpleMessage(
                "エラーがSentoryに送信されました。ありがとうございました！"),
        "an_update_for_fritter_is_available":
            MessageLookupByLibrary.simpleMessage("Fritterの更新が利用可能です！🚀"),
        "are_you_sure": MessageLookupByLibrary.simpleMessage("よろしいですか？"),
        "are_you_sure_you_want_to_delete_the_subscription_group_name_of_group":
            m0,
        "back": MessageLookupByLibrary.simpleMessage("戻る"),
        "blue_theme_based_on_the_twitter_color_scheme":
            MessageLookupByLibrary.simpleMessage("Twitterの配色に基づいたブルーのテーマ"),
        "cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
        "catastrophic_failure": MessageLookupByLibrary.simpleMessage("致命的なエラー"),
        "contribute": MessageLookupByLibrary.simpleMessage("貢献する"),
        "copied_address_to_clipboard":
            MessageLookupByLibrary.simpleMessage("アドレスをクリップボードにコピーしました"),
        "copied_version_to_clipboard":
            MessageLookupByLibrary.simpleMessage("バージョンをクリップボードにコピーしました"),
        "could_not_contact_twitter":
            MessageLookupByLibrary.simpleMessage("Twitterにアクセスできませんでした"),
        "could_not_find_any_tweets_by_this_user":
            MessageLookupByLibrary.simpleMessage("このユーザのツイートが見つかりません！"),
        "could_not_find_any_tweets_from_the_last_7_days":
            MessageLookupByLibrary.simpleMessage("過去7日間にツイートが見つかりませんでした！"),
        "country": MessageLookupByLibrary.simpleMessage("国"),
        "dark": MessageLookupByLibrary.simpleMessage("ダーク"),
        "data": MessageLookupByLibrary.simpleMessage("データ"),
        "data_exported_to_fileName": m1,
        "data_exported_to_fullPath": m2,
        "data_imported_successfully":
            MessageLookupByLibrary.simpleMessage("データのインポートに成功しました"),
        "date_created": MessageLookupByLibrary.simpleMessage("作成日"),
        "date_subscribed": MessageLookupByLibrary.simpleMessage("購読開始日"),
        "default_tab": MessageLookupByLibrary.simpleMessage("デフォルトのタブ"),
        "delete": MessageLookupByLibrary.simpleMessage("削除"),
        "disabled": MessageLookupByLibrary.simpleMessage("無効"),
        "don_not_send": MessageLookupByLibrary.simpleMessage("送信しない"),
        "donate": MessageLookupByLibrary.simpleMessage("寄付"),
        "download": MessageLookupByLibrary.simpleMessage("ダウンロード"),
        "downloading_media":
            MessageLookupByLibrary.simpleMessage("メディアをダウンロード中..."),
        "enable_sentry": MessageLookupByLibrary.simpleMessage("Sentryを有効化する？"),
        "ended_timeago_format_endsAt_allowFromNow_true": m3,
        "ends_timeago_format_endsAt_allowFromNow_true": m4,
        "enter_your_twitter_username":
            MessageLookupByLibrary.simpleMessage("Twitterユーザ名を入力"),
        "export": MessageLookupByLibrary.simpleMessage("エクスポート"),
        "export_settings": MessageLookupByLibrary.simpleMessage("設定をエクスポート？"),
        "export_subscription_group_members":
            MessageLookupByLibrary.simpleMessage("購読グループのメンバーをエクスポート？"),
        "export_subscription_groups":
            MessageLookupByLibrary.simpleMessage("購読グループをエクスポート？"),
        "export_subscriptions":
            MessageLookupByLibrary.simpleMessage("購読をエクスポート？"),
        "export_tweets": MessageLookupByLibrary.simpleMessage("ツイートをエクスポート？"),
        "export_your_data": MessageLookupByLibrary.simpleMessage("データのエクスポート"),
        "feed": MessageLookupByLibrary.simpleMessage("フィード"),
        "filters": MessageLookupByLibrary.simpleMessage("フィルタ"),
        "finished_with_snapshotData_users": m5,
        "followers": MessageLookupByLibrary.simpleMessage("フォロワー"),
        "following": MessageLookupByLibrary.simpleMessage("フォロー"),
        "fritter": MessageLookupByLibrary.simpleMessage("Fritter"),
        "fritter_blue": MessageLookupByLibrary.simpleMessage("Fritterブルー"),
        "general": MessageLookupByLibrary.simpleMessage("一般"),
        "groups": MessageLookupByLibrary.simpleMessage("グループ"),
        "help_make_fritter_even_better":
            MessageLookupByLibrary.simpleMessage("Fritterを改善するために協力する"),
        "help_support_fritters_future":
            MessageLookupByLibrary.simpleMessage("Fritterの将来を支援する"),
        "here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future":
            MessageLookupByLibrary.simpleMessage(
                "以下が送信されるデータです。今後Fritterがサポートすべき端末と言語を特定するためにのみ使用されます。"),
        "if_you_have_any_feedback_on_this_feature_please_leave_it_on":
            MessageLookupByLibrary.simpleMessage(
                "この機能にフィードバックがありましたら、こちらにお願いします"),
        "import": MessageLookupByLibrary.simpleMessage("インポート"),
        "import_data_from_another_device":
            MessageLookupByLibrary.simpleMessage("他の端末からデータをインポートする"),
        "import_from_twitter":
            MessageLookupByLibrary.simpleMessage("Twitterからインポート"),
        "import_subscriptions":
            MessageLookupByLibrary.simpleMessage("購読をインポートする"),
        "imported_snapshot_data_users_so_far": m6,
        "include_replies": MessageLookupByLibrary.simpleMessage("返信を含める"),
        "include_retweets": MessageLookupByLibrary.simpleMessage("リツイートを含める"),
        "it_looks_like_you_have_already_said_hello_from_this_version_of_fritter":
            MessageLookupByLibrary.simpleMessage(
                "既にこのバージョンのFritterからあいさつを送っているようです！"),
        "it_looks_like_you_have_already_sent_a_ping_recently":
            MessageLookupByLibrary.simpleMessage("既に最近pingを送信しているようです。🤔"),
        "joined": m7,
        "large": MessageLookupByLibrary.simpleMessage("大"),
        "legacy_android_import":
            MessageLookupByLibrary.simpleMessage("インポート(レガシー端末)"),
        "let_the_developers_know_if_something_is_broken":
            MessageLookupByLibrary.simpleMessage("不都合を開発者に知らせる"),
        "licenses": MessageLookupByLibrary.simpleMessage("ライセンス"),
        "light": MessageLookupByLibrary.simpleMessage("ライト"),
        "live": MessageLookupByLibrary.simpleMessage("ライブ"),
        "logging": MessageLookupByLibrary.simpleMessage("ログ"),
        "media": MessageLookupByLibrary.simpleMessage("メディア"),
        "media_size": MessageLookupByLibrary.simpleMessage("メディアの大きさ"),
        "medium": MessageLookupByLibrary.simpleMessage("中"),
        "name": MessageLookupByLibrary.simpleMessage("グループ名"),
        "never_send": MessageLookupByLibrary.simpleMessage("今後送信しない"),
        "newTrans": MessageLookupByLibrary.simpleMessage("新着"),
        "no": MessageLookupByLibrary.simpleMessage("いいえ"),
        "no_data_was_returned_which_should_never_happen_please_report_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "データが返されませんでした。これは起こりえないことです。可能でしたらバグとして報告ください！"),
        "no_results": MessageLookupByLibrary.simpleMessage("結果なし"),
        "no_subscriptions_try_searching_or_importing_some":
            MessageLookupByLibrary.simpleMessage(
                "購読がありません。検索するか、インポートしてみてください！"),
        "note_due_to_a_twitter_limitation_not_all_tweets_may_be_included":
            MessageLookupByLibrary.simpleMessage(
                "注意：ツイッターの制限により、全てのツイートが含まれない可能性があります"),
        "numberFormat_format_total_votes": m8,
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "oops_something_went_wrong":
            MessageLookupByLibrary.simpleMessage("問題が発生しました🥲"),
        "pick_a_color": MessageLookupByLibrary.simpleMessage("色を選択！"),
        "pinned_tweet": MessageLookupByLibrary.simpleMessage("固定ツイート"),
        "playback_speed": MessageLookupByLibrary.simpleMessage("再生速度"),
        "please_check_your_internet_connection_error_message": m9,
        "please_enter_a_name":
            MessageLookupByLibrary.simpleMessage("グループ名を入力してください"),
        "please_make_sure_the_data_you_wish_to_import_is_located_there_then_press_the_import_button_below":
            MessageLookupByLibrary.simpleMessage(
                "インポートしたいデータが存在することを確認し、下のインポートボタンを押してください。"),
        "please_note_that_the_method_fritter_uses_to_import_subscriptions_is_heavily_rate_limited_by_twitter_so_this_may_fail_if_you_have_a_lot_of_followed_accounts":
            MessageLookupByLibrary.simpleMessage(
                "Fritterが購読をインポートする際に使うメソッドはTwitterにより厳しくレート制限されているため、フォローアカウントが多い場合は失敗する可能性があります。"),
        "prefix": MessageLookupByLibrary.simpleMessage("プレフィックス"),
        "private_profile": MessageLookupByLibrary.simpleMessage("非公開プロフィール"),
        "released_under_the_mit_license":
            MessageLookupByLibrary.simpleMessage("MITライセンスで公開"),
        "replying_to": MessageLookupByLibrary.simpleMessage("返信："),
        "report": MessageLookupByLibrary.simpleMessage("レポート"),
        "report_a_bug": MessageLookupByLibrary.simpleMessage("バグのレポート"),
        "reporting_an_error": MessageLookupByLibrary.simpleMessage("エラーの報告"),
        "retry": MessageLookupByLibrary.simpleMessage("リトライ"),
        "save": MessageLookupByLibrary.simpleMessage("保存"),
        "save_bandwidth_using_smaller_images":
            MessageLookupByLibrary.simpleMessage("小さい画像を使用すると通信容量を削減できます"),
        "saved": MessageLookupByLibrary.simpleMessage("保存したツイート"),
        "say_hello": MessageLookupByLibrary.simpleMessage("あいさつする"),
        "say_hello_emoji": MessageLookupByLibrary.simpleMessage("あいさつする👋"),
        "selecting_individual_accounts_to_import_and_assigning_groups_are_both_planned_for_the_future_already":
            MessageLookupByLibrary.simpleMessage(
                "インポートするアカウントの選択やグループへの割り当ては今後対応予定です！"),
        "send": MessageLookupByLibrary.simpleMessage("送信"),
        "send_a_non_identifying_ping_to_let_me_know_you_are_using_fritter_and_to_help_future_development":
            MessageLookupByLibrary.simpleMessage(
                "Fritterを使用していることを示す匿名のpingを開発者に送り、今後の開発を支援する"),
        "send_always": MessageLookupByLibrary.simpleMessage("いつも送信する"),
        "send_once": MessageLookupByLibrary.simpleMessage("今回だけ送信"),
        "share_tweet_content":
            MessageLookupByLibrary.simpleMessage("ツイート内容を共有"),
        "share_tweet_link": MessageLookupByLibrary.simpleMessage("ツイートリンクを共有"),
        "small": MessageLookupByLibrary.simpleMessage("小"),
        "something_broke_in_fritter":
            MessageLookupByLibrary.simpleMessage("Fritterに異常が発生しました。"),
        "something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated":
            MessageLookupByLibrary.simpleMessage(
                "Fritterに問題が発生し、エラーレポートが作成されました。問題を修正するため、開発者にレポートを送信することができます。"),
        "sorry_the_replied_tweet_could_not_be_found":
            MessageLookupByLibrary.simpleMessage("返信ツイートが見つかりませんでした！"),
        "subscribe": MessageLookupByLibrary.simpleMessage("購読する"),
        "subscriptions": MessageLookupByLibrary.simpleMessage("購読"),
        "subtitles": MessageLookupByLibrary.simpleMessage("字幕"),
        "successfully_saved_the_media":
            MessageLookupByLibrary.simpleMessage("メディアの保存に成功しました！"),
        "system": MessageLookupByLibrary.simpleMessage("システム"),
        "tap_to_download_release_version": m10,
        "tap_to_show_getMediaType_item_type": m11,
        "thanks_for_helping_fritter":
            MessageLookupByLibrary.simpleMessage("Fritterを支援いただきありがとうございます！💖"),
        "thanks_for_reporting_we_will_try_and_fix_it_in_no_time":
            MessageLookupByLibrary.simpleMessage(
                "レポートありがとうございます。できるだけ早く修正いたします！"),
        "the_connection_state_state_is_not_supported": m12,
        "the_file_does_not_exist_please_ensure_it_is_located_at_file_path": m13,
        "the_tweet_did_not_contain_any_text_this_is_unexpected":
            MessageLookupByLibrary.simpleMessage("ツイートのテキストがありません。予期せぬ結果です"),
        "theme": MessageLookupByLibrary.simpleMessage("テーマ"),
        "there_were_no_trends_returned_this_is_unexpected_please_report_as_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "トレンドが返されませんでした。予期せぬ動作です！可能でしたらバグとして報告ください。"),
        "this_group_contains_no_subscriptions":
            MessageLookupByLibrary.simpleMessage("このグループは空です！"),
        "this_took_too_long_to_load_please_check_your_network_connection":
            MessageLookupByLibrary.simpleMessage(
                "読み込みに時間がかかり過ぎています。ネットワーク接続を確認してください！"),
        "this_tweet_is_unavailable":
            MessageLookupByLibrary.simpleMessage("ツイートが利用できません"),
        "this_tweet_user_name_retweeted": m14,
        "this_user_does_not_follow_anyone":
            MessageLookupByLibrary.simpleMessage("このユーザは誰もフォローしていません！"),
        "this_user_does_not_have_anyone_following_them":
            MessageLookupByLibrary.simpleMessage("このユーザをフォローしている人はいません！"),
        "thread": MessageLookupByLibrary.simpleMessage("スレッド"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("サムネイル"),
        "timed_out": MessageLookupByLibrary.simpleMessage("タイムアウト"),
        "timed_out_trying_to_send_the_ping":
            MessageLookupByLibrary.simpleMessage("Pingの送信がタイムアウトしました😢"),
        "to_import_subscriptions_from_an_existing_twitter_account_enter_your_username_below":
            MessageLookupByLibrary.simpleMessage(
                "Twitterアカウントから購読をインポートするには、以下にユーザ名を入力してください。"),
        "toggle_all": MessageLookupByLibrary.simpleMessage("全て選択"),
        "trending": MessageLookupByLibrary.simpleMessage("トレンド"),
        "trends": MessageLookupByLibrary.simpleMessage("トレンド"),
        "true_black": MessageLookupByLibrary.simpleMessage("完全な黒？"),
        "tweets": MessageLookupByLibrary.simpleMessage("ツイート"),
        "tweets_and_replies": MessageLookupByLibrary.simpleMessage("ツイートと返信"),
        "tweets_number": m15,
        "unable_to_check_if_this_is_a_legacy_Android_device":
            MessageLookupByLibrary.simpleMessage("レガシーAndroid端末か判定できませんでした。"),
        "unable_to_find_the_app_package_info":
            MessageLookupByLibrary.simpleMessage("アプリのパッケージ情報が見つかりませんでした"),
        "unable_to_find_the_available_trend_locations":
            MessageLookupByLibrary.simpleMessage("利用可能なトレンドの地域が見つかりませんでした。"),
        "unable_to_find_your_saved_tweets":
            MessageLookupByLibrary.simpleMessage("保存したツイートが見つかりませんでした。"),
        "unable_to_import":
            MessageLookupByLibrary.simpleMessage("インポートできませんでした"),
        "unable_to_load_subscription_groups":
            MessageLookupByLibrary.simpleMessage("購読グループの読み込みに失敗しました"),
        "unable_to_load_the_group":
            MessageLookupByLibrary.simpleMessage("グループの読み込みに失敗しました"),
        "unable_to_load_the_group_settings":
            MessageLookupByLibrary.simpleMessage("グループ設定の読み込みに失敗しました"),
        "unable_to_load_the_list_of_follows":
            MessageLookupByLibrary.simpleMessage("フォローリストを読み込めませんでした"),
        "unable_to_load_the_next_page_of_follows":
            MessageLookupByLibrary.simpleMessage("次ページのフォローを読み込めませんでした"),
        "unable_to_load_the_next_page_of_replies":
            MessageLookupByLibrary.simpleMessage("次ページの返信の読み込みに失敗しました"),
        "unable_to_load_the_next_page_of_tweets":
            MessageLookupByLibrary.simpleMessage("次ページのツイートの読み込みに失敗しました"),
        "unable_to_load_the_profile":
            MessageLookupByLibrary.simpleMessage("プロフィールを読み込めませんでした"),
        "unable_to_load_the_search_results":
            MessageLookupByLibrary.simpleMessage("検索結果の読み込みに失敗しました。"),
        "unable_to_load_the_trends_for_widget_place_name": m16,
        "unable_to_load_the_tweet":
            MessageLookupByLibrary.simpleMessage("ツイートの読み込みに失敗しました"),
        "unable_to_load_the_tweets":
            MessageLookupByLibrary.simpleMessage("ツイートを読み込めませんでした"),
        "unable_to_load_the_tweets_for_the_feed":
            MessageLookupByLibrary.simpleMessage("フィードにツイートを読み込めませんでした"),
        "unable_to_refresh_the_subscriptions_the_error_was_e": m17,
        "unable_to_run_the_database_migrations":
            MessageLookupByLibrary.simpleMessage("データベース移行ができませんでした"),
        "unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode":
            m18,
        "unable_to_send_the_ping_e_to_string": m19,
        "unable_to_send_the_ping_the_status_code_was_response_statusCode": m20,
        "unable_to_stream_the_trend_location_preference":
            MessageLookupByLibrary.simpleMessage("トレンドの地域設定をストリームできませんでした"),
        "unknown": MessageLookupByLibrary.simpleMessage("不明"),
        "unsave": MessageLookupByLibrary.simpleMessage("保存取り消し"),
        "unsubscribe": MessageLookupByLibrary.simpleMessage("購読を解除する"),
        "update_to_release_version_through_your_fdroid_client": m21,
        "updates": MessageLookupByLibrary.simpleMessage("更新"),
        "use_true_black_for_the_dark_mode_theme":
            MessageLookupByLibrary.simpleMessage("ダークテーマで完全な黒を使用する"),
        "user_not_found": MessageLookupByLibrary.simpleMessage("ユーザが見つかりません"),
        "username": MessageLookupByLibrary.simpleMessage("ユーザ名"),
        "version": MessageLookupByLibrary.simpleMessage("バージョン"),
        "when_a_new_app_update_is_available":
            MessageLookupByLibrary.simpleMessage("新しいアプリの更新が利用可能なとき"),
        "whether_errors_should_be_reported_to_sentry":
            MessageLookupByLibrary.simpleMessage("エラーをSentryに送信するか"),
        "which_tab_is_shown_when_the_app_opens":
            MessageLookupByLibrary.simpleMessage("アプリを起動したときにどのタブを表示するか"),
        "would_you_like_to_enable_automatic_error_reporting":
            MessageLookupByLibrary.simpleMessage("自動エラー報告を有効にしますか？"),
        "yes": MessageLookupByLibrary.simpleMessage("はい"),
        "you_have_not_saved_any_tweets_yet":
            MessageLookupByLibrary.simpleMessage("まだツイートを保存していません！"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_data_can_only_be_imported_from":
            MessageLookupByLibrary.simpleMessage(
                "KitKat (4.4)以前のAndroidバージョンで動作しているため、エクスポートでは以下の場所のみに保存できます："),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to":
            MessageLookupByLibrary.simpleMessage(
                "KitKat (4.4)以前のAndroidバージョンで動作しているため、エクスポートでは以下の場所のみに保存できます："),
        "your_profile_must_be_public_otherwise_the_import_will_not_work":
            MessageLookupByLibrary.simpleMessage("インポートにはアカウントが公開されている必要があります"),
        "your_report_will_be_sent_to_fritter_sentry_project":
            MessageLookupByLibrary.simpleMessage(
                "レポートはFritterのSentryプロジェクトに送信されます。プライバシーの詳細は以下の通りです：")
      };
}
