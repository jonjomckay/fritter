// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ca locale. All the
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
  String get localeName => 'ca';

  static String m0(name) =>
      "Estàs segur que vols suprimir el grup de subscripcions ${name}?";

  static String m1(fileName) => "Dades exportades a ${fileName}";

  static String m2(fullPath) => "Dades exportades a ${fullPath}";

  static String m3(timeagoFormat) => "Acabat ${timeagoFormat}";

  static String m4(timeagoFormat) => "Acaba ${timeagoFormat}";

  static String m5(snapshotData) => "Finalitzat amb ${snapshotData} usuaris";

  static String m6(snapshotData) => "${snapshotData} usuaris importats per ara";

  static String m7(date) => "Es va unir el ${date}";

  static String m8(num, numFormatted) =>
      "${Intl.plural(num, zero: 'cap vot', one: 'un vot', two: 'dos vots', few: '${numFormatted} vots', many: '${numFormatted} vot', other: '${numFormatted} vots')}";

  static String m9(errorMessage) =>
      "Comprova la connexió a Internet.\n\n${errorMessage}";

  static String m10(releaseVersion) =>
      "Fes un toc per descarregar ${releaseVersion}";

  static String m11(getMediaType) => "Fes un toc per mostrar ${getMediaType}";

  static String m12(state) => "L\'estat de connexió ${state} no és compatible";

  static String m13(filePath) =>
      "El fitxer no existeix. Assegureu-vos que es troba a ${filePath}";

  static String m14(thisTweetUserName) => "${thisTweetUserName} retuitejat";

  static String m15(num, numFormatted) =>
      "${Intl.plural(num, zero: 'cap tweets', one: 'un tweet', two: 'dos tweets', few: '${numFormatted} tweets', many: '${numFormatted} tweet', other: '${numFormatted} tweets')}";

  static String m16(widgetPlaceName) =>
      "No s\'han pogut carregar les tendències per ${widgetPlaceName}";

  static String m17(e) =>
      "No es poden actualitzar les subscripcions. L\'error ha estat ${e}";

  static String m18(responseStatusCode) =>
      "No s\'ha pogut desar el suport. Twitter ha retornat un estat de ${responseStatusCode}";

  static String m19(e) => "No s\'ha pogut enviar el ping. ${e}";

  static String m20(statusCode) =>
      "No es pot enviar el ping. El codi d\'estatus és ${statusCode}";

  static String m21(releaseVersion) =>
      "Actualitza-ho a ${releaseVersion} a través del client de F-Droid";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Quant a"),
        "account_suspended":
            MessageLookupByLibrary.simpleMessage("Compte suspés"),
        "add_to_group": MessageLookupByLibrary.simpleMessage("Afegir al grup"),
        "all": MessageLookupByLibrary.simpleMessage("Tot"),
        "all_the_great_software_used_by_fritter":
            MessageLookupByLibrary.simpleMessage(
                "Tot el genial programari utilitzat per Fritter"),
        "an_error_was_reported_to_sentry_thank_you":
            MessageLookupByLibrary.simpleMessage(
                "S\'ha reportat un error a Sentry. Moltes gràcies!"),
        "an_update_for_fritter_is_available":
            MessageLookupByLibrary.simpleMessage(
                "Hi ha disponible una actualització per Fritter! 🚀"),
        "are_you_sure": MessageLookupByLibrary.simpleMessage("N\'estàs segur?"),
        "are_you_sure_you_want_to_delete_the_subscription_group_name_of_group":
            m0,
        "back": MessageLookupByLibrary.simpleMessage("Enrere"),
        "blue_theme_based_on_the_twitter_color_scheme":
            MessageLookupByLibrary.simpleMessage(
                "Tema blau basat en l\'esquema de colors de Twitter"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "catastrophic_failure":
            MessageLookupByLibrary.simpleMessage("Error catastròfic"),
        "contribute": MessageLookupByLibrary.simpleMessage("Col·laborar"),
        "copied_address_to_clipboard": MessageLookupByLibrary.simpleMessage(
            "S\'ha copiat l\'adreça al porta-retalls"),
        "copied_version_to_clipboard": MessageLookupByLibrary.simpleMessage(
            "Versió copiada al porta-retalls"),
        "could_not_contact_twitter": MessageLookupByLibrary.simpleMessage(
            "No s\'ha pogut contactar amb Twitter"),
        "could_not_find_any_tweets_by_this_user":
            MessageLookupByLibrary.simpleMessage(
                "No s\'ha trobat cap tuit d\'aquest usuari!"),
        "could_not_find_any_tweets_from_the_last_7_days":
            MessageLookupByLibrary.simpleMessage(
                "No s\'han trobat tuits dels últims 7 dies!"),
        "country": MessageLookupByLibrary.simpleMessage("País"),
        "dark": MessageLookupByLibrary.simpleMessage("Fosc"),
        "data": MessageLookupByLibrary.simpleMessage("Dades"),
        "data_exported_to_fileName": m1,
        "data_exported_to_fullPath": m2,
        "data_imported_successfully": MessageLookupByLibrary.simpleMessage(
            "Dades importades correctament"),
        "date_created": MessageLookupByLibrary.simpleMessage("Data de Creació"),
        "date_subscribed":
            MessageLookupByLibrary.simpleMessage("Data de Subscripció"),
        "default_tab":
            MessageLookupByLibrary.simpleMessage("Pestanya per defecte"),
        "delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "disabled": MessageLookupByLibrary.simpleMessage("Deshabilitat"),
        "don_not_send": MessageLookupByLibrary.simpleMessage("No enviar"),
        "donate": MessageLookupByLibrary.simpleMessage("Donar"),
        "download": MessageLookupByLibrary.simpleMessage("Descarregar"),
        "downloading_media":
            MessageLookupByLibrary.simpleMessage("Descarregant suports..."),
        "enable_sentry":
            MessageLookupByLibrary.simpleMessage("Habilitar Sentry?"),
        "ended_timeago_format_endsAt_allowFromNow_true": m3,
        "ends_timeago_format_endsAt_allowFromNow_true": m4,
        "enter_your_twitter_username": MessageLookupByLibrary.simpleMessage(
            "Introdeix el teu nom d\'usuari de Twitter"),
        "export": MessageLookupByLibrary.simpleMessage("Exportar"),
        "export_settings":
            MessageLookupByLibrary.simpleMessage("Exportar la configuració?"),
        "export_subscription_group_members":
            MessageLookupByLibrary.simpleMessage(
                "Exportar els membres dels grups de subscripcions?"),
        "export_subscription_groups": MessageLookupByLibrary.simpleMessage(
            "Exportar els grups de subscripcions?"),
        "export_subscriptions":
            MessageLookupByLibrary.simpleMessage("Exportar les subscripcions?"),
        "export_tweets":
            MessageLookupByLibrary.simpleMessage("Exportar tuits?"),
        "export_your_data":
            MessageLookupByLibrary.simpleMessage("Expotar les teves dades"),
        "feed": MessageLookupByLibrary.simpleMessage("Continguts"),
        "filters": MessageLookupByLibrary.simpleMessage("Filtres"),
        "finished_with_snapshotData_users": m5,
        "followers": MessageLookupByLibrary.simpleMessage("Seguidors"),
        "following": MessageLookupByLibrary.simpleMessage("Seguint"),
        "fritter": MessageLookupByLibrary.simpleMessage("Fritter"),
        "fritter_blue": MessageLookupByLibrary.simpleMessage("Fritter blau"),
        "general": MessageLookupByLibrary.simpleMessage("General"),
        "groups": MessageLookupByLibrary.simpleMessage("Grups"),
        "help_make_fritter_even_better": MessageLookupByLibrary.simpleMessage(
            "Ajuda a fer que Fritter sigui encara millor"),
        "help_support_fritters_future": MessageLookupByLibrary.simpleMessage(
            "Ajuda a donar suport al futur de Fritter"),
        "here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future":
            MessageLookupByLibrary.simpleMessage(
                "Aquestes són les dades que s\'enviaran. Només s\'utilitzaràn per determinar en quins dispositius i idiomes donarà suport Fritter en el futur."),
        "if_you_have_any_feedback_on_this_feature_please_leave_it_on":
            MessageLookupByLibrary.simpleMessage(
                "Si tens algun comentari sobre aquesta funció, deixeu-la a"),
        "import": MessageLookupByLibrary.simpleMessage("Importar"),
        "import_data_from_another_device": MessageLookupByLibrary.simpleMessage(
            "Importa dades des d\'un altre dispositiu"),
        "import_from_twitter":
            MessageLookupByLibrary.simpleMessage("Importar de Twitter"),
        "import_subscriptions":
            MessageLookupByLibrary.simpleMessage("Importar subscripcions"),
        "imported_snapshot_data_users_so_far": m6,
        "include_replies":
            MessageLookupByLibrary.simpleMessage("Incloure respostes"),
        "include_retweets":
            MessageLookupByLibrary.simpleMessage("Incloure retuits"),
        "it_looks_like_you_have_already_said_hello_from_this_version_of_fritter":
            MessageLookupByLibrary.simpleMessage(
                "Sembla que ja has saludat des d\'aquesta versió de Fritter!"),
        "it_looks_like_you_have_already_sent_a_ping_recently":
            MessageLookupByLibrary.simpleMessage(
                "Sembla que ja has enviat un ping recentment 🤔"),
        "joined": m7,
        "large": MessageLookupByLibrary.simpleMessage("Gran"),
        "legacy_android_import":
            MessageLookupByLibrary.simpleMessage("Importa de Legacy Android"),
        "let_the_developers_know_if_something_is_broken":
            MessageLookupByLibrary.simpleMessage(
                "Fes saber als desenvolupadors si alguna cosa s\'ha trencat"),
        "licenses": MessageLookupByLibrary.simpleMessage("Llicències"),
        "light": MessageLookupByLibrary.simpleMessage("Clar"),
        "live": MessageLookupByLibrary.simpleMessage("DIRECTE"),
        "logging": MessageLookupByLibrary.simpleMessage("Enregistrament"),
        "media": MessageLookupByLibrary.simpleMessage("Mèdia"),
        "media_size": MessageLookupByLibrary.simpleMessage("Tamany de mèdia"),
        "medium": MessageLookupByLibrary.simpleMessage("Mitjà"),
        "name": MessageLookupByLibrary.simpleMessage("Nom"),
        "never_send": MessageLookupByLibrary.simpleMessage("No enviar mai"),
        "newTrans": MessageLookupByLibrary.simpleMessage("Nou"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "no_data_was_returned_which_should_never_happen_please_report_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "No s\'han retornat dades, cosa que no hauria de passar mai. Si us plau, informa de l\'error, si és possible!"),
        "no_results": MessageLookupByLibrary.simpleMessage("Sense resultats"),
        "no_subscriptions_try_searching_or_importing_some":
            MessageLookupByLibrary.simpleMessage(
                "No hi ha subscripcions. Prova de cercar-ne o importar-ne alguna!"),
        "note_due_to_a_twitter_limitation_not_all_tweets_may_be_included":
            MessageLookupByLibrary.simpleMessage(
                "Nota: A causa d\'una limitació de Twitter, no es poden incloure tots els tuits"),
        "numberFormat_format_total_votes": m8,
        "ok": MessageLookupByLibrary.simpleMessage("D\'acord"),
        "oops_something_went_wrong": MessageLookupByLibrary.simpleMessage(
            "Ui! Alguna cosa ha anat malament 🥲"),
        "pick_a_color": MessageLookupByLibrary.simpleMessage("Tria un color!"),
        "pinned_tweet": MessageLookupByLibrary.simpleMessage("Tuit ancorat"),
        "playback_speed":
            MessageLookupByLibrary.simpleMessage("Velocitat de reproducció"),
        "please_check_your_internet_connection_error_message": m9,
        "please_enter_a_name": MessageLookupByLibrary.simpleMessage(
            "Si us plau introdueix un nom"),
        "please_make_sure_the_data_you_wish_to_import_is_located_there_then_press_the_import_button_below":
            MessageLookupByLibrary.simpleMessage(
                "Assegura\'t que les dades a importar es troben en aquesta direcció, i prem el botó d\'importar a continuació."),
        "please_note_that_the_method_fritter_uses_to_import_subscriptions_is_heavily_rate_limited_by_twitter_so_this_may_fail_if_you_have_a_lot_of_followed_accounts":
            MessageLookupByLibrary.simpleMessage(
                "Tingueu en compte que el mètode que Fritter utilitza per importar subscripcions està fortament limitat per Twitter, de manera que això pot fallar si teniu molts comptes seguits."),
        "prefix": MessageLookupByLibrary.simpleMessage("prefix"),
        "private_profile":
            MessageLookupByLibrary.simpleMessage("Perfil privat"),
        "released_under_the_mit_license": MessageLookupByLibrary.simpleMessage(
            "Llançat sota la llicència MIT"),
        "replying_to": MessageLookupByLibrary.simpleMessage("Responent a"),
        "report": MessageLookupByLibrary.simpleMessage("Reportar"),
        "report_a_bug":
            MessageLookupByLibrary.simpleMessage("Informar d\'un error"),
        "reporting_an_error":
            MessageLookupByLibrary.simpleMessage("Reportar un error"),
        "retry": MessageLookupByLibrary.simpleMessage("Reintentar"),
        "save": MessageLookupByLibrary.simpleMessage("Desa"),
        "save_bandwidth_using_smaller_images":
            MessageLookupByLibrary.simpleMessage(
                "Estalviar amplada de banda utilitzant imatges més petites"),
        "saved": MessageLookupByLibrary.simpleMessage("Desat"),
        "say_hello": MessageLookupByLibrary.simpleMessage("Saluda"),
        "say_hello_emoji": MessageLookupByLibrary.simpleMessage("Saluda 👋"),
        "selecting_individual_accounts_to_import_and_assigning_groups_are_both_planned_for_the_future_already":
            MessageLookupByLibrary.simpleMessage(
                "La selecció de comptes individuals per importar i l\'assignació de grups ja estan planificats per al futur!"),
        "send": MessageLookupByLibrary.simpleMessage("Enviar"),
        "send_a_non_identifying_ping_to_let_me_know_you_are_using_fritter_and_to_help_future_development":
            MessageLookupByLibrary.simpleMessage(
                "Envia un ping no identificatiu per fer-me saber que estàs utilitzant Fritter i ajudar-me amb el futur desenvolupament"),
        "send_always": MessageLookupByLibrary.simpleMessage("Enviar sempre"),
        "send_once": MessageLookupByLibrary.simpleMessage("Enviar una vegada"),
        "share_tweet_content": MessageLookupByLibrary.simpleMessage(
            "Compartir el contingut del tuit"),
        "share_tweet_link": MessageLookupByLibrary.simpleMessage(
            "Compartir l\'enllaç del tuit"),
        "small": MessageLookupByLibrary.simpleMessage("Petit"),
        "something_broke_in_fritter": MessageLookupByLibrary.simpleMessage(
            "S\'ha trencat alguna cosa a Fritter."),
        "something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated":
            MessageLookupByLibrary.simpleMessage(
                "Alguna cosa ha sortit malament a Fritter i s\'ha generat un informe d\'error. L\'informe es pot enviar als desenvolupadors de Fritter per ajudar a solucionar el problema."),
        "sorry_the_replied_tweet_could_not_be_found":
            MessageLookupByLibrary.simpleMessage(
                "Disculpa, el tuit contestat no s\'ha pogut trobar!"),
        "subscribe": MessageLookupByLibrary.simpleMessage("Subscriure"),
        "subscriptions": MessageLookupByLibrary.simpleMessage("Subscripcions"),
        "subtitles": MessageLookupByLibrary.simpleMessage("Subtítols"),
        "successfully_saved_the_media":
            MessageLookupByLibrary.simpleMessage("Suport desat."),
        "system": MessageLookupByLibrary.simpleMessage("Sistema"),
        "tap_to_download_release_version": m10,
        "tap_to_show_getMediaType_item_type": m11,
        "thanks_for_helping_fritter": MessageLookupByLibrary.simpleMessage(
            "Gràcies per ajudar a Fritter! 💖"),
        "thanks_for_reporting_we_will_try_and_fix_it_in_no_time":
            MessageLookupByLibrary.simpleMessage(
                "Gràcies per informar. Intentarem solucionar-ho de seguida!"),
        "the_connection_state_state_is_not_supported": m12,
        "the_file_does_not_exist_please_ensure_it_is_located_at_file_path": m13,
        "the_tweet_did_not_contain_any_text_this_is_unexpected":
            MessageLookupByLibrary.simpleMessage(
                "El tuit no contenia text. Això és inesperat"),
        "theme": MessageLookupByLibrary.simpleMessage("Tema"),
        "there_were_no_trends_returned_this_is_unexpected_please_report_as_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "No s\'han retornat les tendències. Això és inesperat! Si us plau, informeu-ho com a error, si és possible."),
        "this_group_contains_no_subscriptions":
            MessageLookupByLibrary.simpleMessage(
                "Aquest grup no conté subscripcions!"),
        "this_took_too_long_to_load_please_check_your_network_connection":
            MessageLookupByLibrary.simpleMessage(
                "Ha trigat massa a carregar-se. Comprova la connexió de xarxa!"),
        "this_tweet_is_unavailable": MessageLookupByLibrary.simpleMessage(
            "Aquest tuit no està disponible"),
        "this_tweet_user_name_retweeted": m14,
        "this_user_does_not_follow_anyone":
            MessageLookupByLibrary.simpleMessage(
                "Aquest usuari no segueix a ningú!"),
        "this_user_does_not_have_anyone_following_them":
            MessageLookupByLibrary.simpleMessage(
                "Aquest usuari no té ningú que els segueixi!"),
        "thread": MessageLookupByLibrary.simpleMessage("Fil"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("Miniatura"),
        "timed_out": MessageLookupByLibrary.simpleMessage("Temps excedit"),
        "timed_out_trying_to_send_the_ping":
            MessageLookupByLibrary.simpleMessage(
                "S\'ha esgotat el temps intentant enviar el ping 😢"),
        "to_import_subscriptions_from_an_existing_twitter_account_enter_your_username_below":
            MessageLookupByLibrary.simpleMessage(
                "Per importar subscripcions des d\'un compte de Twitter existent, introduïu el vostre nom d\'usuari a continuació."),
        "toggle_all": MessageLookupByLibrary.simpleMessage("Commuta-ho tot"),
        "trending": MessageLookupByLibrary.simpleMessage("Tendències"),
        "trends": MessageLookupByLibrary.simpleMessage("Tendències"),
        "true_black":
            MessageLookupByLibrary.simpleMessage("Veritablement Fosc?"),
        "tweets": MessageLookupByLibrary.simpleMessage("Tuits"),
        "tweets_and_replies":
            MessageLookupByLibrary.simpleMessage("Tweets i Respostes"),
        "tweets_number": m15,
        "unable_to_check_if_this_is_a_legacy_Android_device":
            MessageLookupByLibrary.simpleMessage(
                "No es pot comprovar si es tracta d\'un dispositiu Android Legacy."),
        "unable_to_find_the_app_package_info":
            MessageLookupByLibrary.simpleMessage(
                "No s\'ha pogut trobar la informació del paquet de l\'aplicació"),
        "unable_to_find_the_available_trend_locations":
            MessageLookupByLibrary.simpleMessage(
                "No s\'han pogut trobar les ubicacions de tendència disponibles."),
        "unable_to_find_your_saved_tweets":
            MessageLookupByLibrary.simpleMessage(
                "No s\'han pogut trobar els tweets desats."),
        "unable_to_import":
            MessageLookupByLibrary.simpleMessage("No s\'ha pogut importar"),
        "unable_to_load_subscription_groups":
            MessageLookupByLibrary.simpleMessage(
                "No s\'han pogut carregar les subscripcions als grups"),
        "unable_to_load_the_group": MessageLookupByLibrary.simpleMessage(
            "No s\'ha pogut carregar el grup"),
        "unable_to_load_the_group_settings":
            MessageLookupByLibrary.simpleMessage(
                "No es pot carregar la configuració del grup"),
        "unable_to_load_the_list_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "No es pot carregar la llista de Seguint"),
        "unable_to_load_the_next_page_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "No es pot carregar la pàgina següent de Seguint"),
        "unable_to_load_the_next_page_of_replies":
            MessageLookupByLibrary.simpleMessage(
                "No s\'ha pogut carregar la pròxima pàgina de respostes"),
        "unable_to_load_the_next_page_of_tweets":
            MessageLookupByLibrary.simpleMessage(
                "No es pot carregar la següent pàgina de tuits"),
        "unable_to_load_the_profile": MessageLookupByLibrary.simpleMessage(
            "No s\'ha pogut carregar el perfil"),
        "unable_to_load_the_search_results":
            MessageLookupByLibrary.simpleMessage(
                "No s\'han pogut carregar els resultats de la cerca."),
        "unable_to_load_the_trends_for_widget_place_name": m16,
        "unable_to_load_the_tweet": MessageLookupByLibrary.simpleMessage(
            "No s\'ha pogut carregat el tuit"),
        "unable_to_load_the_tweets": MessageLookupByLibrary.simpleMessage(
            "No s\'han pogut carregar els tweets"),
        "unable_to_load_the_tweets_for_the_feed":
            MessageLookupByLibrary.simpleMessage(
                "No es poden carregar els tuits del canal de Continguts"),
        "unable_to_refresh_the_subscriptions_the_error_was_e": m17,
        "unable_to_run_the_database_migrations":
            MessageLookupByLibrary.simpleMessage(
                "No s\'han pogut executar les migracions de la base de dades"),
        "unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode":
            m18,
        "unable_to_send_the_ping_e_to_string": m19,
        "unable_to_send_the_ping_the_status_code_was_response_statusCode": m20,
        "unable_to_stream_the_trend_location_preference":
            MessageLookupByLibrary.simpleMessage(
                "No s\'ha pogut transmetre la preferència d\'ubicació de la tendència"),
        "unknown": MessageLookupByLibrary.simpleMessage("Desconegut"),
        "unsave": MessageLookupByLibrary.simpleMessage("Desfés"),
        "unsubscribe":
            MessageLookupByLibrary.simpleMessage("Anul·lar subscripció"),
        "update_to_release_version_through_your_fdroid_client": m21,
        "updates": MessageLookupByLibrary.simpleMessage("Actualitzacions"),
        "use_true_black_for_the_dark_mode_theme":
            MessageLookupByLibrary.simpleMessage(
                "Utilitza negre veritable per al tema del mode fosc"),
        "user_not_found":
            MessageLookupByLibrary.simpleMessage("Usuari no trobat"),
        "username": MessageLookupByLibrary.simpleMessage("Nom d\'usuari"),
        "version": MessageLookupByLibrary.simpleMessage("Versió"),
        "when_a_new_app_update_is_available":
            MessageLookupByLibrary.simpleMessage(
                "Quan hi ha disponible una nova actualització d\'una aplicació"),
        "whether_errors_should_be_reported_to_sentry":
            MessageLookupByLibrary.simpleMessage(
                "Si s\'han d\'informar els errors a Sentry"),
        "which_tab_is_shown_when_the_app_opens":
            MessageLookupByLibrary.simpleMessage(
                "Quina pestanya es mostra quan s\'obre l\'aplicació"),
        "would_you_like_to_enable_automatic_error_reporting":
            MessageLookupByLibrary.simpleMessage(
                "Vols habilitar l\'informe automàtic d\'errors?"),
        "yes": MessageLookupByLibrary.simpleMessage("Sí"),
        "you_have_not_saved_any_tweets_yet":
            MessageLookupByLibrary.simpleMessage(
                "Encara no has desat cap tweet!"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_data_can_only_be_imported_from":
            MessageLookupByLibrary.simpleMessage(
                "El dispositiu està executant una versió d\'Android anterior a KitKat (4.4), de manera que les dades només es poden importar des de:"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to":
            MessageLookupByLibrary.simpleMessage(
                "El dispositiu té una versió d\'Android anterior a KitKat (4.4), de manera que l\'exportació només es pot desar a:"),
        "your_profile_must_be_public_otherwise_the_import_will_not_work":
            MessageLookupByLibrary.simpleMessage(
                "El teu perfil ha de ser públic, en cas contrari la importació no funcionarà"),
        "your_report_will_be_sent_to_fritter_sentry_project":
            MessageLookupByLibrary.simpleMessage(
                "L\'informe s\'enviarà al projecte Sentry de Fritter, els detalls de privadesa es poden trobar a:")
      };
}
