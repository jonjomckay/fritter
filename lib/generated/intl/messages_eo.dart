// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a eo locale. All the
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
  String get localeName => 'eo';

  static String m0(name) =>
      "Ĉu vi certas, vi volas forigi la grupon de abonoj ${name}?";

  static String m1(fileName) => "Datumoj eksportiĝis al ${fileName}";

  static String m2(fullPath) => "Datumoj eksportiĝis al ${fullPath}";

  static String m3(timeagoFormat) => "Finiĝis ${timeagoFormat}";

  static String m4(timeagoFormat) => "Finiĝos ${timeagoFormat}";

  static String m5(snapshotData) => "Finiĝis kun ${snapshotData} uzantoj";

  static String m6(name) => "Grupo: ${name}";

  static String m7(snapshotData) =>
      "${snapshotData} uzantoj importiĝis ĝis nun";

  static String m8(date) => "Membriĝis je ${date}";

  static String m9(num, numFormatted) =>
      "${Intl.plural(num, zero: 'Ne voĉoj', one: 'Unu voĉo', two: 'Du voĉoj', few: '${numFormatted} voĉoj', many: '${numFormatted} voĉoj', other: '${numFormatted} voĉoj')}";

  static String m10(errorMessage) =>
      "Bonvolu kontroli vian konekton Interretan.\n\n${errorMessage}";

  static String m11(releaseVersion) => "Premu por elŝuti ${releaseVersion}";

  static String m12(getMediaType) => "Premu por vidi ${getMediaType}";

  static String m13(filePath) =>
      "La dosiero ne ekzistas. Bonvolu certigi ĝin loke ĉe ${filePath}";

  static String m14(thisTweetUserName, timeAgo) =>
      "${thisTweetUserName} repepis ${timeAgo}";

  static String m15(num, numFormatted) =>
      "${Intl.plural(num, zero: 'ne pepoj', one: 'unu pepo', two: 'du pepoj', few: '${numFormatted} pepoj', many: '${numFormatted} pepoj', other: '${numFormatted} pepoj')}";

  static String m16(widgetPlaceName) =>
      "Ne eblas ŝarĝi la tendencaĵojn el ${widgetPlaceName}";

  static String m17(responseStatusCode) =>
      "Ne eblas konservi la plurmedion. Twitter revenigis staton de ${responseStatusCode}";

  static String m18(e) => "Ne eblas sendi la ping-on. ${e}";

  static String m19(statusCode) =>
      "Ne eblis sendi la ping-on. La statkodo estis ${statusCode}";

  static String m20(releaseVersion) =>
      "Ĝisdatigu al ${releaseVersion} per via kliento de F-Droid";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Pri Fritter"),
        "account_suspended":
            MessageLookupByLibrary.simpleMessage("Konto haltiĝis"),
        "activate_non_confirmation_bias_mode_description":
            MessageLookupByLibrary.simpleMessage(
                "Kaŝi aŭtorojn de pepoj. Eviti biason de konfirmo bazite de argumentoj aŭtoritataj."),
        "activate_non_confirmation_bias_mode_label":
            MessageLookupByLibrary.simpleMessage(
                "Ŝalti reĝimon de biaso de nekonfirmo"),
        "add_to_group": MessageLookupByLibrary.simpleMessage("Aldoni al grupo"),
        "all": MessageLookupByLibrary.simpleMessage("Ĉio"),
        "all_the_great_software_used_by_fritter":
            MessageLookupByLibrary.simpleMessage(
                "Ĉiu el la programaro bonega uzate per Fritter"),
        "an_error_was_reported_to_sentry_thank_you":
            MessageLookupByLibrary.simpleMessage(
                "Eraro raportiĝis al Sentry. Dankon!"),
        "an_update_for_fritter_is_available":
            MessageLookupByLibrary.simpleMessage(
                "Ĝisdatigo por Fritter estas disponebla! 🚀"),
        "are_you_sure": MessageLookupByLibrary.simpleMessage("Ĉu vi certas?"),
        "are_you_sure_you_want_to_delete_the_subscription_group_name_of_group":
            m0,
        "back": MessageLookupByLibrary.simpleMessage("Antaŭen"),
        "bad_guest_token": MessageLookupByLibrary.simpleMessage(
            "Twitter malvalidigis la ĵetonon de atingo. Bonvolu provi remalfermi Fritter-on!"),
        "blue_theme_based_on_the_twitter_color_scheme":
            MessageLookupByLibrary.simpleMessage(
                "Blua temo bazite de la kolorskemo de Twitter"),
        "cancel": MessageLookupByLibrary.simpleMessage("Rezigni"),
        "catastrophic_failure":
            MessageLookupByLibrary.simpleMessage("Malsukceso katastrofa"),
        "choose": MessageLookupByLibrary.simpleMessage("Elekti"),
        "choose_pages": MessageLookupByLibrary.simpleMessage("Elekti paĝojn"),
        "close": MessageLookupByLibrary.simpleMessage("Fermi"),
        "confirm_close_fritter": MessageLookupByLibrary.simpleMessage(
            "Ĉu vi certas, vi volas fermi Fritter-on?"),
        "contribute": MessageLookupByLibrary.simpleMessage("Kontribui"),
        "copied_address_to_clipboard": MessageLookupByLibrary.simpleMessage(
            "Kopiis adreson al la tondujo"),
        "copied_version_to_clipboard": MessageLookupByLibrary.simpleMessage(
            "Kopiis version al la tondujo"),
        "could_not_contact_twitter": MessageLookupByLibrary.simpleMessage(
            "Ne eblas kontakti Twitter-on"),
        "could_not_find_any_tweets_by_this_user":
            MessageLookupByLibrary.simpleMessage(
                "Ne eblis trovi iujn ajn pepojn de tiu ĉi uzanto!"),
        "could_not_find_any_tweets_from_the_last_7_days":
            MessageLookupByLibrary.simpleMessage(
                "Ne eblas trovi iujn ajn pepojn de antaŭ 7 tagoj!"),
        "country": MessageLookupByLibrary.simpleMessage("Lando"),
        "dark": MessageLookupByLibrary.simpleMessage("Malhela"),
        "data": MessageLookupByLibrary.simpleMessage("Datumoj"),
        "data_exported_to_fileName": m1,
        "data_exported_to_fullPath": m2,
        "data_imported_successfully":
            MessageLookupByLibrary.simpleMessage("Datumoj importiĝis sukcese"),
        "date_created": MessageLookupByLibrary.simpleMessage("Dato de kreo"),
        "date_subscribed":
            MessageLookupByLibrary.simpleMessage("Dato de ekabono"),
        "default_tab": MessageLookupByLibrary.simpleMessage("Langeto komenca"),
        "delete": MessageLookupByLibrary.simpleMessage("Forigi"),
        "disable_screenshots":
            MessageLookupByLibrary.simpleMessage("Malŝalti ekrankopiojn"),
        "disable_screenshots_hint": MessageLookupByLibrary.simpleMessage(
            "Eviti ekrankopiojn farote. Eble ne funkcii kun ĉiuj aparatoj."),
        "disabled": MessageLookupByLibrary.simpleMessage("Malŝaltita"),
        "don_not_send": MessageLookupByLibrary.simpleMessage("Ne sendi"),
        "donate": MessageLookupByLibrary.simpleMessage("Donaci"),
        "download": MessageLookupByLibrary.simpleMessage("Elŝuti"),
        "download_handling":
            MessageLookupByLibrary.simpleMessage("Trakto de elŝutoj"),
        "download_handling_description":
            MessageLookupByLibrary.simpleMessage("Kiel elŝutado funkcius"),
        "download_handling_type_ask":
            MessageLookupByLibrary.simpleMessage("Ĉiam demandi"),
        "download_handling_type_directory":
            MessageLookupByLibrary.simpleMessage("Konservi al dosierujo"),
        "download_media_no_url": MessageLookupByLibrary.simpleMessage(
            "Ne eblas elŝuti. Tiu ĉi plurmedio eble nur estas disponebla kiel fluo, kiun Fritter ne ankoraŭ eblas elŝuti."),
        "download_path":
            MessageLookupByLibrary.simpleMessage("Dosiervojo de elŝutado"),
        "downloading_media":
            MessageLookupByLibrary.simpleMessage("Elŝutas plurmedion..."),
        "enable_sentry":
            MessageLookupByLibrary.simpleMessage("Ĉu ŝalti Sentry-on?"),
        "ended_timeago_format_endsAt_allowFromNow_true": m3,
        "ends_timeago_format_endsAt_allowFromNow_true": m4,
        "enter_your_twitter_username": MessageLookupByLibrary.simpleMessage(
            "Enigi vian uzantnomon de Twitter"),
        "export": MessageLookupByLibrary.simpleMessage("Eksporti"),
        "export_settings":
            MessageLookupByLibrary.simpleMessage("Ĉu eksporti la agordojn?"),
        "export_subscription_group_members":
            MessageLookupByLibrary.simpleMessage(
                "Ĉu eksporti la membrojn de grupo de abonoj?"),
        "export_subscription_groups": MessageLookupByLibrary.simpleMessage(
            "Ĉu eksporti la grupojn de abonoj?"),
        "export_subscriptions":
            MessageLookupByLibrary.simpleMessage("Ĉu eksporti la abonojn?"),
        "export_tweets":
            MessageLookupByLibrary.simpleMessage("Ĉu eksporti pepojn?"),
        "export_your_data":
            MessageLookupByLibrary.simpleMessage("Eksporti viajn datumojn"),
        "feed": MessageLookupByLibrary.simpleMessage("Fluo"),
        "filters": MessageLookupByLibrary.simpleMessage("Filtriloj"),
        "finished_with_snapshotData_users": m5,
        "followers": MessageLookupByLibrary.simpleMessage("Abonantoj"),
        "following": MessageLookupByLibrary.simpleMessage("Abonoj"),
        "forbidden": MessageLookupByLibrary.simpleMessage(
            "Twitter diras, atingo estas malpermesita"),
        "fritter": MessageLookupByLibrary.simpleMessage("Fritter"),
        "fritter_blue": MessageLookupByLibrary.simpleMessage("Fritter blua"),
        "general": MessageLookupByLibrary.simpleMessage("Ĝenerala"),
        "group_name": m6,
        "groups": MessageLookupByLibrary.simpleMessage("Grupoj"),
        "help_make_fritter_even_better":
            MessageLookupByLibrary.simpleMessage("Helpi plibonigi Fritter-on"),
        "help_support_fritters_future": MessageLookupByLibrary.simpleMessage(
            "Helpi subteni estontecon de Fritter"),
        "here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future":
            MessageLookupByLibrary.simpleMessage(
                "Jen datumoj kiuj sendiĝos. Si nur uziĝos por determini kiujn aparatojn kaj lingvojn subtenote de Fritter estontece."),
        "hide_sensitive_tweets":
            MessageLookupByLibrary.simpleMessage("Kaŝi sentemajn pepojn"),
        "home": MessageLookupByLibrary.simpleMessage("Hejmo"),
        "if_you_have_any_feedback_on_this_feature_please_leave_it_on":
            MessageLookupByLibrary.simpleMessage(
                "Se vi havus iujn ajn rimarkojn pri tiu ĉi eblo, bonvolu lasi ĝin ŝaltite"),
        "import": MessageLookupByLibrary.simpleMessage("Importi"),
        "import_data_from_another_device": MessageLookupByLibrary.simpleMessage(
            "Importi datumojn el alia aparato"),
        "import_from_twitter":
            MessageLookupByLibrary.simpleMessage("Importi el Twitter"),
        "import_subscriptions":
            MessageLookupByLibrary.simpleMessage("Importi abonojn"),
        "imported_snapshot_data_users_so_far": m7,
        "include_replies":
            MessageLookupByLibrary.simpleMessage("Ampleksi respondojn"),
        "include_retweets":
            MessageLookupByLibrary.simpleMessage("Ampleksi repepojn"),
        "it_looks_like_you_have_already_said_hello_from_this_version_of_fritter":
            MessageLookupByLibrary.simpleMessage(
                "Ŝajnas, vi jam diris saluton el tiu ĉi versio de Fritter!"),
        "it_looks_like_you_have_already_sent_a_ping_recently":
            MessageLookupByLibrary.simpleMessage(
                "Ŝajnas, vi jam sendis ping-on de antaŭ ne longe 🤔"),
        "joined": m8,
        "language": MessageLookupByLibrary.simpleMessage("Lingvo"),
        "language_subtitle":
            MessageLookupByLibrary.simpleMessage("Bezonas rekomencon"),
        "large": MessageLookupByLibrary.simpleMessage("Granda"),
        "legacy_android_import":
            MessageLookupByLibrary.simpleMessage("Importo de Android malnova"),
        "let_the_developers_know_if_something_is_broken":
            MessageLookupByLibrary.simpleMessage(
                "Konigi al programistojn, se io estas difektita"),
        "licenses": MessageLookupByLibrary.simpleMessage("Licencoj"),
        "light": MessageLookupByLibrary.simpleMessage("Hela"),
        "live": MessageLookupByLibrary.simpleMessage("REKTE"),
        "logging": MessageLookupByLibrary.simpleMessage("Protokolado"),
        "media": MessageLookupByLibrary.simpleMessage("Plurmedio"),
        "media_size":
            MessageLookupByLibrary.simpleMessage("Grando de plurmedio"),
        "medium": MessageLookupByLibrary.simpleMessage("Mezgranda"),
        "missing_page": MessageLookupByLibrary.simpleMessage("Paĝo manka"),
        "name": MessageLookupByLibrary.simpleMessage("Nomo"),
        "never_send": MessageLookupByLibrary.simpleMessage("Sendi neniam"),
        "newTrans": MessageLookupByLibrary.simpleMessage("Nova"),
        "no": MessageLookupByLibrary.simpleMessage("Ne"),
        "no_data_was_returned_which_should_never_happen_please_report_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "Ne datumoj revenis, kiu neniam okazu. Bonvolu raporti cimon, se eblus!"),
        "no_results": MessageLookupByLibrary.simpleMessage("Ne rezultoj"),
        "no_results_for":
            MessageLookupByLibrary.simpleMessage("Ne rezultoj por:"),
        "no_subscriptions_try_searching_or_importing_some":
            MessageLookupByLibrary.simpleMessage(
                "Ne abonoj. Provu serĉi aŭ importi iujn!"),
        "not_set": MessageLookupByLibrary.simpleMessage("Ne agordita"),
        "note_due_to_a_twitter_limitation_not_all_tweets_may_be_included":
            MessageLookupByLibrary.simpleMessage(
                "Noto: Pro limigo de Twitter, ne ĉiuj pepoj eble estas ampleksitaj"),
        "numberFormat_format_total_votes": m9,
        "ok": MessageLookupByLibrary.simpleMessage("Bone"),
        "only_public_subscriptions_can_be_imported":
            MessageLookupByLibrary.simpleMessage(
                "Abonoj nur eblas importiĝi el publikaj profiloj"),
        "oops_something_went_wrong":
            MessageLookupByLibrary.simpleMessage("Ups! Io misokazis 🥲"),
        "open_app_settings":
            MessageLookupByLibrary.simpleMessage("Montri agordojn de la apo"),
        "page_not_found": MessageLookupByLibrary.simpleMessage(
            "Twitter diras, la paĝo ne ekzistas, sed tio eble ne estas vere"),
        "permission_not_granted": MessageLookupByLibrary.simpleMessage(
            "Permeso ne doniĝis. Bonvolu provi ree post permesado!"),
        "pick_a_color": MessageLookupByLibrary.simpleMessage("Elekti koloron!"),
        "pick_an_icon": MessageLookupByLibrary.simpleMessage("Elekti ikonon!"),
        "pinned_tweet": MessageLookupByLibrary.simpleMessage("Alpinglita pepo"),
        "playback_speed":
            MessageLookupByLibrary.simpleMessage("Rapido de reproduktado"),
        "please_check_your_internet_connection_error_message": m10,
        "please_enter_a_name":
            MessageLookupByLibrary.simpleMessage("Bonvolu enigi nomon"),
        "please_make_sure_the_data_you_wish_to_import_is_located_there_then_press_the_import_button_below":
            MessageLookupByLibrary.simpleMessage(
                "Bonvolu certigi, ke la datumoj dezirate importontaj lokiĝas tie, tiam premu la butono de importi sube."),
        "please_note_that_the_method_fritter_uses_to_import_subscriptions_is_heavily_rate_limited_by_twitter_so_this_may_fail_if_you_have_a_lot_of_followed_accounts":
            MessageLookupByLibrary.simpleMessage(
                "Bonvolu noti, ke la metodon Fritter uzas por importi abonojn peze rapidolimigante de Twitter, do eble malsukcesus se vi havus tre multajn da kontojn abonitajn."),
        "possibly_sensitive":
            MessageLookupByLibrary.simpleMessage("Eble sentema"),
        "possibly_sensitive_profile": MessageLookupByLibrary.simpleMessage(
            "Tiu ĉi profilo eble enhavas eble sentemajn bildojn, idiomon, aŭ alian enhavon. Ĉu vi ankoraŭ deziras vidi ĝin?"),
        "possibly_sensitive_tweet": MessageLookupByLibrary.simpleMessage(
            "Tiu ĉi pepo enhavas enhavon eble senteman. Ĉu vi deziras vidi ĝin?"),
        "prefix": MessageLookupByLibrary.simpleMessage("prefikso"),
        "private_profile":
            MessageLookupByLibrary.simpleMessage("Profilo privata"),
        "released_under_the_mit_license": MessageLookupByLibrary.simpleMessage(
            "Eldonis per la licenco MIT-a"),
        "replying_to": MessageLookupByLibrary.simpleMessage("Respondas al"),
        "report": MessageLookupByLibrary.simpleMessage("Raporti"),
        "report_a_bug": MessageLookupByLibrary.simpleMessage("Raporti cimon"),
        "reporting_an_error":
            MessageLookupByLibrary.simpleMessage("Raporti eraron"),
        "reset_home_pages":
            MessageLookupByLibrary.simpleMessage("Reagordi paĝojn defaŭlten"),
        "retry": MessageLookupByLibrary.simpleMessage("Reprovi"),
        "save": MessageLookupByLibrary.simpleMessage("Konservi"),
        "save_bandwidth_using_smaller_images":
            MessageLookupByLibrary.simpleMessage(
                "Konservi bendlarĝon per pli malgrandaj bildoj"),
        "saved": MessageLookupByLibrary.simpleMessage("Konservitaĵoj"),
        "saved_tweet_too_large": MessageLookupByLibrary.simpleMessage(
            "Tiu ĉi pepo konservita ne eblas vidiĝi, pro ĝi estas tro granda por ŝarĝi. Bonvolu raporti al la programistoj."),
        "say_hello": MessageLookupByLibrary.simpleMessage("Diri saluton"),
        "say_hello_emoji":
            MessageLookupByLibrary.simpleMessage("Diri saluton 👋"),
        "search": MessageLookupByLibrary.simpleMessage("Serĉi"),
        "search_term": MessageLookupByLibrary.simpleMessage("Termino de serĉo"),
        "select": MessageLookupByLibrary.simpleMessage("Elekti"),
        "selecting_individual_accounts_to_import_and_assigning_groups_are_both_planned_for_the_future_already":
            MessageLookupByLibrary.simpleMessage(
                "Elektado de kontoj individuaj por importi, kaj asignado de grupoj estas ambaŭ planite estontece jam!"),
        "send": MessageLookupByLibrary.simpleMessage("Sendi"),
        "send_a_non_identifying_ping_to_let_me_know_you_are_using_fritter_and_to_help_future_development":
            MessageLookupByLibrary.simpleMessage(
                "Sendi ping-on neidentigan por konigi al mi, ke vi uzas Fritter, kaj helpi programadon estontece"),
        "send_always": MessageLookupByLibrary.simpleMessage("Sendi ĉiufoje"),
        "send_once": MessageLookupByLibrary.simpleMessage("Sendi unufoje"),
        "share_tweet_content": MessageLookupByLibrary.simpleMessage(
            "Kunhavigi la enhavon de la pepo"),
        "share_tweet_content_and_link": MessageLookupByLibrary.simpleMessage(
            "Kunhavigi la enhavon kaj ligilon de la pepo"),
        "share_tweet_link": MessageLookupByLibrary.simpleMessage(
            "Kunhavigi la ligilon de la pepo"),
        "should_check_for_updates_description":
            MessageLookupByLibrary.simpleMessage(
                "Kontroli por ĝisdatigoj kiam Fritter komenciĝus"),
        "should_check_for_updates_label":
            MessageLookupByLibrary.simpleMessage("Kontroli por ĝisdatigoj"),
        "small": MessageLookupByLibrary.simpleMessage("Malgranda"),
        "something_broke_in_fritter":
            MessageLookupByLibrary.simpleMessage("Io malfunkciis en Fritter."),
        "something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated":
            MessageLookupByLibrary.simpleMessage(
                "Io ĵus misokazis en Fritter, kaj raporto de la eraro kreiĝis. La raporto eblas sendiĝi al la programistoj de Fritter por helpi ripari la problemon."),
        "sorry_the_replied_tweet_could_not_be_found":
            MessageLookupByLibrary.simpleMessage(
                "Pardonu, la pepo alrespondita ne eblas troviĝi!"),
        "subscribe": MessageLookupByLibrary.simpleMessage("Aboni"),
        "subscriptions": MessageLookupByLibrary.simpleMessage("Abonoj"),
        "subtitles": MessageLookupByLibrary.simpleMessage("Subtekstoj"),
        "successfully_saved_the_media":
            MessageLookupByLibrary.simpleMessage("Konservis la plurmedion!"),
        "system": MessageLookupByLibrary.simpleMessage("Sistema"),
        "tap_to_download_release_version": m11,
        "tap_to_show_getMediaType_item_type": m12,
        "thanks_for_helping_fritter": MessageLookupByLibrary.simpleMessage(
            "Dankon pro helpi Fritter! 💖"),
        "thanks_for_reporting_we_will_try_and_fix_it_in_no_time":
            MessageLookupByLibrary.simpleMessage(
                "Dankon pro la raporto. Ni klopodos ripari ĝin baldaŭ!"),
        "the_file_does_not_exist_please_ensure_it_is_located_at_file_path": m13,
        "the_github_issue": MessageLookupByLibrary.simpleMessage(
            "la problemo ĉe GitHub (#143)"),
        "the_tweet_did_not_contain_any_text_this_is_unexpected":
            MessageLookupByLibrary.simpleMessage(
                "La pepo ne enhavas iun ajn tekston. Estas ne atendite"),
        "theme": MessageLookupByLibrary.simpleMessage("Temo"),
        "theme_mode": MessageLookupByLibrary.simpleMessage("Reĝimo de temo"),
        "there_were_no_trends_returned_this_is_unexpected_please_report_as_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "Ne tendencaĵoj revenis. Estas ne atendite! Bonvolu raporti kiel cimo, se eble."),
        "this_group_contains_no_subscriptions":
            MessageLookupByLibrary.simpleMessage(
                "Tiu grupo enhavas ne abonojn!"),
        "this_took_too_long_to_load_please_check_your_network_connection":
            MessageLookupByLibrary.simpleMessage(
                "La ŝarĝado daŭris tro longe. Bonvolu kontroli vian konekton Interretan!"),
        "this_tweet_is_unavailable": MessageLookupByLibrary.simpleMessage(
            "Tiu ĉi pepo estas maldisponebla. Ĝi probable foriĝis."),
        "this_tweet_user_name_retweeted": m14,
        "this_user_does_not_follow_anyone":
            MessageLookupByLibrary.simpleMessage(
                "Tiu ĉi uzanto ne observas iun ajn!"),
        "this_user_does_not_have_anyone_following_them":
            MessageLookupByLibrary.simpleMessage(
                "Tiu ĉi uzanto ne havas iun ajn observante si!"),
        "thread": MessageLookupByLibrary.simpleMessage("Diskutfadeno"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("Miniaturo"),
        "timed_out": MessageLookupByLibrary.simpleMessage("Tempolimiĝis"),
        "timed_out_trying_to_send_the_ping":
            MessageLookupByLibrary.simpleMessage(
                "Tempolimo dum trovi sendi la ping-on 😢"),
        "to_import_subscriptions_from_an_existing_twitter_account_enter_your_username_below":
            MessageLookupByLibrary.simpleMessage(
                "Por importi abonojn el ekzistanta Twitter-konto, enigi vian uzantnomon sube."),
        "toggle_all": MessageLookupByLibrary.simpleMessage("Baskuli ĉiun"),
        "trending": MessageLookupByLibrary.simpleMessage("Tendencaĵoj"),
        "trends": MessageLookupByLibrary.simpleMessage("Tendencaĵoj"),
        "true_black": MessageLookupByLibrary.simpleMessage("Nigro vera?"),
        "tweets": MessageLookupByLibrary.simpleMessage("Pepoj"),
        "tweets_and_replies":
            MessageLookupByLibrary.simpleMessage("Pepoj k. Respondoj"),
        "tweets_number": m15,
        "two_home_pages_required": MessageLookupByLibrary.simpleMessage(
            "Vi bezonas havi malpleje 2 paĝojn de hejmekrano."),
        "unable_to_find_the_available_trend_locations":
            MessageLookupByLibrary.simpleMessage(
                "Ne eblas trovi la lokojn disponeblajn de tendencoj."),
        "unable_to_find_your_saved_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Ne eblas trovi viajn pepojn konservitajn."),
        "unable_to_import":
            MessageLookupByLibrary.simpleMessage("Ne eblas importi"),
        "unable_to_load_home_pages": MessageLookupByLibrary.simpleMessage(
            "Ne eblas ŝarĝi viajn hejmpaĝojn"),
        "unable_to_load_subscription_groups":
            MessageLookupByLibrary.simpleMessage(
                "Ne eblas ŝarĝi la grupojn de abonoj"),
        "unable_to_load_the_group":
            MessageLookupByLibrary.simpleMessage("Ne eblas ŝarĝi la grupon"),
        "unable_to_load_the_group_settings":
            MessageLookupByLibrary.simpleMessage(
                "Ne eblas ŝarĝi la agordojn de grupo"),
        "unable_to_load_the_list_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Ne eblas ŝarĝi la liston de abonoj"),
        "unable_to_load_the_next_page_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Ne eblas ŝarĝi la sekvan paĝon de abonoj"),
        "unable_to_load_the_next_page_of_replies":
            MessageLookupByLibrary.simpleMessage(
                "Ne eblas ŝarĝi la sekvan paĝon de respondoj"),
        "unable_to_load_the_next_page_of_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Ne eblas ŝarĝi la sekvan paĝon de pepoj"),
        "unable_to_load_the_profile":
            MessageLookupByLibrary.simpleMessage("Ne eblas ŝarĝi la profilon"),
        "unable_to_load_the_search_results":
            MessageLookupByLibrary.simpleMessage(
                "Ne eblas ŝarĝi la rezultojn de la serĉo."),
        "unable_to_load_the_trends_for_widget_place_name": m16,
        "unable_to_load_the_tweet":
            MessageLookupByLibrary.simpleMessage("Ne eblas ŝarĝi la pepon"),
        "unable_to_load_the_tweets":
            MessageLookupByLibrary.simpleMessage("Ne eblas ŝarĝi la pepojn"),
        "unable_to_load_the_tweets_for_the_feed":
            MessageLookupByLibrary.simpleMessage(
                "Ne eblas ŝarĝi la pepojn por la fluo"),
        "unable_to_refresh_the_subscriptions":
            MessageLookupByLibrary.simpleMessage(
                "Ne eblas aktualigi la abonojn"),
        "unable_to_run_the_database_migrations":
            MessageLookupByLibrary.simpleMessage(
                "Ne eblas ruli migradojn de la datumbazo"),
        "unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode":
            m17,
        "unable_to_send_the_ping_e_to_string": m18,
        "unable_to_send_the_ping_the_status_code_was_response_statusCode": m19,
        "unable_to_stream_the_trend_location_preference":
            MessageLookupByLibrary.simpleMessage(
                "Ne eblas fluigi la agordon de loko de tendencoj"),
        "unknown": MessageLookupByLibrary.simpleMessage("Nekonata"),
        "unsave": MessageLookupByLibrary.simpleMessage("Malkonservi"),
        "unsubscribe": MessageLookupByLibrary.simpleMessage("Malaboni"),
        "unsupported_url":
            MessageLookupByLibrary.simpleMessage("URL malsubtenita"),
        "update_to_release_version_through_your_fdroid_client": m20,
        "updates": MessageLookupByLibrary.simpleMessage("Ĝisdatigoj"),
        "use_true_black_for_the_dark_mode_theme":
            MessageLookupByLibrary.simpleMessage(
                "Uzi nigron veran kun la reĝimo malhela de temo"),
        "user_not_found":
            MessageLookupByLibrary.simpleMessage("Uzanto ne troviĝis"),
        "username": MessageLookupByLibrary.simpleMessage("Uzantnomo"),
        "version": MessageLookupByLibrary.simpleMessage("Versio"),
        "when_a_new_app_update_is_available":
            MessageLookupByLibrary.simpleMessage(
                "Kiam ĝisdatigo de la apo estas disponebla"),
        "whether_errors_should_be_reported_to_sentry":
            MessageLookupByLibrary.simpleMessage(
                "Ĉu eraroj raportiĝus al Sentry"),
        "whether_to_hide_tweets_marked_as_sensitive":
            MessageLookupByLibrary.simpleMessage(
                "Ĉu kaŝi pepojn markite kiel sentemaj"),
        "which_tab_is_shown_when_the_app_opens":
            MessageLookupByLibrary.simpleMessage(
                "Kiu langeto vidiĝus kiam la apo malfermiĝus"),
        "would_you_like_to_enable_automatic_error_reporting":
            MessageLookupByLibrary.simpleMessage(
                "Ĉu vi volus ŝalti eraroraportadon aŭtomatan?"),
        "yes": MessageLookupByLibrary.simpleMessage("Jes"),
        "yes_please": MessageLookupByLibrary.simpleMessage("Jes, bonvolu"),
        "you_have_not_saved_any_tweets_yet":
            MessageLookupByLibrary.simpleMessage(
                "Vi ne konservis iujn ajn pepojn ankoraŭ!"),
        "you_must_have_at_least_2_home_screen_pages":
            MessageLookupByLibrary.simpleMessage(
                "Vi devas havi malpleje 2 paĝojn de hejmekrano"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_data_can_only_be_imported_from":
            MessageLookupByLibrary.simpleMessage(
                "Via aparato rulas version de Android pliaĝan ol KitKat (4.4), do la datumoj nur eblas importiĝi el:"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to":
            MessageLookupByLibrary.simpleMessage(
                "Via aparato rulas version de Android pliaĝan ol KitKat (4.4), do la eksporto nur eblas konserviĝi al:"),
        "your_profile_must_be_public_otherwise_the_import_will_not_work":
            MessageLookupByLibrary.simpleMessage(
                "Via profilo devas esti publika, alie la importo ne funkcios"),
        "your_report_will_be_sent_to_fritter_sentry_project":
            MessageLookupByLibrary.simpleMessage(
                "Via raporto sendiĝos al Sentry-projekto de Fritter, kaj la detaloj de privateco eblas troviĝi ĉe:")
      };
}
