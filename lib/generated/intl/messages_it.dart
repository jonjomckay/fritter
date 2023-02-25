// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static String m0(name) =>
      "Sei sicuro/a di voler eliminare il gruppo di sottoscrizione ${name}?";

  static String m1(fileName) => "Dati esportati in ${fileName}";

  static String m2(fullPath) => "Dati esportati in ${fullPath}";

  static String m3(timeagoFormat) => "Finito ${timeagoFormat}";

  static String m4(timeagoFormat) => "Finisce ${timeagoFormat}";

  static String m5(snapshotData) => "Finito con ${snapshotData} utenti";

  static String m6(name) => "Gruppo: ${name}";

  static String m7(snapshotData) => "${snapshotData} utenti importati finora";

  static String m8(date) => "Iscrizione a ${date}";

  static String m9(num, numFormatted) =>
      "${Intl.plural(num, zero: 'Nessun voto', one: 'Un voto', two: 'Due voti', few: '${numFormatted} voti', many: '${numFormatted} voto', other: '${numFormatted} voti')}";

  static String m10(errorMessage) =>
      "Per favore controlla la tua connessione a Internet.\n\n${errorMessage}";

  static String m11(releaseVersion) => "Clicca per scaricare ${releaseVersion}";

  static String m12(getMediaType) => "Tocca per mostrare ${getMediaType}";

  static String m13(filePath) =>
      "Il file non esiste. Si prega di assicurarsi che sia situato in ${filePath}";

  static String m14(thisTweetUserName, timeAgo) =>
      "${thisTweetUserName} ha ritwittato ${timeAgo}";

  static String m15(num, numFormatted) =>
      "${Intl.plural(num, zero: 'nessun tweet', one: 'un tweet', two: 'due tweet', few: '${numFormatted} tweet', many: '${numFormatted} tweet', other: '${numFormatted} tweet')}";

  static String m16(widgetPlaceName) =>
      "Impossibile caricare le tendenze per ${widgetPlaceName}";

  static String m17(responseStatusCode) =>
      "Impossibile salvare il contenuto. Twitter ha restituito uno stato di ${responseStatusCode}";

  static String m18(e) => "Impossibile inviare il ping. ${e}";

  static String m19(statusCode) =>
      "Impossibile inviare il ping. Il codice di stato era ${statusCode}";

  static String m20(releaseVersion) =>
      "Aggiorna a ${releaseVersion} tramite il tuo client F-Droid";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Info"),
        "account_suspended":
            MessageLookupByLibrary.simpleMessage("Profilo sospeso"),
        "activate_non_confirmation_bias_mode_description":
            MessageLookupByLibrary.simpleMessage(
                "Nascondi autori dei tweet. Impedisci il bias di conferma causato da discussioni autoritarie."),
        "activate_non_confirmation_bias_mode_label":
            MessageLookupByLibrary.simpleMessage(
                "Modalità anti bias di conferma"),
        "add_to_group":
            MessageLookupByLibrary.simpleMessage("Aggiungi al gruppo"),
        "all": MessageLookupByLibrary.simpleMessage("Tutti"),
        "all_the_great_software_used_by_fritter":
            MessageLookupByLibrary.simpleMessage(
                "Tutto l\'ottimo software utilizzato da Fritter"),
        "an_error_was_reported_to_sentry_thank_you":
            MessageLookupByLibrary.simpleMessage(
                "Un errore è stato segnalato a Sentry. Grazie!"),
        "an_update_for_fritter_is_available":
            MessageLookupByLibrary.simpleMessage(
                "È disponibile un aggiornamento di Fritter! 🚀"),
        "are_you_sure": MessageLookupByLibrary.simpleMessage("Sei sicuro?"),
        "are_you_sure_you_want_to_delete_the_subscription_group_name_of_group":
            m0,
        "back": MessageLookupByLibrary.simpleMessage("Indietro"),
        "bad_guest_token": MessageLookupByLibrary.simpleMessage(
            "Twitter ha invalidato il nostro token di accesso. Prova a riaprire Fritter!"),
        "blue_theme_based_on_the_twitter_color_scheme":
            MessageLookupByLibrary.simpleMessage(
                "Tema blu basato sui colori di Twitter"),
        "cancel": MessageLookupByLibrary.simpleMessage("Annulla"),
        "catastrophic_failure":
            MessageLookupByLibrary.simpleMessage("Fallimento catastrofico"),
        "choose": MessageLookupByLibrary.simpleMessage("Scegli"),
        "close": MessageLookupByLibrary.simpleMessage("Chiudi"),
        "confirm_close_fritter": MessageLookupByLibrary.simpleMessage(
            "Sei sicuro di voler chiudere Fritter?"),
        "contribute": MessageLookupByLibrary.simpleMessage("Contribuisci"),
        "copied_address_to_clipboard": MessageLookupByLibrary.simpleMessage(
            "Indirizzo copiato negli appunti"),
        "copied_version_to_clipboard": MessageLookupByLibrary.simpleMessage(
            "Versione copiata negli appunti"),
        "could_not_contact_twitter": MessageLookupByLibrary.simpleMessage(
            "Impossibile contattare Twitter"),
        "could_not_find_any_tweets_by_this_user":
            MessageLookupByLibrary.simpleMessage(
                "Non è stato trovato nessun tweet di questo utente!"),
        "could_not_find_any_tweets_from_the_last_7_days":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile trovare tweet negli ultimi 7 giorni!"),
        "country": MessageLookupByLibrary.simpleMessage("Nazione"),
        "dark": MessageLookupByLibrary.simpleMessage("Scuro"),
        "data": MessageLookupByLibrary.simpleMessage("Dati"),
        "data_exported_to_fileName": m1,
        "data_exported_to_fullPath": m2,
        "data_imported_successfully":
            MessageLookupByLibrary.simpleMessage("Dati importati con successo"),
        "date_created":
            MessageLookupByLibrary.simpleMessage("Data di Creazione"),
        "date_subscribed":
            MessageLookupByLibrary.simpleMessage("Data di Iscrizione"),
        "default_tab":
            MessageLookupByLibrary.simpleMessage("Scheda predefinita"),
        "delete": MessageLookupByLibrary.simpleMessage("Elimina"),
        "disable_screenshots":
            MessageLookupByLibrary.simpleMessage("Disattiva screenshot"),
        "disable_screenshots_hint": MessageLookupByLibrary.simpleMessage(
            "Impedisce di poter acquisire screenshot. Potrebbe non funzionare su tutti i dispositivi."),
        "disabled": MessageLookupByLibrary.simpleMessage("Disabilitato"),
        "don_not_send": MessageLookupByLibrary.simpleMessage("Non inviare"),
        "donate": MessageLookupByLibrary.simpleMessage("Dona"),
        "download": MessageLookupByLibrary.simpleMessage("Scarica"),
        "download_handling":
            MessageLookupByLibrary.simpleMessage("Gestione degli scaricamenti"),
        "download_handling_description": MessageLookupByLibrary.simpleMessage(
            "Come dovrebbe funzionare lo scaricamento"),
        "download_handling_type_ask":
            MessageLookupByLibrary.simpleMessage("Chiedi sempre"),
        "download_handling_type_directory":
            MessageLookupByLibrary.simpleMessage("Salva nella directory"),
        "download_media_no_url": MessageLookupByLibrary.simpleMessage(
            "Impossibile scaricare. Questo media potrebbe essere solo disponibile come stream, che Fritter non supporta ancora."),
        "download_path":
            MessageLookupByLibrary.simpleMessage("Percorso di scaricamento"),
        "downloading_media":
            MessageLookupByLibrary.simpleMessage("Scaricando contenuto..."),
        "enable_sentry":
            MessageLookupByLibrary.simpleMessage("Abilitare Sentry?"),
        "ended_timeago_format_endsAt_allowFromNow_true": m3,
        "ends_timeago_format_endsAt_allowFromNow_true": m4,
        "enter_your_twitter_username": MessageLookupByLibrary.simpleMessage(
            "Inserisci il tuo nome utente di Twitter"),
        "export": MessageLookupByLibrary.simpleMessage("Esporta"),
        "export_settings":
            MessageLookupByLibrary.simpleMessage("Esportare le impostazioni?"),
        "export_subscription_group_members":
            MessageLookupByLibrary.simpleMessage(
                "Esportare i membri dei gruppi di iscrizioni?"),
        "export_subscription_groups": MessageLookupByLibrary.simpleMessage(
            "Esportare i gruppi di iscrizioni?"),
        "export_subscriptions":
            MessageLookupByLibrary.simpleMessage("Esportare le iscrizioni?"),
        "export_tweets":
            MessageLookupByLibrary.simpleMessage("Esportare i tweet?"),
        "export_your_data":
            MessageLookupByLibrary.simpleMessage("Esporta i tuoi dati"),
        "feed": MessageLookupByLibrary.simpleMessage("Feed"),
        "filters": MessageLookupByLibrary.simpleMessage("Filtri"),
        "finished_with_snapshotData_users": m5,
        "followers": MessageLookupByLibrary.simpleMessage("Seguaci"),
        "following": MessageLookupByLibrary.simpleMessage("Seguiti"),
        "forbidden": MessageLookupByLibrary.simpleMessage(
            "Twitter dice che l\'accesso a questo è vietato"),
        "fritter": MessageLookupByLibrary.simpleMessage("Fritter"),
        "fritter_blue": MessageLookupByLibrary.simpleMessage("Fritter Blu"),
        "general": MessageLookupByLibrary.simpleMessage("Generale"),
        "group_name": m6,
        "groups": MessageLookupByLibrary.simpleMessage("Gruppi"),
        "help_make_fritter_even_better": MessageLookupByLibrary.simpleMessage(
            "Aiuta a rendere Fritter migliore"),
        "help_support_fritters_future": MessageLookupByLibrary.simpleMessage(
            "Aiuta a supportare il futuro di Fritter"),
        "here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future":
            MessageLookupByLibrary.simpleMessage(
                "Ecco i dati che verranno inviati. Saranno usati solo per determinare quali dispositivi e lingue supportare su Fritter in futuro."),
        "hide_sensitive_tweets":
            MessageLookupByLibrary.simpleMessage("Nascondi tweet sensibili"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "if_you_have_any_feedback_on_this_feature_please_leave_it_on":
            MessageLookupByLibrary.simpleMessage(
                "Se hai qualche feedback su questa funzione, per favore lascialo"),
        "import": MessageLookupByLibrary.simpleMessage("Importa"),
        "import_data_from_another_device": MessageLookupByLibrary.simpleMessage(
            "Importa dati da un altro dispositivo"),
        "import_from_twitter":
            MessageLookupByLibrary.simpleMessage("Importa da Twitter"),
        "import_subscriptions":
            MessageLookupByLibrary.simpleMessage("Importa iscrizioni"),
        "imported_snapshot_data_users_so_far": m7,
        "include_replies":
            MessageLookupByLibrary.simpleMessage("Includi risposte"),
        "include_retweets":
            MessageLookupByLibrary.simpleMessage("Includi retweet"),
        "it_looks_like_you_have_already_said_hello_from_this_version_of_fritter":
            MessageLookupByLibrary.simpleMessage(
                "Sembra che tu abbia già detto ciao da questa versione di Fritter!"),
        "it_looks_like_you_have_already_sent_a_ping_recently":
            MessageLookupByLibrary.simpleMessage(
                "Sembra che tu abbia già inviato un ping di recente 🤔"),
        "joined": m8,
        "language": MessageLookupByLibrary.simpleMessage("Lingua"),
        "language_subtitle":
            MessageLookupByLibrary.simpleMessage("Richiede un riavvio"),
        "large": MessageLookupByLibrary.simpleMessage("Grande"),
        "legacy_android_import":
            MessageLookupByLibrary.simpleMessage("Importa Android Legacy"),
        "let_the_developers_know_if_something_is_broken":
            MessageLookupByLibrary.simpleMessage(
                "Lascia che gli sviluppatori sappiano se qualcosa è malfunzionante"),
        "licenses": MessageLookupByLibrary.simpleMessage("Licenze"),
        "light": MessageLookupByLibrary.simpleMessage("Chiaro"),
        "live": MessageLookupByLibrary.simpleMessage("LIVE"),
        "logging": MessageLookupByLibrary.simpleMessage("Registro"),
        "media": MessageLookupByLibrary.simpleMessage("Contenuti"),
        "media_size":
            MessageLookupByLibrary.simpleMessage("Dimensione dei media"),
        "medium": MessageLookupByLibrary.simpleMessage("Medio"),
        "name": MessageLookupByLibrary.simpleMessage("Nome"),
        "never_send": MessageLookupByLibrary.simpleMessage("Non inviare mai"),
        "newTrans": MessageLookupByLibrary.simpleMessage("Nuovo"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "no_data_was_returned_which_should_never_happen_please_report_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "Nessun dato è stato restituito, che non dovrebbe mai accadere. Si prega di segnalare un bug, se possibile!"),
        "no_results": MessageLookupByLibrary.simpleMessage("Nessun risultato"),
        "no_results_for":
            MessageLookupByLibrary.simpleMessage("Nessun risultato per:"),
        "no_subscriptions_try_searching_or_importing_some":
            MessageLookupByLibrary.simpleMessage(
                "Nessuna iscrizione. Prova a cercare o importane alcuni!"),
        "not_set": MessageLookupByLibrary.simpleMessage("Non impostato"),
        "note_due_to_a_twitter_limitation_not_all_tweets_may_be_included":
            MessageLookupByLibrary.simpleMessage(
                "Nota: a causa di una limitazione di Twitter, non tutti i tweet potrebbero essere inclusi"),
        "numberFormat_format_total_votes": m9,
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "oops_something_went_wrong": MessageLookupByLibrary.simpleMessage(
            "Ops! Qualcosa è andato storto 🥲"),
        "open_app_settings":
            MessageLookupByLibrary.simpleMessage("Apri le impostazioni app"),
        "page_not_found": MessageLookupByLibrary.simpleMessage(
            "Twitter dice che la pagina non esiste, ma potrebbe non essere vero"),
        "permission_not_granted": MessageLookupByLibrary.simpleMessage(
            "Permesso non concesso. Si prega di riprovare dopo la concessione!"),
        "pick_a_color":
            MessageLookupByLibrary.simpleMessage("Scegli un colore!"),
        "pick_an_icon":
            MessageLookupByLibrary.simpleMessage("Scegli un\'icona!"),
        "pinned_tweet": MessageLookupByLibrary.simpleMessage("Tweet fissato"),
        "playback_speed":
            MessageLookupByLibrary.simpleMessage("Velocità di riproduzione"),
        "please_check_your_internet_connection_error_message": m10,
        "please_enter_a_name": MessageLookupByLibrary.simpleMessage(
            "Per favore inserisci un nome"),
        "please_make_sure_the_data_you_wish_to_import_is_located_there_then_press_the_import_button_below":
            MessageLookupByLibrary.simpleMessage(
                "Assicurati che i dati che vuoi importare si trovino lì, poi premi il pulsante di importazione qui sotto."),
        "please_note_that_the_method_fritter_uses_to_import_subscriptions_is_heavily_rate_limited_by_twitter_so_this_may_fail_if_you_have_a_lot_of_followed_accounts":
            MessageLookupByLibrary.simpleMessage(
                "Si ricorda che il metodo che Fritter usa per importare iscrizioni è fortemente limitato da Twitter, quindi potrebbe fallire se segui molti account."),
        "possibly_sensitive":
            MessageLookupByLibrary.simpleMessage("Potenzialmente sensibile"),
        "possibly_sensitive_profile": MessageLookupByLibrary.simpleMessage(
            "Questo profilo può includere immagini, linguaggio o altri contenuti potenzialmente sensibili. Desideri comunque vederlo?"),
        "possibly_sensitive_tweet": MessageLookupByLibrary.simpleMessage(
            "Questo tweet contiene contenuti potenzialmente sensibili. Desideri visualizzarlo?"),
        "prefix": MessageLookupByLibrary.simpleMessage("prefisso"),
        "private_profile":
            MessageLookupByLibrary.simpleMessage("Profilo privato"),
        "released_under_the_mit_license": MessageLookupByLibrary.simpleMessage(
            "Rilasciato sotto licenza MIT"),
        "replying_to": MessageLookupByLibrary.simpleMessage("Rispondendo a"),
        "report": MessageLookupByLibrary.simpleMessage("Segnala"),
        "report_a_bug": MessageLookupByLibrary.simpleMessage("Segnala un bug"),
        "reporting_an_error":
            MessageLookupByLibrary.simpleMessage("Segnalazione di un errore"),
        "reset_home_pages": MessageLookupByLibrary.simpleMessage(
            "Reimposta pagine predefinite"),
        "retry": MessageLookupByLibrary.simpleMessage("Riprova"),
        "save": MessageLookupByLibrary.simpleMessage("Salva"),
        "save_bandwidth_using_smaller_images":
            MessageLookupByLibrary.simpleMessage(
                "Risparmia banda usando immagini più piccole"),
        "saved": MessageLookupByLibrary.simpleMessage("Salvati"),
        "say_hello": MessageLookupByLibrary.simpleMessage("Dì ciao"),
        "say_hello_emoji": MessageLookupByLibrary.simpleMessage("Dì ciao 👋"),
        "search": MessageLookupByLibrary.simpleMessage("Ricerca"),
        "search_term": MessageLookupByLibrary.simpleMessage("Ricerca"),
        "select": MessageLookupByLibrary.simpleMessage("Seleziona"),
        "selecting_individual_accounts_to_import_and_assigning_groups_are_both_planned_for_the_future_already":
            MessageLookupByLibrary.simpleMessage(
                "Selezione di account individuali da importare e assegnazione dei gruppi sono entrambi già pianificati per il futuro!"),
        "send": MessageLookupByLibrary.simpleMessage("Invia"),
        "send_a_non_identifying_ping_to_let_me_know_you_are_using_fritter_and_to_help_future_development":
            MessageLookupByLibrary.simpleMessage(
                "Invia un ping non identificativo per farmi sapere che stai usando Fritter e per aiutare lo sviluppo futuro"),
        "send_always": MessageLookupByLibrary.simpleMessage("Invia sempre"),
        "send_once": MessageLookupByLibrary.simpleMessage("Invia una volta"),
        "share_tweet_content": MessageLookupByLibrary.simpleMessage(
            "Condividi il contenuto del tweet"),
        "share_tweet_content_and_link": MessageLookupByLibrary.simpleMessage(
            "Condividi il contenuto del tweet e il collegamento"),
        "share_tweet_link":
            MessageLookupByLibrary.simpleMessage("Condividi link al tweet"),
        "should_check_for_updates_description":
            MessageLookupByLibrary.simpleMessage(
                "Controlla gli aggiornamenti quando inizia Fritter"),
        "should_check_for_updates_label":
            MessageLookupByLibrary.simpleMessage("Controlla gli aggiornamenti"),
        "small": MessageLookupByLibrary.simpleMessage("Piccolo"),
        "something_broke_in_fritter": MessageLookupByLibrary.simpleMessage(
            "Qualcosa si è rotto in Fritter."),
        "something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated":
            MessageLookupByLibrary.simpleMessage(
                "Qualcosa è andato storto in Fritter ed è stato generato un rapporto di errore. Il rapporto può essere inviato agli sviluppatori di Fritter per aiutare a risolvere il problema."),
        "sorry_the_replied_tweet_could_not_be_found":
            MessageLookupByLibrary.simpleMessage(
                "Scusa, il tweet risposto non è stato trovato!"),
        "subscribe": MessageLookupByLibrary.simpleMessage("Iscriviti"),
        "subscriptions": MessageLookupByLibrary.simpleMessage("Iscrizioni"),
        "subtitles": MessageLookupByLibrary.simpleMessage("Sottotitoli"),
        "successfully_saved_the_media":
            MessageLookupByLibrary.simpleMessage("Media salvati!"),
        "system": MessageLookupByLibrary.simpleMessage("Sistema"),
        "tap_to_download_release_version": m11,
        "tap_to_show_getMediaType_item_type": m12,
        "thanks_for_helping_fritter": MessageLookupByLibrary.simpleMessage(
            "Grazie per aver aiutato Fritter! 💖"),
        "thanks_for_reporting_we_will_try_and_fix_it_in_no_time":
            MessageLookupByLibrary.simpleMessage(
                "Grazie per la segnalazione. Proveremo a sistemarlo in pochissimo tempo!"),
        "the_file_does_not_exist_please_ensure_it_is_located_at_file_path": m13,
        "the_github_issue":
            MessageLookupByLibrary.simpleMessage("il problema GitHub (nº 143)"),
        "the_tweet_did_not_contain_any_text_this_is_unexpected":
            MessageLookupByLibrary.simpleMessage(
                "Il tweet non contiene alcun testo. Questo è inaspettato"),
        "theme": MessageLookupByLibrary.simpleMessage("Tema"),
        "theme_mode": MessageLookupByLibrary.simpleMessage("Modalità Tema"),
        "there_were_no_trends_returned_this_is_unexpected_please_report_as_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "Non ci sono state tendenze restituite. Questo è inaspettato! Si prega di segnalare come bug, se possibile."),
        "this_group_contains_no_subscriptions":
            MessageLookupByLibrary.simpleMessage(
                "Questo gruppo non contiene iscrizioni!"),
        "this_took_too_long_to_load_please_check_your_network_connection":
            MessageLookupByLibrary.simpleMessage(
                "Ci ha messo troppo tempo per caricare. Si prega di controllare la connessione di rete!"),
        "this_tweet_is_unavailable": MessageLookupByLibrary.simpleMessage(
            "Questo tweet non è disponibile. Probabilmente è stato cancellato."),
        "this_tweet_user_name_retweeted": m14,
        "this_user_does_not_follow_anyone":
            MessageLookupByLibrary.simpleMessage(
                "Questo utente non segue nessuno!"),
        "this_user_does_not_have_anyone_following_them":
            MessageLookupByLibrary.simpleMessage(
                "Questo utente non ha nessuno a seguirlo!"),
        "thread": MessageLookupByLibrary.simpleMessage("Discussione"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("Miniatura"),
        "timed_out": MessageLookupByLibrary.simpleMessage("Scaduto"),
        "timed_out_trying_to_send_the_ping":
            MessageLookupByLibrary.simpleMessage(
                "Tempo scaduto nel tentativo di inviare il ping 😢"),
        "to_import_subscriptions_from_an_existing_twitter_account_enter_your_username_below":
            MessageLookupByLibrary.simpleMessage(
                "Per importare iscrizioni da un account Twitter esistente, inserisci il tuo nome utente qui sotto."),
        "toggle_all": MessageLookupByLibrary.simpleMessage("Seleziona tutto"),
        "trending": MessageLookupByLibrary.simpleMessage("Tendenze"),
        "trends": MessageLookupByLibrary.simpleMessage("Tendenze"),
        "true_black": MessageLookupByLibrary.simpleMessage("Nero assoluto?"),
        "tweets": MessageLookupByLibrary.simpleMessage("Tweet"),
        "tweets_and_replies":
            MessageLookupByLibrary.simpleMessage("Tweet e risposte"),
        "tweets_number": m15,
        "unable_to_find_the_available_trend_locations":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile trovare le posizioni di tendenza disponibili."),
        "unable_to_find_your_saved_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile trovare i tuoi tweet salvati."),
        "unable_to_import":
            MessageLookupByLibrary.simpleMessage("Impossibile importare"),
        "unable_to_load_home_pages": MessageLookupByLibrary.simpleMessage(
            "Impossibile caricare le tue pagine home"),
        "unable_to_load_subscription_groups":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile caricare i gruppi di iscrizioni"),
        "unable_to_load_the_group": MessageLookupByLibrary.simpleMessage(
            "Impossibile caricare il gruppo"),
        "unable_to_load_the_group_settings":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile caricare le impostazioni del gruppo"),
        "unable_to_load_the_list_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile caricare l\'elenco dei seguiti"),
        "unable_to_load_the_next_page_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile caricare la pagina successiva dei seguiti"),
        "unable_to_load_the_next_page_of_replies":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile caricare la pagina successiva delle risposte"),
        "unable_to_load_the_next_page_of_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile caricare la pagina successiva dei tweet"),
        "unable_to_load_the_profile": MessageLookupByLibrary.simpleMessage(
            "Impossibile caricare il profilo"),
        "unable_to_load_the_search_results":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile caricare i risultati della ricerca."),
        "unable_to_load_the_trends_for_widget_place_name": m16,
        "unable_to_load_the_tweet": MessageLookupByLibrary.simpleMessage(
            "Impossibile caricare il tweet"),
        "unable_to_load_the_tweets": MessageLookupByLibrary.simpleMessage(
            "Impossibile caricare i tweet"),
        "unable_to_load_the_tweets_for_the_feed":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile caricare i tweet per il feed"),
        "unable_to_refresh_the_subscriptions":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile aggiornare le iscrizioni"),
        "unable_to_run_the_database_migrations":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile eseguire le migrazioni del database"),
        "unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode":
            m17,
        "unable_to_send_the_ping_e_to_string": m18,
        "unable_to_send_the_ping_the_status_code_was_response_statusCode": m19,
        "unable_to_stream_the_trend_location_preference":
            MessageLookupByLibrary.simpleMessage(
                "Impossibile trasmettere la preferenza della posizione della tendenza"),
        "unknown": MessageLookupByLibrary.simpleMessage("Sconosciuto"),
        "unsave": MessageLookupByLibrary.simpleMessage("Annulla salvataggio"),
        "unsubscribe": MessageLookupByLibrary.simpleMessage("Disiscriviti"),
        "update_to_release_version_through_your_fdroid_client": m20,
        "updates": MessageLookupByLibrary.simpleMessage("Aggiornamenti"),
        "use_true_black_for_the_dark_mode_theme":
            MessageLookupByLibrary.simpleMessage(
                "Usa un nero vero per il tema scuro"),
        "user_not_found":
            MessageLookupByLibrary.simpleMessage("Utente non trovato"),
        "username": MessageLookupByLibrary.simpleMessage("Nome utente"),
        "version": MessageLookupByLibrary.simpleMessage("Versione"),
        "when_a_new_app_update_is_available":
            MessageLookupByLibrary.simpleMessage(
                "Quando è disponibile un nuovo aggiornamento dell\'app"),
        "whether_errors_should_be_reported_to_sentry":
            MessageLookupByLibrary.simpleMessage(
                "Se gli errori dovrebbero essere segnalati a Sentry"),
        "whether_to_hide_tweets_marked_as_sensitive":
            MessageLookupByLibrary.simpleMessage(
                "Se nascondere i tweet segnalati come sensibili"),
        "which_tab_is_shown_when_the_app_opens":
            MessageLookupByLibrary.simpleMessage(
                "Quale scheda viene visualizzata quando si apre l\'app"),
        "would_you_like_to_enable_automatic_error_reporting":
            MessageLookupByLibrary.simpleMessage(
                "Ti piacerebbe abilitare la segnalazione automatica degli errori?"),
        "yes": MessageLookupByLibrary.simpleMessage("Sì"),
        "yes_please": MessageLookupByLibrary.simpleMessage("Si, grazie"),
        "you_have_not_saved_any_tweets_yet":
            MessageLookupByLibrary.simpleMessage(
                "Non hai ancora salvato un tweet!"),
        "you_must_have_at_least_2_home_screen_pages":
            MessageLookupByLibrary.simpleMessage(
                "Hai bisogno di avere almeno due pagine nella home"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_data_can_only_be_imported_from":
            MessageLookupByLibrary.simpleMessage(
                "Il tuo dispositivo sta usando una versione di Android più vecchia di KitKat (4.4), quindi i dati possono essere importati solo da:"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to":
            MessageLookupByLibrary.simpleMessage(
                "Il tuo dispositivo sta usando una versione di Android più vecchia di KitKat (4.4), quindi l\'esportazione può essere salvata solo su:"),
        "your_profile_must_be_public_otherwise_the_import_will_not_work":
            MessageLookupByLibrary.simpleMessage(
                "Il tuo profilo deve essere pubblico, altrimenti l\'importazione non funzionerà"),
        "your_report_will_be_sent_to_fritter_sentry_project":
            MessageLookupByLibrary.simpleMessage(
                "Il tuo rapporto verrà inviato al progetto Fritter di Sentry, i dettagli sulla privacy possono essere trovati a:")
      };
}
