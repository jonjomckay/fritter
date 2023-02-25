// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a nb_NO locale. All the
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
  String get localeName => 'nb_NO';

  static String m0(name) => "Slett ${name}-abonnementsgruppen?";

  static String m1(fileName) => "Data eksportert til ${fileName}";

  static String m2(fullPath) => "Data eksportert til ${fullPath}";

  static String m3(timeagoFormat) => "Sluttet ${timeagoFormat}";

  static String m4(timeagoFormat) => "Slutter ${timeagoFormat}";

  static String m5(snapshotData) => "Fullført med ${snapshotData} brukere";

  static String m6(name) => "Gruppe: ${name}";

  static String m7(snapshotData) =>
      "${snapshotData} brukere importert så langt";

  static String m8(date) => "Tok del ${date}";

  static String m9(num, numFormatted) =>
      "${Intl.plural(num, zero: 'ingen stemmer', one: 'én stemme', two: 'to stemmer', few: '${numFormatted} stemmer', many: '${numFormatted} stemme', other: '${numFormatted} stemmer')}";

  static String m10(errorMessage) =>
      "Sjekk at du er tilkoblet Internett.\n\n${errorMessage}";

  static String m11(releaseVersion) =>
      "Trykk for å laste ned ${releaseVersion}";

  static String m12(getMediaType) => "Trykk for å vise ${getMediaType}";

  static String m13(filePath) =>
      "Filen finnes ikke. Sørg for at den er å finne i ${filePath}";

  static String m14(thisTweetUserName, timeAgo) =>
      "${thisTweetUserName} re-tvitret";

  static String m15(num, numFormatted) =>
      "${Intl.plural(num, zero: 'ingen tvitringer', one: 'én tvitring', two: 'to tvitringer', few: '${numFormatted} tvitringer', many: '${numFormatted} tvitringer', other: '${numFormatted} tvitringer')}";

  static String m16(widgetPlaceName) =>
      "Kunne ikke laste ned tendenser for ${widgetPlaceName}";

  static String m17(responseStatusCode) =>
      "Kunne ikke lagre mediafilen. Twitter svarte med ${responseStatusCode}";

  static String m18(e) => "Kunne ikke sende ekkoforespørselen. ${e}";

  static String m19(statusCode) =>
      "Kunne ikke sende ekkoforespørselen. Statuskoden er ${statusCode}";

  static String m20(releaseVersion) =>
      "Oppgrader til ${releaseVersion} med din F-Droid-klient";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Om"),
        "account_suspended":
            MessageLookupByLibrary.simpleMessage("Kontoen er suspendert"),
        "activate_non_confirmation_bias_mode_description":
            MessageLookupByLibrary.simpleMessage(
                "Skjul forfattere av tvitringer. Unngå bekreftelsesbias basert på argumenter i form av autoriteter."),
        "activate_non_confirmation_bias_mode_label":
            MessageLookupByLibrary.simpleMessage("Forhindre bekreftelsesbias"),
        "add_to_group":
            MessageLookupByLibrary.simpleMessage("Legg til i gruppe"),
        "all": MessageLookupByLibrary.simpleMessage("Alle"),
        "all_the_great_software_used_by_fritter":
            MessageLookupByLibrary.simpleMessage(
                "All den flotte programvaren som brukes av Fritter"),
        "an_error_was_reported_to_sentry_thank_you":
            MessageLookupByLibrary.simpleMessage(
                "En feil ble rapportert til Sentry. Takk skal du ha!"),
        "an_update_for_fritter_is_available":
            MessageLookupByLibrary.simpleMessage(
                "En oppdatering for Fritter er tilgjengelig! 🚀"),
        "are_you_sure": MessageLookupByLibrary.simpleMessage("Er du sikker?"),
        "are_you_sure_you_want_to_delete_the_subscription_group_name_of_group":
            m0,
        "back": MessageLookupByLibrary.simpleMessage("Tilbake"),
        "blue_theme_based_on_the_twitter_color_scheme":
            MessageLookupByLibrary.simpleMessage(
                "Blå drakt basert på Twitter-fargepaletten"),
        "cancel": MessageLookupByLibrary.simpleMessage("Avbryt"),
        "catastrophic_failure":
            MessageLookupByLibrary.simpleMessage("Katastrofal feil"),
        "choose": MessageLookupByLibrary.simpleMessage("Velg"),
        "close": MessageLookupByLibrary.simpleMessage("Lukk"),
        "confirm_close_fritter":
            MessageLookupByLibrary.simpleMessage("Lukk Fritter?"),
        "contribute": MessageLookupByLibrary.simpleMessage("Bidra"),
        "copied_address_to_clipboard": MessageLookupByLibrary.simpleMessage(
            "Adresse kopiert til utklippstavle"),
        "copied_version_to_clipboard": MessageLookupByLibrary.simpleMessage(
            "Versjon kopiert til utklippstavlen"),
        "could_not_contact_twitter":
            MessageLookupByLibrary.simpleMessage("Kunne ikke kontakte Twitter"),
        "could_not_find_any_tweets_by_this_user":
            MessageLookupByLibrary.simpleMessage(
                "Kunne ikke finne noen tweets fra denne brukeren!"),
        "could_not_find_any_tweets_from_the_last_7_days":
            MessageLookupByLibrary.simpleMessage(
                "Kunne ikke finne noen tweets fra de siste 7 dagene!"),
        "country": MessageLookupByLibrary.simpleMessage("Land"),
        "dark": MessageLookupByLibrary.simpleMessage("Mørk"),
        "data": MessageLookupByLibrary.simpleMessage("Data"),
        "data_exported_to_fileName": m1,
        "data_exported_to_fullPath": m2,
        "data_imported_successfully":
            MessageLookupByLibrary.simpleMessage("Data importert"),
        "date_created":
            MessageLookupByLibrary.simpleMessage("Opprettelsesdato"),
        "date_subscribed":
            MessageLookupByLibrary.simpleMessage("Abonneringsdato"),
        "default_tab": MessageLookupByLibrary.simpleMessage("Forvalgt fane"),
        "delete": MessageLookupByLibrary.simpleMessage("Slett"),
        "disable_screenshots":
            MessageLookupByLibrary.simpleMessage("Skru av skjermavbildninger"),
        "disabled": MessageLookupByLibrary.simpleMessage("Avskrudd"),
        "don_not_send": MessageLookupByLibrary.simpleMessage("Ikke send"),
        "donate": MessageLookupByLibrary.simpleMessage("Doner"),
        "download": MessageLookupByLibrary.simpleMessage("Last ned"),
        "download_handling_type_ask":
            MessageLookupByLibrary.simpleMessage("Alltid spør"),
        "download_handling_type_directory":
            MessageLookupByLibrary.simpleMessage("Lagre i mappe"),
        "download_path": MessageLookupByLibrary.simpleMessage("Nedlastingssti"),
        "downloading_media":
            MessageLookupByLibrary.simpleMessage("Laster ned media …"),
        "enable_sentry":
            MessageLookupByLibrary.simpleMessage("Vil du aktivere Sentry?"),
        "ended_timeago_format_endsAt_allowFromNow_true": m3,
        "ends_timeago_format_endsAt_allowFromNow_true": m4,
        "enter_your_twitter_username": MessageLookupByLibrary.simpleMessage(
            "Skriv inn ditt Twitter-brukernavn"),
        "export": MessageLookupByLibrary.simpleMessage("Eksporter"),
        "export_settings":
            MessageLookupByLibrary.simpleMessage("Eksporter innstillinger?"),
        "export_subscription_group_members":
            MessageLookupByLibrary.simpleMessage(
                "Eksporter abonnementsgruppemedlemmer?"),
        "export_subscription_groups": MessageLookupByLibrary.simpleMessage(
            "Eksporter abonnementsgrupper?"),
        "export_subscriptions":
            MessageLookupByLibrary.simpleMessage("Eksporter abonnementer?"),
        "export_tweets":
            MessageLookupByLibrary.simpleMessage("Eksporter tvitringer?"),
        "export_your_data":
            MessageLookupByLibrary.simpleMessage("Eksporter dataen din"),
        "feed": MessageLookupByLibrary.simpleMessage("Informasjonsstrøm"),
        "filters": MessageLookupByLibrary.simpleMessage("Filtre"),
        "finished_with_snapshotData_users": m5,
        "followers": MessageLookupByLibrary.simpleMessage("Følgere"),
        "following": MessageLookupByLibrary.simpleMessage("Følger"),
        "fritter": MessageLookupByLibrary.simpleMessage("Fritter"),
        "fritter_blue": MessageLookupByLibrary.simpleMessage("Fritter-blå"),
        "general": MessageLookupByLibrary.simpleMessage("Generelt"),
        "group_name": m6,
        "groups": MessageLookupByLibrary.simpleMessage("Grupper"),
        "help_make_fritter_even_better": MessageLookupByLibrary.simpleMessage(
            "Hjelp til å gjøre Fritter enda bedre"),
        "help_support_fritters_future": MessageLookupByLibrary.simpleMessage(
            "Hjelp til å støtte Fritters fremtid"),
        "here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future":
            MessageLookupByLibrary.simpleMessage(
                "Denne dataen vil bli sendt. Den brukes kun til å bestemme hvilke enheter og språk som skal støttes i Fritter i fremtiden."),
        "home": MessageLookupByLibrary.simpleMessage("Hjem"),
        "if_you_have_any_feedback_on_this_feature_please_leave_it_on":
            MessageLookupByLibrary.simpleMessage(
                "Hvis du har tilbakemeldinger om denne funksjonen, vennligst la den være på"),
        "import": MessageLookupByLibrary.simpleMessage("Importer"),
        "import_data_from_another_device": MessageLookupByLibrary.simpleMessage(
            "Importer data fra en annen enhet"),
        "import_from_twitter":
            MessageLookupByLibrary.simpleMessage("Importer fra Twitter"),
        "import_subscriptions":
            MessageLookupByLibrary.simpleMessage("Importer abonnementer"),
        "imported_snapshot_data_users_so_far": m7,
        "include_replies": MessageLookupByLibrary.simpleMessage("Ta med svar"),
        "include_retweets":
            MessageLookupByLibrary.simpleMessage("Inkluder retweets"),
        "it_looks_like_you_have_already_said_hello_from_this_version_of_fritter":
            MessageLookupByLibrary.simpleMessage(
                "Det ser ut som du allerede har sagt hei fra denne versjonen av Fritter."),
        "it_looks_like_you_have_already_sent_a_ping_recently":
            MessageLookupByLibrary.simpleMessage(
                "Det ser ut til at du allerede har sendt en ekkoforespørsel 🤔"),
        "joined": m8,
        "language": MessageLookupByLibrary.simpleMessage("Språk"),
        "language_subtitle":
            MessageLookupByLibrary.simpleMessage("Krever omstart"),
        "large": MessageLookupByLibrary.simpleMessage("Stort"),
        "legacy_android_import":
            MessageLookupByLibrary.simpleMessage("Gammeldags Android-import"),
        "let_the_developers_know_if_something_is_broken":
            MessageLookupByLibrary.simpleMessage(
                "Gi beskjed til utviklerne hvis noe er ødelagt"),
        "licenses": MessageLookupByLibrary.simpleMessage("Lisenser"),
        "light": MessageLookupByLibrary.simpleMessage("Lys"),
        "live": MessageLookupByLibrary.simpleMessage("DIREKTE"),
        "logging": MessageLookupByLibrary.simpleMessage("Loggføring"),
        "media": MessageLookupByLibrary.simpleMessage("Media"),
        "media_size": MessageLookupByLibrary.simpleMessage("Mediastørrelse"),
        "medium": MessageLookupByLibrary.simpleMessage("Middels"),
        "name": MessageLookupByLibrary.simpleMessage("Navn"),
        "never_send": MessageLookupByLibrary.simpleMessage("Send aldri"),
        "newTrans": MessageLookupByLibrary.simpleMessage("Ny"),
        "no": MessageLookupByLibrary.simpleMessage("Nei"),
        "no_data_was_returned_which_should_never_happen_please_report_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "Ingen data ble returnert, noe som aldri skulle skje. Vennligst rapporter en feil, hvis mulig!"),
        "no_results": MessageLookupByLibrary.simpleMessage("Ingen resultater"),
        "no_subscriptions_try_searching_or_importing_some":
            MessageLookupByLibrary.simpleMessage(
                "Ingen abonnementer. Prøv å søke eller importere noen!"),
        "not_set": MessageLookupByLibrary.simpleMessage("Ikke satt"),
        "note_due_to_a_twitter_limitation_not_all_tweets_may_be_included":
            MessageLookupByLibrary.simpleMessage(
                "Merk: På grunn av en Twitter-begrensning kan det hende at ikke alle tweets er inkludert"),
        "numberFormat_format_total_votes": m9,
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "oops_something_went_wrong":
            MessageLookupByLibrary.simpleMessage("Oops! Noe gikk galt 🥲"),
        "open_app_settings":
            MessageLookupByLibrary.simpleMessage("Åpne programinnstillingene"),
        "pick_a_color": MessageLookupByLibrary.simpleMessage("Velg en farge!"),
        "pick_an_icon": MessageLookupByLibrary.simpleMessage("Velg et ikon"),
        "pinned_tweet": MessageLookupByLibrary.simpleMessage("Festet tvitring"),
        "playback_speed":
            MessageLookupByLibrary.simpleMessage("Avspillingshastighet"),
        "please_check_your_internet_connection_error_message": m10,
        "please_enter_a_name":
            MessageLookupByLibrary.simpleMessage("Vennligst skriv inn et navn"),
        "please_make_sure_the_data_you_wish_to_import_is_located_there_then_press_the_import_button_below":
            MessageLookupByLibrary.simpleMessage(
                "Forsikre deg om at dataen du ønsker å importere er å finne der. Deretter trykker du på «Import»-knappen nedenfor."),
        "please_note_that_the_method_fritter_uses_to_import_subscriptions_is_heavily_rate_limited_by_twitter_so_this_may_fail_if_you_have_a_lot_of_followed_accounts":
            MessageLookupByLibrary.simpleMessage(
                "Vær oppmerksom på at metoden Fritter bruker for å importere abonnementer er sterkt takstbegrenset av Twitter, så dette kan mislykkes hvis du har mange fulgte kontoer."),
        "prefix": MessageLookupByLibrary.simpleMessage("prefiks"),
        "private_profile":
            MessageLookupByLibrary.simpleMessage("Privat profil"),
        "released_under_the_mit_license":
            MessageLookupByLibrary.simpleMessage("Utgitt under MIT-lisensen"),
        "replying_to": MessageLookupByLibrary.simpleMessage("Svarer til"),
        "report": MessageLookupByLibrary.simpleMessage("Rapporter"),
        "report_a_bug":
            MessageLookupByLibrary.simpleMessage("Rapporter en feil"),
        "reporting_an_error":
            MessageLookupByLibrary.simpleMessage("Rapporterer en feil"),
        "retry": MessageLookupByLibrary.simpleMessage("Prøv på nytt"),
        "save": MessageLookupByLibrary.simpleMessage("Lagre"),
        "save_bandwidth_using_smaller_images":
            MessageLookupByLibrary.simpleMessage(
                "Spar båndbredde ved å bruke mindre bilder"),
        "saved": MessageLookupByLibrary.simpleMessage("Lagret"),
        "say_hello": MessageLookupByLibrary.simpleMessage("Si hei"),
        "say_hello_emoji": MessageLookupByLibrary.simpleMessage("Si hei 👋"),
        "search": MessageLookupByLibrary.simpleMessage("Søk"),
        "select": MessageLookupByLibrary.simpleMessage("Velg"),
        "selecting_individual_accounts_to_import_and_assigning_groups_are_both_planned_for_the_future_already":
            MessageLookupByLibrary.simpleMessage(
                "Valg av individuelle kontoer og importere, samt tildeling av grupper er allerede planlagt."),
        "send": MessageLookupByLibrary.simpleMessage("Send"),
        "send_a_non_identifying_ping_to_let_me_know_you_are_using_fritter_and_to_help_future_development":
            MessageLookupByLibrary.simpleMessage(
                "Send en ikke-identifiserende ekkoforespørsel til meg for å tilkjennegjøre at du bruker Fritter, og hjelp videre utvikling."),
        "send_always": MessageLookupByLibrary.simpleMessage("Send alltid"),
        "send_once": MessageLookupByLibrary.simpleMessage("Send en gang"),
        "share_tweet_content":
            MessageLookupByLibrary.simpleMessage("Del tvitringsinnhold"),
        "share_tweet_content_and_link": MessageLookupByLibrary.simpleMessage(
            "Del tvitringsinnhold og lenk"),
        "share_tweet_link":
            MessageLookupByLibrary.simpleMessage("Del tweet-lenke"),
        "small": MessageLookupByLibrary.simpleMessage("Lite"),
        "something_broke_in_fritter":
            MessageLookupByLibrary.simpleMessage("Noe brakk i Fritter."),
        "something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated":
            MessageLookupByLibrary.simpleMessage(
                "Noe gikk galt i Fritter, og en feilrapport har blitt generert. Rapporten kan sendes til Fritter-utviklerne for å hjelpe med å fikse problemet."),
        "sorry_the_replied_tweet_could_not_be_found":
            MessageLookupByLibrary.simpleMessage("Fant ikke svar-tvitringen."),
        "subscribe": MessageLookupByLibrary.simpleMessage("Abonnere"),
        "subscriptions": MessageLookupByLibrary.simpleMessage("Abonnementer"),
        "subtitles": MessageLookupByLibrary.simpleMessage("Undertitler"),
        "successfully_saved_the_media":
            MessageLookupByLibrary.simpleMessage("Media lagret."),
        "system": MessageLookupByLibrary.simpleMessage("System"),
        "tap_to_download_release_version": m11,
        "tap_to_show_getMediaType_item_type": m12,
        "thanks_for_helping_fritter": MessageLookupByLibrary.simpleMessage(
            "Takk for at du hjelper Fritter. 💖"),
        "thanks_for_reporting_we_will_try_and_fix_it_in_no_time":
            MessageLookupByLibrary.simpleMessage(
                "Takk for at du rapporterte. Vi skal prøve å fikse det på kort tid!"),
        "the_file_does_not_exist_please_ensure_it_is_located_at_file_path": m13,
        "the_tweet_did_not_contain_any_text_this_is_unexpected":
            MessageLookupByLibrary.simpleMessage(
                "Tweeten inneholdt ingen tekst. Dette er uventet"),
        "theme": MessageLookupByLibrary.simpleMessage("Drakt"),
        "theme_mode": MessageLookupByLibrary.simpleMessage("Draktmodus"),
        "there_were_no_trends_returned_this_is_unexpected_please_report_as_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "Det var ingen trender tilbake. Dette er uventet! Vennligst rapporter som en feil, hvis mulig."),
        "this_group_contains_no_subscriptions":
            MessageLookupByLibrary.simpleMessage(
                "Denne gruppen inneholder ingen abonnementer!"),
        "this_took_too_long_to_load_please_check_your_network_connection":
            MessageLookupByLibrary.simpleMessage(
                "Dette tok for lang tid å laste. Vennligst sjekk nettverkstilkoblingen din!"),
        "this_tweet_is_unavailable": MessageLookupByLibrary.simpleMessage(
            "Denne tweeten er utilgjengelig"),
        "this_tweet_user_name_retweeted": m14,
        "this_user_does_not_follow_anyone":
            MessageLookupByLibrary.simpleMessage(
                "Denne brukeren følger ingen!"),
        "this_user_does_not_have_anyone_following_them":
            MessageLookupByLibrary.simpleMessage(
                "Denne brukeren har ingen som følger dem!"),
        "thread": MessageLookupByLibrary.simpleMessage("Tråd"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("Miniatyrbilde"),
        "timed_out": MessageLookupByLibrary.simpleMessage("Tidsavbrudd"),
        "timed_out_trying_to_send_the_ping":
            MessageLookupByLibrary.simpleMessage(
                "Tidsavbrudd under forsendelse av ekkoforespørsel 😢"),
        "to_import_subscriptions_from_an_existing_twitter_account_enter_your_username_below":
            MessageLookupByLibrary.simpleMessage(
                "Skriv inn brukernavnet ditt nedenfor hvis du vil importere abonnementer fra en eksisterende Twitter-konto."),
        "toggle_all": MessageLookupByLibrary.simpleMessage("Veksle alt"),
        "trending": MessageLookupByLibrary.simpleMessage("Trender"),
        "trends": MessageLookupByLibrary.simpleMessage("Trender"),
        "true_black": MessageLookupByLibrary.simpleMessage("Helt svart?"),
        "tweets": MessageLookupByLibrary.simpleMessage("Tvitringer"),
        "tweets_and_replies":
            MessageLookupByLibrary.simpleMessage("Tvitringer og svar"),
        "tweets_number": m15,
        "unable_to_find_the_available_trend_locations":
            MessageLookupByLibrary.simpleMessage(
                "Kan ikke finne tilgjengelige trendplasseringer."),
        "unable_to_find_your_saved_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Kan ikke finne dine lagrede tweets."),
        "unable_to_import":
            MessageLookupByLibrary.simpleMessage("Kan ikke importere"),
        "unable_to_load_subscription_groups":
            MessageLookupByLibrary.simpleMessage(
                "Kan ikke laste inn abonnementsgrupper"),
        "unable_to_load_the_group":
            MessageLookupByLibrary.simpleMessage("Kan ikke laste inn gruppen"),
        "unable_to_load_the_group_settings":
            MessageLookupByLibrary.simpleMessage(
                "Kan ikke laste inn gruppeinnstillingene"),
        "unable_to_load_the_list_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Kan ikke laste inn listen over følger"),
        "unable_to_load_the_next_page_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Kunne ikke laste inn neste side med følgere"),
        "unable_to_load_the_next_page_of_replies":
            MessageLookupByLibrary.simpleMessage(
                "Kan ikke laste inn neste side med svar"),
        "unable_to_load_the_next_page_of_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Kan ikke laste inn neste side med tweets"),
        "unable_to_load_the_profile": MessageLookupByLibrary.simpleMessage(
            "Kunne ikke laste inn profilen"),
        "unable_to_load_the_search_results":
            MessageLookupByLibrary.simpleMessage(
                "Kan ikke laste søkeresultatene."),
        "unable_to_load_the_trends_for_widget_place_name": m16,
        "unable_to_load_the_tweet":
            MessageLookupByLibrary.simpleMessage("Kan ikke laste tweeten"),
        "unable_to_load_the_tweets": MessageLookupByLibrary.simpleMessage(
            "Kunne ikke laste inn tvitringene"),
        "unable_to_load_the_tweets_for_the_feed":
            MessageLookupByLibrary.simpleMessage(
                "Kan ikke laste inn tweets for feeden"),
        "unable_to_run_the_database_migrations":
            MessageLookupByLibrary.simpleMessage(
                "Kunne ikke kjøre databaseflytting"),
        "unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode":
            m17,
        "unable_to_send_the_ping_e_to_string": m18,
        "unable_to_send_the_ping_the_status_code_was_response_statusCode": m19,
        "unable_to_stream_the_trend_location_preference":
            MessageLookupByLibrary.simpleMessage(
                "Kunne ikke strømme tendensposisjonsvalg"),
        "unknown": MessageLookupByLibrary.simpleMessage("Ukjent"),
        "unsave": MessageLookupByLibrary.simpleMessage("Opphev lagring"),
        "unsubscribe":
            MessageLookupByLibrary.simpleMessage("Avslutte abonnementet"),
        "update_to_release_version_through_your_fdroid_client": m20,
        "updates": MessageLookupByLibrary.simpleMessage("Oppdateringer"),
        "use_true_black_for_the_dark_mode_theme":
            MessageLookupByLibrary.simpleMessage(
                "Bruk svart drakt for mørkt valg"),
        "user_not_found":
            MessageLookupByLibrary.simpleMessage("Bruker ikke funnet"),
        "username": MessageLookupByLibrary.simpleMessage("Brukernavn"),
        "version": MessageLookupByLibrary.simpleMessage("Versjon"),
        "when_a_new_app_update_is_available":
            MessageLookupByLibrary.simpleMessage(
                "Når en ny appoppdatering er tilgjengelig"),
        "whether_errors_should_be_reported_to_sentry":
            MessageLookupByLibrary.simpleMessage(
                "Om feil skal rapporteres til Sentry"),
        "which_tab_is_shown_when_the_app_opens":
            MessageLookupByLibrary.simpleMessage(
                "Hvilken fane som vises når programmet åpnes"),
        "would_you_like_to_enable_automatic_error_reporting":
            MessageLookupByLibrary.simpleMessage(
                "Vil du aktivere automatisk feilrapportering?"),
        "yes": MessageLookupByLibrary.simpleMessage("Ja"),
        "yes_please": MessageLookupByLibrary.simpleMessage("Ja"),
        "you_have_not_saved_any_tweets_yet":
            MessageLookupByLibrary.simpleMessage(
                "Du har ikke lagret noen tweets ennå!"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_data_can_only_be_imported_from":
            MessageLookupByLibrary.simpleMessage(
                "Enheten din kjører en versjon av Android eldre enn KitKat (4.4), så data kan kun importeres fra:"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to":
            MessageLookupByLibrary.simpleMessage(
                "Enheten din kjører en versjon av Android eldre enn KitKat (4.4), så eksporten kan kun lagres i:"),
        "your_profile_must_be_public_otherwise_the_import_will_not_work":
            MessageLookupByLibrary.simpleMessage(
                "Profilen din må være offentlig, ellers vil ikke importen fungere"),
        "your_report_will_be_sent_to_fritter_sentry_project":
            MessageLookupByLibrary.simpleMessage(
                "Rapporten din vil bli sendt til Fritter\'s Sentry-prosjekt, og personverndetaljer kan finnes på:")
      };
}
