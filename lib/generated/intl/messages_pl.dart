// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pl locale. All the
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
  String get localeName => 'pl';

  static String m0(name) =>
      "Czy na pewno chcesz usunąć grupę subskrypcji ${name}?";

  static String m1(fileName) => "Dane wyeksportowano do ${fileName}";

  static String m2(fullPath) => "Dane wyeksportowano do ${fullPath}";

  static String m3(timeagoFormat) => "Zakończono ${timeagoFormat}";

  static String m4(timeagoFormat) => "Kończy się ${timeagoFormat}";

  static String m5(snapshotData) => "Ukończono z ${snapshotData} użytkownikami";

  static String m6(snapshotData) =>
      "Do tej pory zaimportowano ${snapshotData} użytkowników";

  static String m7(date) => "Dołączył(a) ${date}";

  static String m8(num, numFormatted) =>
      "${Intl.plural(num, zero: 'brak głosów', one: '1 głos', two: '2 głosy', few: '${numFormatted} głosy', many: '${numFormatted} głosów', other: '${numFormatted} głosów')}";

  static String m9(errorMessage) =>
      "Sprawdź swoje połączenie internetowe.\n\n${errorMessage}";

  static String m10(releaseVersion) => "Naciśnij, aby pobrać ${releaseVersion}";

  static String m11(getMediaType) => "Naciśnij, aby wyświetlić ${getMediaType}";

  static String m12(state) => "Status połączenia ${state} nie jest obsługiwany";

  static String m13(filePath) =>
      "Plik nie istnieje. Upewnij się, że znajduje się w ${filePath}";

  static String m14(thisTweetUserName) =>
      "${thisTweetUserName} podał(a) dalej tweeta";

  static String m15(num, numFormatted) =>
      "${Intl.plural(num, zero: 'brak tweetów', one: '1 tweet', two: '2 tweety', few: '${numFormatted} tweety', many: '${numFormatted} tweetów', other: '${numFormatted} tweetów')}";

  static String m16(widgetPlaceName) =>
      "Nie można załadować trendów dla ${widgetPlaceName}";

  static String m17(e) => "Nie można odświeżyć subskrypcji. Błąd to ${e}";

  static String m18(responseStatusCode) =>
      "Nie można zapisać multimediów. Twitter zwrócił status ${responseStatusCode}";

  static String m19(e) => "Nie można wysłać ping. ${e}";

  static String m20(statusCode) =>
      "Nie można wysłać ping. Kod statusu to ${statusCode}";

  static String m21(releaseVersion) =>
      "Zaktualizuj do ${releaseVersion} przez klienta F-Droid";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("O aplikacji"),
        "account_suspended":
            MessageLookupByLibrary.simpleMessage("Konto zawieszone"),
        "add_to_group": MessageLookupByLibrary.simpleMessage("Dodaj do grupy"),
        "all": MessageLookupByLibrary.simpleMessage("Wszystkie"),
        "all_the_great_software_used_by_fritter":
            MessageLookupByLibrary.simpleMessage(
                "Całe świetne oprogramowanie używane przez Frittera"),
        "an_error_was_reported_to_sentry_thank_you":
            MessageLookupByLibrary.simpleMessage(
                "Błąd został zgłoszony do Sentry. Dziękujemy!"),
        "an_update_for_fritter_is_available":
            MessageLookupByLibrary.simpleMessage(
                "Dostępna jest aktualizacja Frittera! 🚀"),
        "are_you_sure": MessageLookupByLibrary.simpleMessage("Czy na pewno?"),
        "are_you_sure_you_want_to_delete_the_subscription_group_name_of_group":
            m0,
        "back": MessageLookupByLibrary.simpleMessage("Wstecz"),
        "blue_theme_based_on_the_twitter_color_scheme":
            MessageLookupByLibrary.simpleMessage(
                "Niebieski motyw oparty na kolorystyce Twittera"),
        "cancel": MessageLookupByLibrary.simpleMessage("Anuluj"),
        "catastrophic_failure":
            MessageLookupByLibrary.simpleMessage("Katastrofalna awaria"),
        "contribute": MessageLookupByLibrary.simpleMessage("Wnieś swój wkład"),
        "copied_address_to_clipboard":
            MessageLookupByLibrary.simpleMessage("Adres skopiowany do schowka"),
        "copied_version_to_clipboard": MessageLookupByLibrary.simpleMessage(
            "Wersja skopiowana do schowka"),
        "could_not_contact_twitter": MessageLookupByLibrary.simpleMessage(
            "Nie udało się połączyć z Twitterem"),
        "could_not_find_any_tweets_by_this_user":
            MessageLookupByLibrary.simpleMessage(
                "Nie udało się znaleźć żadnych tweetów tego użytkownika!"),
        "could_not_find_any_tweets_from_the_last_7_days":
            MessageLookupByLibrary.simpleMessage(
                "Nie udało się znaleźć żadnych tweetów z ostatnich 7 dni!"),
        "country": MessageLookupByLibrary.simpleMessage("Kraj"),
        "dark": MessageLookupByLibrary.simpleMessage("Ciemny"),
        "data": MessageLookupByLibrary.simpleMessage("Dane"),
        "data_exported_to_fileName": m1,
        "data_exported_to_fullPath": m2,
        "data_imported_successfully":
            MessageLookupByLibrary.simpleMessage("Dane zostały zaimportowane"),
        "date_created": MessageLookupByLibrary.simpleMessage("Data utworzenia"),
        "date_subscribed":
            MessageLookupByLibrary.simpleMessage("Data subskrypcji"),
        "default_tab": MessageLookupByLibrary.simpleMessage("Domyślna karta"),
        "delete": MessageLookupByLibrary.simpleMessage("Usuń"),
        "disabled": MessageLookupByLibrary.simpleMessage("Wyłączone"),
        "don_not_send": MessageLookupByLibrary.simpleMessage("Nie wysyłaj"),
        "donate": MessageLookupByLibrary.simpleMessage("Przekaż datek"),
        "download": MessageLookupByLibrary.simpleMessage("Pobierz"),
        "downloading_media":
            MessageLookupByLibrary.simpleMessage("Pobieranie multimediów…"),
        "enable_sentry":
            MessageLookupByLibrary.simpleMessage("Włączyć Sentry?"),
        "ended_timeago_format_endsAt_allowFromNow_true": m3,
        "ends_timeago_format_endsAt_allowFromNow_true": m4,
        "enter_your_twitter_username": MessageLookupByLibrary.simpleMessage(
            "Wprowadź swoją nazwę użytkownika Twittera"),
        "export": MessageLookupByLibrary.simpleMessage("Eksportuj"),
        "export_settings":
            MessageLookupByLibrary.simpleMessage("Wyeksportować ustawienia?"),
        "export_subscription_group_members":
            MessageLookupByLibrary.simpleMessage(
                "Wyeksportować członków grup subskrypcji?"),
        "export_subscription_groups": MessageLookupByLibrary.simpleMessage(
            "Wyeksportować grupy subskrypcji?"),
        "export_subscriptions":
            MessageLookupByLibrary.simpleMessage("Wyeksportować subskrypcje?"),
        "export_tweets":
            MessageLookupByLibrary.simpleMessage("Wyeksportować tweety?"),
        "export_your_data":
            MessageLookupByLibrary.simpleMessage("Wyeksportuj swoje dane"),
        "feed": MessageLookupByLibrary.simpleMessage("Główna"),
        "filters": MessageLookupByLibrary.simpleMessage("Filtry"),
        "finished_with_snapshotData_users": m5,
        "followers": MessageLookupByLibrary.simpleMessage("Obserwujący"),
        "following": MessageLookupByLibrary.simpleMessage("Obserwowani"),
        "fritter": MessageLookupByLibrary.simpleMessage("Fritter"),
        "fritter_blue": MessageLookupByLibrary.simpleMessage("Fritter Blue"),
        "general": MessageLookupByLibrary.simpleMessage("Ogólne"),
        "groups": MessageLookupByLibrary.simpleMessage("Grupy"),
        "help_make_fritter_even_better": MessageLookupByLibrary.simpleMessage(
            "Pomóż uczynić Fritter jeszcze lepszym"),
        "help_support_fritters_future": MessageLookupByLibrary.simpleMessage(
            "Pomóż wesprzeć przyszłość Frittera"),
        "here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future":
            MessageLookupByLibrary.simpleMessage(
                "Oto dane, które zostaną wysłane. Zostaną wykorzystane tylko do określenia, które urządzenia i języki będą obsługiwane we Fritterze w przyszłości."),
        "if_you_have_any_feedback_on_this_feature_please_leave_it_on":
            MessageLookupByLibrary.simpleMessage(
                "Jeśli masz jakieś uwagi na temat tej funkcji, zgłoś je w"),
        "import": MessageLookupByLibrary.simpleMessage("Importuj"),
        "import_data_from_another_device": MessageLookupByLibrary.simpleMessage(
            "Zaimportuj dane z innego urządzenia"),
        "import_from_twitter":
            MessageLookupByLibrary.simpleMessage("Importuj z Twittera"),
        "import_subscriptions":
            MessageLookupByLibrary.simpleMessage("Importuj subskrypcje"),
        "imported_snapshot_data_users_so_far": m6,
        "include_replies":
            MessageLookupByLibrary.simpleMessage("Uwzględniaj odpowiedzi"),
        "include_retweets": MessageLookupByLibrary.simpleMessage(
            "Uwzględniaj tweety podane dalej"),
        "it_looks_like_you_have_already_said_hello_from_this_version_of_fritter":
            MessageLookupByLibrary.simpleMessage(
                "Wygląda na to, że już przywitałeś(-aś) się z tej wersji Frittera!"),
        "it_looks_like_you_have_already_sent_a_ping_recently":
            MessageLookupByLibrary.simpleMessage(
                "Wygląda na to, że ostatnio już wysłałeś(-aś) ping 🤔"),
        "joined": m7,
        "large": MessageLookupByLibrary.simpleMessage("Duże"),
        "legacy_android_import": MessageLookupByLibrary.simpleMessage(
            "Importowanie ze starszej wersji Androida"),
        "let_the_developers_know_if_something_is_broken":
            MessageLookupByLibrary.simpleMessage(
                "Daj znać programistom, jeśli coś się zepsuło"),
        "licenses": MessageLookupByLibrary.simpleMessage("Licencje"),
        "light": MessageLookupByLibrary.simpleMessage("Jasny"),
        "live": MessageLookupByLibrary.simpleMessage("NA ŻYWO"),
        "logging": MessageLookupByLibrary.simpleMessage("Zbieranie danych"),
        "media": MessageLookupByLibrary.simpleMessage("Multimedia"),
        "media_size":
            MessageLookupByLibrary.simpleMessage("Rozmiar multimediów"),
        "medium": MessageLookupByLibrary.simpleMessage("Średnie"),
        "name": MessageLookupByLibrary.simpleMessage("Nazwa"),
        "never_send": MessageLookupByLibrary.simpleMessage("Nigdy nie wysyłaj"),
        "newTrans": MessageLookupByLibrary.simpleMessage("Nowa"),
        "no": MessageLookupByLibrary.simpleMessage("Nie"),
        "no_data_was_returned_which_should_never_happen_please_report_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "Żadne dane nie zostały zwrócone, co nigdy nie powinno się zdarzyć. Jeśli to możliwe, zgłoś błąd!"),
        "no_results": MessageLookupByLibrary.simpleMessage("Brak wyników"),
        "no_subscriptions_try_searching_or_importing_some":
            MessageLookupByLibrary.simpleMessage(
                "Brak subskrypcji. Spróbuj wyszukać lub zaimportować trochę!"),
        "note_due_to_a_twitter_limitation_not_all_tweets_may_be_included":
            MessageLookupByLibrary.simpleMessage(
                "Uwaga: Ze względu na ograniczenia Twittera nie wszystkie tweety mogą zostać uwzględnione"),
        "numberFormat_format_total_votes": m8,
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "oops_something_went_wrong":
            MessageLookupByLibrary.simpleMessage("Ups! Coś poszło nie tak 🥲"),
        "pick_a_color": MessageLookupByLibrary.simpleMessage("Wybierz kolor!"),
        "pinned_tweet": MessageLookupByLibrary.simpleMessage("Przypięty tweet"),
        "playback_speed":
            MessageLookupByLibrary.simpleMessage("Prędkość odtwarzania"),
        "please_check_your_internet_connection_error_message": m9,
        "please_enter_a_name":
            MessageLookupByLibrary.simpleMessage("Wprowadź nazwę"),
        "please_make_sure_the_data_you_wish_to_import_is_located_there_then_press_the_import_button_below":
            MessageLookupByLibrary.simpleMessage(
                "Upewnij się, że znajdują się tam dane, które chcesz zaimportować, a następnie naciśnij przycisk importu poniżej."),
        "please_note_that_the_method_fritter_uses_to_import_subscriptions_is_heavily_rate_limited_by_twitter_so_this_may_fail_if_you_have_a_lot_of_followed_accounts":
            MessageLookupByLibrary.simpleMessage(
                "Pamiętaj, że metoda, której używa Fritter do importowania subskrypcji, jest mocno ograniczona przez Twittera, więc może się to nie udać, jeśli masz dużo obserwowanych kont."),
        "prefix": MessageLookupByLibrary.simpleMessage("prefiks"),
        "private_profile":
            MessageLookupByLibrary.simpleMessage("Profil prywatny"),
        "released_under_the_mit_license":
            MessageLookupByLibrary.simpleMessage("Wydany na licencji MIT"),
        "replying_to": MessageLookupByLibrary.simpleMessage("W odpowiedzi do"),
        "report": MessageLookupByLibrary.simpleMessage("Zgłoś"),
        "report_a_bug": MessageLookupByLibrary.simpleMessage("Zgłoś błąd"),
        "reporting_an_error":
            MessageLookupByLibrary.simpleMessage("Zgłaszanie błędu"),
        "retry": MessageLookupByLibrary.simpleMessage("Ponów"),
        "save": MessageLookupByLibrary.simpleMessage("Zapisz"),
        "save_bandwidth_using_smaller_images":
            MessageLookupByLibrary.simpleMessage(
                "Oszczędzaj transfer, używając mniejszych obrazów"),
        "saved": MessageLookupByLibrary.simpleMessage("Zapisane"),
        "say_hello": MessageLookupByLibrary.simpleMessage("Przywitaj się"),
        "say_hello_emoji":
            MessageLookupByLibrary.simpleMessage("Przywitaj się 👋"),
        "selecting_individual_accounts_to_import_and_assigning_groups_are_both_planned_for_the_future_already":
            MessageLookupByLibrary.simpleMessage(
                "Wybieranie poszczególnych kont do zaimportowania i przypisywanie grup są już zaplanowane na przyszłość!"),
        "send": MessageLookupByLibrary.simpleMessage("Wyślij"),
        "send_a_non_identifying_ping_to_let_me_know_you_are_using_fritter_and_to_help_future_development":
            MessageLookupByLibrary.simpleMessage(
                "Wyślij nieidentyfikujący ping, aby dać mi znać, że używasz Frittera, i pomóc w przyszłym rozwoju"),
        "send_always": MessageLookupByLibrary.simpleMessage("Wysyłaj zawsze"),
        "send_once": MessageLookupByLibrary.simpleMessage("Wyślij tylko raz"),
        "share_tweet_content":
            MessageLookupByLibrary.simpleMessage("Udostępnij zawartość tweeta"),
        "share_tweet_link":
            MessageLookupByLibrary.simpleMessage("Udostępnij link do tweeta"),
        "small": MessageLookupByLibrary.simpleMessage("Małe"),
        "something_broke_in_fritter": MessageLookupByLibrary.simpleMessage(
            "Coś się popsuło we Fritterze."),
        "something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated":
            MessageLookupByLibrary.simpleMessage(
                "Coś poszło nie tak we Fritterze, dlatego został wygenerowany raport o błędzie. Raport można wysłać do programistów Frittera, aby pomóc w rozwiązaniu problemu."),
        "sorry_the_replied_tweet_could_not_be_found":
            MessageLookupByLibrary.simpleMessage(
                "Przepraszamy, nie znaleziono tweeta z odpowiedzią!"),
        "subscribe": MessageLookupByLibrary.simpleMessage("Subskrybuj"),
        "subscriptions": MessageLookupByLibrary.simpleMessage("Subskrypcje"),
        "subtitles": MessageLookupByLibrary.simpleMessage("Napisy"),
        "successfully_saved_the_media": MessageLookupByLibrary.simpleMessage(
            "Multimedia zostały zapisane!"),
        "system": MessageLookupByLibrary.simpleMessage("Systemowy"),
        "tap_to_download_release_version": m10,
        "tap_to_show_getMediaType_item_type": m11,
        "thanks_for_helping_fritter": MessageLookupByLibrary.simpleMessage(
            "Dzięki za pomoc Fritterowi! 💖"),
        "thanks_for_reporting_we_will_try_and_fix_it_in_no_time":
            MessageLookupByLibrary.simpleMessage(
                "Dzięki za zgłoszenie. Postaramy się to naprawić w mgnieniu oka!"),
        "the_connection_state_state_is_not_supported": m12,
        "the_file_does_not_exist_please_ensure_it_is_located_at_file_path": m13,
        "the_tweet_did_not_contain_any_text_this_is_unexpected":
            MessageLookupByLibrary.simpleMessage(
                "Tweet nie zawierał żadnego tekstu. To nieoczekiwane"),
        "theme": MessageLookupByLibrary.simpleMessage("Motyw"),
        "there_were_no_trends_returned_this_is_unexpected_please_report_as_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "Nie zwrócono żadnych trendów. To nieoczekiwane! Jeśli to możliwe, zgłoś błąd."),
        "this_group_contains_no_subscriptions":
            MessageLookupByLibrary.simpleMessage(
                "Ta grupa nie zawiera subskrypcji!"),
        "this_took_too_long_to_load_please_check_your_network_connection":
            MessageLookupByLibrary.simpleMessage(
                "Ładowanie trwało zbyt długo. Sprawdź swoje połączenie sieciowe!"),
        "this_tweet_is_unavailable":
            MessageLookupByLibrary.simpleMessage("Ten tweet jest niedostępny"),
        "this_tweet_user_name_retweeted": m14,
        "this_user_does_not_follow_anyone":
            MessageLookupByLibrary.simpleMessage(
                "Ten użytkownik nikogo nie obserwuje!"),
        "this_user_does_not_have_anyone_following_them":
            MessageLookupByLibrary.simpleMessage(
                "Ten użytkownik nie jest obserwowany przez nikogo!"),
        "thread": MessageLookupByLibrary.simpleMessage("Wątek"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("Miniatury"),
        "timed_out":
            MessageLookupByLibrary.simpleMessage("Przekroczono limit czasu"),
        "timed_out_trying_to_send_the_ping":
            MessageLookupByLibrary.simpleMessage(
                "Przekroczono limit czasu podczas próby wysłania ping 😢"),
        "to_import_subscriptions_from_an_existing_twitter_account_enter_your_username_below":
            MessageLookupByLibrary.simpleMessage(
                "Aby zaimportować subskrypcje z istniejącego konta na Twitterze, wprowadź poniżej swoją nazwę użytkownika."),
        "toggle_all": MessageLookupByLibrary.simpleMessage("Przełącz"),
        "trending": MessageLookupByLibrary.simpleMessage("Trendy"),
        "trends": MessageLookupByLibrary.simpleMessage("Trendy"),
        "true_black": MessageLookupByLibrary.simpleMessage("Prawdziwa czerń?"),
        "tweets": MessageLookupByLibrary.simpleMessage("Tweety"),
        "tweets_and_replies":
            MessageLookupByLibrary.simpleMessage("Tweety i odpowiedzi"),
        "tweets_number": m15,
        "unable_to_check_if_this_is_a_legacy_Android_device":
            MessageLookupByLibrary.simpleMessage(
                "Nie można sprawdzić, czy jest to starsze urządzenie z Androidem."),
        "unable_to_find_the_app_package_info":
            MessageLookupByLibrary.simpleMessage(
                "Nie można znaleźć informacji o pakiecie aplikacji"),
        "unable_to_find_the_available_trend_locations":
            MessageLookupByLibrary.simpleMessage(
                "Nie można znaleźć dostępnych lokalizacji trendów."),
        "unable_to_find_your_saved_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Nie można znaleźć Twoich zapisanych tweetów."),
        "unable_to_import":
            MessageLookupByLibrary.simpleMessage("Nie można zaimportować"),
        "unable_to_load_subscription_groups":
            MessageLookupByLibrary.simpleMessage(
                "Nie można załadować grup subskrypcji"),
        "unable_to_load_the_group":
            MessageLookupByLibrary.simpleMessage("Nie można załadować grupy"),
        "unable_to_load_the_group_settings":
            MessageLookupByLibrary.simpleMessage(
                "Nie można załadować ustawień grupy"),
        "unable_to_load_the_list_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Nie można załadować listy obserwowanych"),
        "unable_to_load_the_next_page_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Nie można załadować następnej strony z obserwowanymi"),
        "unable_to_load_the_next_page_of_replies":
            MessageLookupByLibrary.simpleMessage(
                "Nie można załadować następnej strony z odpowiedziami"),
        "unable_to_load_the_next_page_of_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Nie można załadować następnej strony z tweetami"),
        "unable_to_load_the_profile":
            MessageLookupByLibrary.simpleMessage("Nie można załadować profilu"),
        "unable_to_load_the_search_results":
            MessageLookupByLibrary.simpleMessage(
                "Nie można załadować wyników wyszukiwania."),
        "unable_to_load_the_trends_for_widget_place_name": m16,
        "unable_to_load_the_tweet":
            MessageLookupByLibrary.simpleMessage("Nie można załadować tweeta"),
        "unable_to_load_the_tweets":
            MessageLookupByLibrary.simpleMessage("Nie można załadować tweetów"),
        "unable_to_load_the_tweets_for_the_feed":
            MessageLookupByLibrary.simpleMessage(
                "Nie można załadować tweetów na stronę główną"),
        "unable_to_refresh_the_subscriptions_the_error_was_e": m17,
        "unable_to_run_the_database_migrations":
            MessageLookupByLibrary.simpleMessage(
                "Nie można uruchomić migracji bazy danych"),
        "unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode":
            m18,
        "unable_to_send_the_ping_e_to_string": m19,
        "unable_to_send_the_ping_the_status_code_was_response_statusCode": m20,
        "unable_to_stream_the_trend_location_preference":
            MessageLookupByLibrary.simpleMessage(
                "Nie można przesłać strumieniowo preferencji lokalizacji trendu"),
        "unknown": MessageLookupByLibrary.simpleMessage("Nieznane"),
        "unsave": MessageLookupByLibrary.simpleMessage("Usuń z zapisanych"),
        "unsubscribe": MessageLookupByLibrary.simpleMessage("Odsubskrybuj"),
        "update_to_release_version_through_your_fdroid_client": m21,
        "updates": MessageLookupByLibrary.simpleMessage("Aktualizacje"),
        "use_true_black_for_the_dark_mode_theme":
            MessageLookupByLibrary.simpleMessage(
                "Używaj prawdziwej czerni dla ciemnego motywu"),
        "user_not_found":
            MessageLookupByLibrary.simpleMessage("Nie znaleziono użytkownika"),
        "username": MessageLookupByLibrary.simpleMessage("Nazwa użytkownika"),
        "version": MessageLookupByLibrary.simpleMessage("Wersja"),
        "when_a_new_app_update_is_available":
            MessageLookupByLibrary.simpleMessage(
                "Gdy dostępna jest nowa aktualizacja aplikacji"),
        "whether_errors_should_be_reported_to_sentry":
            MessageLookupByLibrary.simpleMessage("Zgłaszaj błędy do Sentry"),
        "which_tab_is_shown_when_the_app_opens":
            MessageLookupByLibrary.simpleMessage(
                "Karta wyświetlana po otwarciu aplikacji"),
        "would_you_like_to_enable_automatic_error_reporting":
            MessageLookupByLibrary.simpleMessage(
                "Czy chcesz włączyć automatyczne raportowanie błędów?"),
        "yes": MessageLookupByLibrary.simpleMessage("Tak"),
        "you_have_not_saved_any_tweets_yet":
            MessageLookupByLibrary.simpleMessage(
                "Nie zapisałeś(-aś) jeszcze żadnych tweetów!"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_data_can_only_be_imported_from":
            MessageLookupByLibrary.simpleMessage(
                "Na Twoim urządzeniu jest wersja Androida starsza niż KitKat (4.4), więc dane można importować tylko z:"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to":
            MessageLookupByLibrary.simpleMessage(
                "Na Twoim urządzeniu jest wersja Androida starsza niż KitKat (4.4), więc dane można eksportować tylko do:"),
        "your_profile_must_be_public_otherwise_the_import_will_not_work":
            MessageLookupByLibrary.simpleMessage(
                "Twój profil musi być publiczny, w przeciwnym razie import nie zadziała"),
        "your_report_will_be_sent_to_fritter_sentry_project":
            MessageLookupByLibrary.simpleMessage(
                "Twoje zgłoszenie zostanie wysłane do projektu Fritter na Sentry, a szczegóły dotyczące prywatności można znaleźć na:")
      };
}
