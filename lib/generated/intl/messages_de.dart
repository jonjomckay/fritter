// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(name) =>
      "Sind Sie sicher, dass Sie die Abonnementgruppe ${name} löschen wollen?";

  static String m1(fileName) => "Daten wurden exportiert nach ${fileName}";

  static String m2(fullPath) => "Daten wurden exportiert nach ${fullPath}";

  static String m3(timeagoFormat) => "Beendet seit ${timeagoFormat}";

  static String m4(timeagoFormat) => "Endet ${timeagoFormat}";

  static String m5(snapshotData) =>
      "Beendet mit insgesamt ${snapshotData} Nutzern";

  static String m7(snapshotData) =>
      "${snapshotData} bisher importierte Benutzer";

  static String m8(date) => "Beigetreten am ${date}";

  static String m9(num, numFormatted) =>
      "{Anzahl, Plural, Keine{Keine Stimmen} Eine{Eine Stimme} Zwei{Zwei Stimmen} Einige{${numFormatted} Stimmen} Viele{${numFormatted} Stimmen} Andere{${numFormatted} Stimmen}}";

  static String m10(errorMessage) =>
      "Bitte Internetverbindung überprüfen.\n\n\n${errorMessage}";

  static String m11(releaseVersion) =>
      "Antippen, um Version ${releaseVersion} herunterzuladen";

  static String m12(getMediaType) => "Antippen, um ${getMediaType} anzuzeigen";

  static String m13(filePath) =>
      "Diese Datei existiert nicht. Bitte stellen Sie sicher, dass sie sich in folgendem Verzeichnis befindet: ${filePath}";

  static String m14(thisTweetUserName, timeAgo) =>
      "Re-Tweet durch ${thisTweetUserName}";

  static String m15(num, numFormatted) =>
      "{Anzahl, Plural, Keiner{keine Tweets} Einer{ein Tweet} Zwei{zwei Tweets} Einige{${numFormatted} Tweets} Viele{${numFormatted} Tweets} Andere{${numFormatted} Tweets}}";

  static String m16(widgetPlaceName) =>
      "Trends für ${widgetPlaceName} konnten nicht geladen werden";

  static String m17(responseStatusCode) =>
      "Medien konnten nicht gespeichert werden. Twitter gab folgenden Statuscode zurück: ${responseStatusCode}";

  static String m18(e) => "Der Ping konnte nicht gesendet werden. ${e}";

  static String m19(statusCode) =>
      "Der Ping konnte nicht gesendet werden. Der Status-Code lautet ${statusCode}";

  static String m20(releaseVersion) =>
      "Update auf Version ${releaseVersion} über Ihren F-Droid-Client";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Über"),
        "account_suspended":
            MessageLookupByLibrary.simpleMessage("Nutzerkonto gesperrt"),
        "activate_non_confirmation_bias_mode_description":
            MessageLookupByLibrary.simpleMessage(
                "Autor eines Tweets verstecken. Vermeide Bestätigungsfehler durch Autoritätsargumente."),
        "activate_non_confirmation_bias_mode_label":
            MessageLookupByLibrary.simpleMessage(
                "Anti-Bestätigungsfehler-Modus aktivieren"),
        "add_to_group":
            MessageLookupByLibrary.simpleMessage("Zur Gruppe hinzufügen"),
        "all": MessageLookupByLibrary.simpleMessage("Alles"),
        "all_the_great_software_used_by_fritter":
            MessageLookupByLibrary.simpleMessage(
                "Die gesamte tolle Software, die von Fritter verwendet wird"),
        "an_error_was_reported_to_sentry_thank_you":
            MessageLookupByLibrary.simpleMessage(
                "Der Fehler wurde Sentry gemeldet. Vielen Dank!"),
        "an_update_for_fritter_is_available":
            MessageLookupByLibrary.simpleMessage(
                "Ein Update für Fritter ist verfügbar! 🚀"),
        "are_you_sure":
            MessageLookupByLibrary.simpleMessage("Sind Sie sicher?"),
        "are_you_sure_you_want_to_delete_the_subscription_group_name_of_group":
            m0,
        "back": MessageLookupByLibrary.simpleMessage("Zurück"),
        "blue_theme_based_on_the_twitter_color_scheme":
            MessageLookupByLibrary.simpleMessage(
                "Blaues Design basierend auf dem Twitter-Farbschema"),
        "cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "catastrophic_failure":
            MessageLookupByLibrary.simpleMessage("Totaler Ausfall"),
        "choose": MessageLookupByLibrary.simpleMessage("Wählen"),
        "close": MessageLookupByLibrary.simpleMessage("Schließen"),
        "contribute": MessageLookupByLibrary.simpleMessage("Beitragen"),
        "copied_address_to_clipboard": MessageLookupByLibrary.simpleMessage(
            "Adresse in die Zwischenablage kopiert"),
        "copied_version_to_clipboard": MessageLookupByLibrary.simpleMessage(
            "Kopierte Version in die Zwischenablage"),
        "could_not_contact_twitter": MessageLookupByLibrary.simpleMessage(
            "Es konnte keine Verbindung zu Twitter aufgebaut werden"),
        "could_not_find_any_tweets_by_this_user":
            MessageLookupByLibrary.simpleMessage(
                "Keine Tweets von dem angegebenen Nutzer gefunden!"),
        "could_not_find_any_tweets_from_the_last_7_days":
            MessageLookupByLibrary.simpleMessage(
                "Keine Tweets aus den letzten 7 Tagen zu finden!"),
        "country": MessageLookupByLibrary.simpleMessage("Land"),
        "dark": MessageLookupByLibrary.simpleMessage("Dunkel"),
        "data": MessageLookupByLibrary.simpleMessage("Daten"),
        "data_exported_to_fileName": m1,
        "data_exported_to_fullPath": m2,
        "data_imported_successfully": MessageLookupByLibrary.simpleMessage(
            "Daten erfolgreich importiert"),
        "date_created":
            MessageLookupByLibrary.simpleMessage("Erstellungsdatum"),
        "date_subscribed":
            MessageLookupByLibrary.simpleMessage("Abonnierungsdatum"),
        "default_tab":
            MessageLookupByLibrary.simpleMessage("Registerkarte \"Standard\""),
        "delete": MessageLookupByLibrary.simpleMessage("Löschen"),
        "disable_screenshots":
            MessageLookupByLibrary.simpleMessage("Screenshots deaktivieren"),
        "disable_screenshots_hint": MessageLookupByLibrary.simpleMessage(
            "Versucht zu verhindern, dass Screenshots von Fritter gemacht werden können. Dies ist keine Garantie und funktioniert möglicherweise nicht auf allen Geräten."),
        "disabled": MessageLookupByLibrary.simpleMessage("Deaktiviert"),
        "don_not_send": MessageLookupByLibrary.simpleMessage("Nicht Senden"),
        "donate": MessageLookupByLibrary.simpleMessage("Spenden"),
        "download": MessageLookupByLibrary.simpleMessage("Herunterladen"),
        "download_handling_description": MessageLookupByLibrary.simpleMessage(
            "So sollte das Herunterladen funktionieren"),
        "download_handling_type_ask":
            MessageLookupByLibrary.simpleMessage("Immer fragen"),
        "download_handling_type_directory":
            MessageLookupByLibrary.simpleMessage("Im Verzeichnis speichern"),
        "download_path":
            MessageLookupByLibrary.simpleMessage("Herunterladen-Pfad"),
        "downloading_media": MessageLookupByLibrary.simpleMessage(
            "Medien werden heruntergeladen..."),
        "enable_sentry":
            MessageLookupByLibrary.simpleMessage("Sentry aktivieren?"),
        "ended_timeago_format_endsAt_allowFromNow_true": m3,
        "ends_timeago_format_endsAt_allowFromNow_true": m4,
        "enter_your_twitter_username": MessageLookupByLibrary.simpleMessage(
            "Geben Sie Ihren Twitter-Nutzernamen an"),
        "export": MessageLookupByLibrary.simpleMessage("Exportieren"),
        "export_settings":
            MessageLookupByLibrary.simpleMessage("Exporteinstellungen?"),
        "export_subscription_group_members":
            MessageLookupByLibrary.simpleMessage(
                "Gruppenmitgliedsliste exportieren?"),
        "export_subscription_groups":
            MessageLookupByLibrary.simpleMessage("Abo-Gruppen exportieren?"),
        "export_subscriptions": MessageLookupByLibrary.simpleMessage(
            "Abonnementliste exportieren?"),
        "export_tweets":
            MessageLookupByLibrary.simpleMessage("Tweets exportieren?"),
        "export_your_data":
            MessageLookupByLibrary.simpleMessage("Daten exportieren"),
        "feed": MessageLookupByLibrary.simpleMessage("Feed"),
        "filters": MessageLookupByLibrary.simpleMessage("Filter"),
        "finished_with_snapshotData_users": m5,
        "followers":
            MessageLookupByLibrary.simpleMessage("Abonnenten (Follower)"),
        "following": MessageLookupByLibrary.simpleMessage("Abonniert"),
        "fritter": MessageLookupByLibrary.simpleMessage("Fritter"),
        "fritter_blue": MessageLookupByLibrary.simpleMessage("Fritter blau"),
        "general": MessageLookupByLibrary.simpleMessage("Allgemeines"),
        "groups": MessageLookupByLibrary.simpleMessage("Gruppen"),
        "help_make_fritter_even_better": MessageLookupByLibrary.simpleMessage(
            "Dazu beitragen, Fritter noch besser zu machen"),
        "help_support_fritters_future": MessageLookupByLibrary.simpleMessage(
            "Unterstützen Sie die Zukunft von Fritter"),
        "here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future":
            MessageLookupByLibrary.simpleMessage(
                "Dies sind die zu sendenden Daten. Sie werden nur verwendet, um festzustellen, welche Geräte und Sprachen Fritter zukünftig unterstützen soll."),
        "hide_sensitive_tweets":
            MessageLookupByLibrary.simpleMessage("Sensible Tweets ausblenden"),
        "if_you_have_any_feedback_on_this_feature_please_leave_it_on":
            MessageLookupByLibrary.simpleMessage(
                "Wenn Sie zu dieser Funktion eine Rückmeldung abgeben möchten, hinterlassen Sie sie bitte auf"),
        "import": MessageLookupByLibrary.simpleMessage("Importieren"),
        "import_data_from_another_device": MessageLookupByLibrary.simpleMessage(
            "Daten von einem anderen Gerät importieren"),
        "import_from_twitter":
            MessageLookupByLibrary.simpleMessage("Aus Twitter importieren"),
        "import_subscriptions":
            MessageLookupByLibrary.simpleMessage("Abonnements importieren"),
        "imported_snapshot_data_users_so_far": m7,
        "include_replies":
            MessageLookupByLibrary.simpleMessage("Antworten mit einschließen"),
        "include_retweets":
            MessageLookupByLibrary.simpleMessage("Re-Tweets mit einschließen"),
        "it_looks_like_you_have_already_said_hello_from_this_version_of_fritter":
            MessageLookupByLibrary.simpleMessage(
                "Es scheint, als hättest du bereits aus dieser Fritter-Version heraus Hallo gesagt!"),
        "it_looks_like_you_have_already_sent_a_ping_recently":
            MessageLookupByLibrary.simpleMessage(
                "Es scheint, als hättest du bereits einen Ping gesendet. 🤔"),
        "joined": m8,
        "language": MessageLookupByLibrary.simpleMessage("Sprache"),
        "language_subtitle":
            MessageLookupByLibrary.simpleMessage("Neustart erforderlich"),
        "large": MessageLookupByLibrary.simpleMessage("Groß"),
        "legacy_android_import": MessageLookupByLibrary.simpleMessage(
            "Von Legacy-Android-Geräten importieren"),
        "let_the_developers_know_if_something_is_broken":
            MessageLookupByLibrary.simpleMessage(
                "Teilen Sie den Entwicklern mit, wenn etwas nicht funktioniert"),
        "licenses": MessageLookupByLibrary.simpleMessage("Lizenzen"),
        "light": MessageLookupByLibrary.simpleMessage("Hell"),
        "live": MessageLookupByLibrary.simpleMessage("LIVE"),
        "logging": MessageLookupByLibrary.simpleMessage("Protokollierung"),
        "media": MessageLookupByLibrary.simpleMessage("Medien"),
        "media_size": MessageLookupByLibrary.simpleMessage("Mediengröße"),
        "medium": MessageLookupByLibrary.simpleMessage("Mittel"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "never_send": MessageLookupByLibrary.simpleMessage("Niemals Senden"),
        "newTrans": MessageLookupByLibrary.simpleMessage("Neu"),
        "no": MessageLookupByLibrary.simpleMessage("Nein"),
        "no_data_was_returned_which_should_never_happen_please_report_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "Keine Daten empfangen - das sollte niemals passieren. Bitte Fehler melden, wenn möglich!"),
        "no_results": MessageLookupByLibrary.simpleMessage("Keine Ergebnisse"),
        "no_results_for":
            MessageLookupByLibrary.simpleMessage("Keine Ergebnisse für:"),
        "no_subscriptions_try_searching_or_importing_some":
            MessageLookupByLibrary.simpleMessage(
                "Keine Abonnements. Suchen oder importieren Sie welche!"),
        "not_set": MessageLookupByLibrary.simpleMessage("Nicht festgelegt"),
        "note_due_to_a_twitter_limitation_not_all_tweets_may_be_included":
            MessageLookupByLibrary.simpleMessage(
                "Hinweis: Aufgrund einer Beschränkung seitens Twitter sind möglicherweise nicht alle Tweets enthalten"),
        "numberFormat_format_total_votes": m9,
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "oops_something_went_wrong": MessageLookupByLibrary.simpleMessage(
            "Oh nein! Ein Fehler ist aufgetreten 🥲"),
        "open_app_settings":
            MessageLookupByLibrary.simpleMessage("App-Einstellungen öffnen"),
        "permission_not_granted": MessageLookupByLibrary.simpleMessage(
            "Erlaubnis nicht erteilt. Bitte versuchen Sie es nach der Erteilung erneut!"),
        "pick_a_color":
            MessageLookupByLibrary.simpleMessage("Wählen Sie eine Farbe!"),
        "pick_an_icon":
            MessageLookupByLibrary.simpleMessage("Wählen Sie ein Symbol!"),
        "pinned_tweet":
            MessageLookupByLibrary.simpleMessage("Angehefteter Tweet"),
        "playback_speed":
            MessageLookupByLibrary.simpleMessage("Wiedergabegeschwindigkeit"),
        "please_check_your_internet_connection_error_message": m10,
        "please_enter_a_name":
            MessageLookupByLibrary.simpleMessage("Bitte einen Namen angeben"),
        "please_make_sure_the_data_you_wish_to_import_is_located_there_then_press_the_import_button_below":
            MessageLookupByLibrary.simpleMessage(
                "Vergewissern Sie sich, dass sich die Daten, die Sie importieren möchten, dort befinden, und klicken Sie dann auf die Schaltfläche „Importieren“ unten."),
        "please_note_that_the_method_fritter_uses_to_import_subscriptions_is_heavily_rate_limited_by_twitter_so_this_may_fail_if_you_have_a_lot_of_followed_accounts":
            MessageLookupByLibrary.simpleMessage(
                "Bitte beachten Sie, dass Fritter eine Methode zum Importieren von Abonnements verwenden muss, die von Twitter stark eingeschränkt wird. Bei vielen Abonnements könnte der Import möglicherweise fehlschlagen."),
        "prefix": MessageLookupByLibrary.simpleMessage("Präfix"),
        "private_profile":
            MessageLookupByLibrary.simpleMessage("Privates Profil"),
        "released_under_the_mit_license": MessageLookupByLibrary.simpleMessage(
            "Unter der MIT-Lizenz herausgegeben"),
        "replying_to": MessageLookupByLibrary.simpleMessage("Antwort an/auf"),
        "report": MessageLookupByLibrary.simpleMessage("Bericht"),
        "report_a_bug": MessageLookupByLibrary.simpleMessage("Fehler melden"),
        "reporting_an_error":
            MessageLookupByLibrary.simpleMessage("Fehler melden"),
        "retry": MessageLookupByLibrary.simpleMessage("Erneut versuchen"),
        "save": MessageLookupByLibrary.simpleMessage("Speichern"),
        "save_bandwidth_using_smaller_images":
            MessageLookupByLibrary.simpleMessage(
                "Bandbreite durch kleinere Bilder einsparen"),
        "saved": MessageLookupByLibrary.simpleMessage("Gespeichert"),
        "say_hello": MessageLookupByLibrary.simpleMessage("Sag Hallo"),
        "say_hello_emoji": MessageLookupByLibrary.simpleMessage("Sag Hallo 👋"),
        "search": MessageLookupByLibrary.simpleMessage("Suche"),
        "select": MessageLookupByLibrary.simpleMessage("Auswählen"),
        "selecting_individual_accounts_to_import_and_assigning_groups_are_both_planned_for_the_future_already":
            MessageLookupByLibrary.simpleMessage(
                "Die Auswahl einzelner Importkonten und die Zuweisung zu Gruppen sind bereits für die Zukunft geplant!"),
        "send": MessageLookupByLibrary.simpleMessage("Senden"),
        "send_a_non_identifying_ping_to_let_me_know_you_are_using_fritter_and_to_help_future_development":
            MessageLookupByLibrary.simpleMessage(
                "Schicken Sie einen Ping, der Ihre Identität nicht preisgibt, um mir mitzuteilen, dass Sie Fritter benutzen - und um die zukünftige Entwicklung zu unterstützen"),
        "send_always": MessageLookupByLibrary.simpleMessage("Immer Senden"),
        "send_once": MessageLookupByLibrary.simpleMessage("Einmalig Senden"),
        "share_tweet_content":
            MessageLookupByLibrary.simpleMessage("Tweetinhalt teilen"),
        "share_tweet_content_and_link": MessageLookupByLibrary.simpleMessage(
            "Tweet-Inhalt und Link teilen"),
        "share_tweet_link":
            MessageLookupByLibrary.simpleMessage("Link zum Tweet teilen"),
        "should_check_for_updates_description":
            MessageLookupByLibrary.simpleMessage(
                "Beim Start von Fritter nach Aktualisierungen suchen"),
        "should_check_for_updates_label": MessageLookupByLibrary.simpleMessage(
            "Nach Aktualisierungen suchen"),
        "small": MessageLookupByLibrary.simpleMessage("Klein"),
        "something_broke_in_fritter": MessageLookupByLibrary.simpleMessage(
            "Etwas in Fritter ist kaputt."),
        "something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated":
            MessageLookupByLibrary.simpleMessage(
                "Etwas ist in Fritter schief gelaufen, und es wurde ein Fehlerbericht erstellt. Der Bericht kann an die Fritter-Entwickler gesendet werden, damit sie das Problem beheben können."),
        "sorry_the_replied_tweet_could_not_be_found":
            MessageLookupByLibrary.simpleMessage(
                "Entschuldigung! Der beantwortete Tweet konnte nicht gefunden werden!"),
        "subscribe": MessageLookupByLibrary.simpleMessage("Abonnieren"),
        "subscriptions": MessageLookupByLibrary.simpleMessage("Abonnements"),
        "subtitles": MessageLookupByLibrary.simpleMessage("Untertitel"),
        "successfully_saved_the_media":
            MessageLookupByLibrary.simpleMessage("Medien gespeichert."),
        "system": MessageLookupByLibrary.simpleMessage("System"),
        "tap_to_download_release_version": m11,
        "tap_to_show_getMediaType_item_type": m12,
        "thanks_for_helping_fritter": MessageLookupByLibrary.simpleMessage(
            "Danke für die Unterstützung von Fritter! 💖"),
        "thanks_for_reporting_we_will_try_and_fix_it_in_no_time":
            MessageLookupByLibrary.simpleMessage(
                "Danke für die Meldung. Wir versuchen, das Problem schnellstmöglich zu beheben!"),
        "the_file_does_not_exist_please_ensure_it_is_located_at_file_path": m13,
        "the_github_issue": MessageLookupByLibrary.simpleMessage(
            "die GitHub-Ausgabe (Nr. 143)"),
        "the_tweet_did_not_contain_any_text_this_is_unexpected":
            MessageLookupByLibrary.simpleMessage(
                "Der Tweet hat keinen Textinhalt. Dies kommt unerwartet"),
        "theme": MessageLookupByLibrary.simpleMessage("Thema"),
        "there_were_no_trends_returned_this_is_unexpected_please_report_as_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "Die Trendanfrage ist erfolglos geblieben; dies kommt unerwartet! Bitte als Fehler melden, wenn möglich."),
        "this_group_contains_no_subscriptions":
            MessageLookupByLibrary.simpleMessage(
                "Diese Gruppe enthält keine Abonnements!"),
        "this_took_too_long_to_load_please_check_your_network_connection":
            MessageLookupByLibrary.simpleMessage(
                "Das Laden hat zu lange gedauert. Bitte Internetverbindung prüfen!"),
        "this_tweet_is_unavailable": MessageLookupByLibrary.simpleMessage(
            "Dieser Tweet ist nicht verfügbar"),
        "this_tweet_user_name_retweeted": m14,
        "this_user_does_not_follow_anyone":
            MessageLookupByLibrary.simpleMessage(
                "Dieser Nutzer folgt niemandem!"),
        "this_user_does_not_have_anyone_following_them":
            MessageLookupByLibrary.simpleMessage(
                "Dieser Nutzer hat keine Follower!"),
        "thread": MessageLookupByLibrary.simpleMessage("Diskussionsfaden"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("Vorschaubild"),
        "timed_out": MessageLookupByLibrary.simpleMessage("Zeit abgelaufen"),
        "timed_out_trying_to_send_the_ping":
            MessageLookupByLibrary.simpleMessage(
                "Das Senden des Pings hat zu lange gedauert 😢"),
        "to_import_subscriptions_from_an_existing_twitter_account_enter_your_username_below":
            MessageLookupByLibrary.simpleMessage(
                "Um Abonnements von einem existenten Twitter-Konto zu importieren, geben Sie unten Ihren Nutzernamen an."),
        "toggle_all":
            MessageLookupByLibrary.simpleMessage("Alle hinzufügen/entfernen"),
        "trending": MessageLookupByLibrary.simpleMessage("Trending"),
        "trends": MessageLookupByLibrary.simpleMessage("Trends"),
        "true_black": MessageLookupByLibrary.simpleMessage("Echtschwarz?"),
        "tweets": MessageLookupByLibrary.simpleMessage("Tweets"),
        "tweets_and_replies":
            MessageLookupByLibrary.simpleMessage("Tweets & Antworten"),
        "tweets_number": m15,
        "unable_to_find_the_available_trend_locations":
            MessageLookupByLibrary.simpleMessage(
                "Die verfügbaren Orts-/Land-Angaben für Trends konnten nicht gefunden werden."),
        "unable_to_find_your_saved_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Gespeicherte Tweets können nicht gefunden werden."),
        "unable_to_import":
            MessageLookupByLibrary.simpleMessage("Import nicht möglich"),
        "unable_to_load_subscription_groups":
            MessageLookupByLibrary.simpleMessage(
                "Abonnementgruppen können nicht geladen werden"),
        "unable_to_load_the_group": MessageLookupByLibrary.simpleMessage(
            "Die Abo-Gruppe konnte nicht geladen werden"),
        "unable_to_load_the_group_settings": MessageLookupByLibrary.simpleMessage(
            "Die Einstellungen für die Abo-Gruppe konnten nicht geladen werden"),
        "unable_to_load_the_list_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Die Liste der Follower kann nicht geladen werden"),
        "unable_to_load_the_next_page_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Die weiteren Follower können nicht geladen werden"),
        "unable_to_load_the_next_page_of_replies":
            MessageLookupByLibrary.simpleMessage(
                "Nächste Antworten können nicht geladen werden"),
        "unable_to_load_the_next_page_of_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Die nächsten Tweets können nicht geladen werden"),
        "unable_to_load_the_profile": MessageLookupByLibrary.simpleMessage(
            "Das Profil kann nicht geladen werden"),
        "unable_to_load_the_search_results":
            MessageLookupByLibrary.simpleMessage(
                "Die Suchergebnisse können nicht geladen werden."),
        "unable_to_load_the_trends_for_widget_place_name": m16,
        "unable_to_load_the_tweet": MessageLookupByLibrary.simpleMessage(
            "Der Tweet konnte nicht geladen werden"),
        "unable_to_load_the_tweets": MessageLookupByLibrary.simpleMessage(
            "Die Tweets können nicht geladen werden"),
        "unable_to_load_the_tweets_for_the_feed":
            MessageLookupByLibrary.simpleMessage(
                "Die Tweets für den Feed können nicht geladen werden"),
        "unable_to_run_the_database_migrations":
            MessageLookupByLibrary.simpleMessage(
                "Die Datenbankmigrationen konnten nicht durchgeführt werden"),
        "unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode":
            m17,
        "unable_to_send_the_ping_e_to_string": m18,
        "unable_to_send_the_ping_the_status_code_was_response_statusCode": m19,
        "unable_to_stream_the_trend_location_preference":
            MessageLookupByLibrary.simpleMessage(
                "Die Trendortpräferenz kann nicht gestreamt werden"),
        "unknown": MessageLookupByLibrary.simpleMessage("Unbekannt"),
        "unsave":
            MessageLookupByLibrary.simpleMessage("Speichern rückgängig machen"),
        "unsubscribe": MessageLookupByLibrary.simpleMessage("Abo abbestellen"),
        "update_to_release_version_through_your_fdroid_client": m20,
        "updates": MessageLookupByLibrary.simpleMessage("Updates"),
        "use_true_black_for_the_dark_mode_theme":
            MessageLookupByLibrary.simpleMessage(
                "Echtschwarz im dunklen Modus (dark mode) nutzen"),
        "user_not_found":
            MessageLookupByLibrary.simpleMessage("Nutzer wurde nicht gefunden"),
        "username": MessageLookupByLibrary.simpleMessage("Nutzername"),
        "version": MessageLookupByLibrary.simpleMessage("Version"),
        "when_a_new_app_update_is_available":
            MessageLookupByLibrary.simpleMessage(
                "Sobald ein neues Update der App verfügbar ist"),
        "whether_errors_should_be_reported_to_sentry":
            MessageLookupByLibrary.simpleMessage(
                "Ob Fehlermeldungen an Sentry gesendet werden sollen"),
        "whether_to_hide_tweets_marked_as_sensitive":
            MessageLookupByLibrary.simpleMessage(
                "Ob Tweets, die als sensibel markiert sind, ausgeblendet werden sollen"),
        "which_tab_is_shown_when_the_app_opens":
            MessageLookupByLibrary.simpleMessage(
                "Welche Registerkarte wird beim Öffnen der App angezeigt"),
        "would_you_like_to_enable_automatic_error_reporting":
            MessageLookupByLibrary.simpleMessage(
                "Möchten Sie automatische Fehlermeldungen aktivieren?"),
        "yes": MessageLookupByLibrary.simpleMessage("Ja"),
        "you_have_not_saved_any_tweets_yet":
            MessageLookupByLibrary.simpleMessage(
                "Sie haben bisher keine Tweets gespeichert!"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_data_can_only_be_imported_from":
            MessageLookupByLibrary.simpleMessage(
                "Auf Ihrem Gerät läuft eine ältere Android-Version als KitKat (4.4), daher können Daten nur aus folgendem Verzeichnis importiert werden:"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to":
            MessageLookupByLibrary.simpleMessage(
                "Auf Ihrem Gerät läuft eine Android-Version, die älter ist als KitKat (4.4), daher kann nur exportiert werden nach:"),
        "your_profile_must_be_public_otherwise_the_import_will_not_work":
            MessageLookupByLibrary.simpleMessage(
                "Ein öffentliches Profil ist erforderlich, sonst funktioniert der Import nicht"),
        "your_report_will_be_sent_to_fritter_sentry_project":
            MessageLookupByLibrary.simpleMessage(
                "Ihre Meldung wird an Fritter\'s Sentry-Projektseite gesendet. Einzelheiten zum Datenschutz finden Sie unter:")
      };
}
