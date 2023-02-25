// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(name) =>
      "Voulez-vous vraiment supprimer le groupe d\'abonnement ${name} ?";

  static String m1(fileName) => "Données exportées vers ${fileName}";

  static String m2(fullPath) => "Données exportées vers ${fullPath}";

  static String m3(timeagoFormat) => "Terminé ${timeagoFormat}";

  static String m4(timeagoFormat) => "Fin ${timeagoFormat}";

  static String m5(snapshotData) =>
      "Terminé avec les utilisateurs ${snapshotData}";

  static String m6(name) => "Groupe : ${name}";

  static String m7(snapshotData) =>
      "${snapshotData} utilisateurs importés jusqu\'à présent";

  static String m8(date) => "S\'est inscrit·e le ${date}";

  static String m9(num, numFormatted) =>
      "${Intl.plural(num, zero: 'Aucun vote', one: 'Un vote', two: 'Deux votes', few: '${numFormatted} votes', many: '${numFormatted} vote', other: '${numFormatted} votes')}";

  static String m10(errorMessage) =>
      "Veuillez vérifier votre connexion Internet.\n\n${errorMessage}";

  static String m11(releaseVersion) =>
      "Appuyez pour télécharger ${releaseVersion}";

  static String m12(getMediaType) => "Appuyer pour afficher ${getMediaType}";

  static String m13(filePath) =>
      "Le fichier n’existe pas. Veuillez vous assurer qu’il se trouve à ${filePath}";

  static String m14(thisTweetUserName, timeAgo) =>
      "${thisTweetUserName} a retweeté ${timeAgo}";

  static String m15(num, numFormatted) =>
      "${Intl.plural(num, zero: 'no tweets', one: 'un tweet', two: 'deux tweets', few: '${numFormatted} tweets', many: '${numFormatted} tweet', other: '${numFormatted} tweets')}";

  static String m16(widgetPlaceName) =>
      "Impossible de charger les tendances pour ${widgetPlaceName}";

  static String m17(responseStatusCode) =>
      "Impossible d\'enregistrer le média. Twitter a renvoyé un statut de ${responseStatusCode}";

  static String m18(e) => "Impossible d\'envoyer le ping. ${e}";

  static String m19(statusCode) =>
      "Impossible d\'envoyer le ping. Le code d\'erreur était ${statusCode}";

  static String m20(releaseVersion) =>
      "Mise à jour vers ${releaseVersion} via votre client F-Droid";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("À propos"),
        "account_suspended":
            MessageLookupByLibrary.simpleMessage("Compte suspendu"),
        "activate_non_confirmation_bias_mode_description":
            MessageLookupByLibrary.simpleMessage(
                "Masque les auteurs des tweets. Évite les biais de confirmation basés sur des arguments faisant autorité."),
        "activate_non_confirmation_bias_mode_label":
            MessageLookupByLibrary.simpleMessage(
                "Activer le mode biais de non-confirmation"),
        "add_to_group":
            MessageLookupByLibrary.simpleMessage("Ajouter au groupe"),
        "all": MessageLookupByLibrary.simpleMessage("Tout"),
        "all_the_great_software_used_by_fritter":
            MessageLookupByLibrary.simpleMessage(
                "Tous les excellents logiciels utilisés par Fritter"),
        "an_error_was_reported_to_sentry_thank_you":
            MessageLookupByLibrary.simpleMessage(
                "Une erreur a été signalée à Sentry. Merci !"),
        "an_update_for_fritter_is_available":
            MessageLookupByLibrary.simpleMessage(
                "Une mise à jour pour Fritter est disponible ! 🚀"),
        "are_you_sure": MessageLookupByLibrary.simpleMessage("Êtes-vous sûr ?"),
        "are_you_sure_you_want_to_delete_the_subscription_group_name_of_group":
            m0,
        "back": MessageLookupByLibrary.simpleMessage("Retour"),
        "bad_guest_token": MessageLookupByLibrary.simpleMessage(
            "Twitter a invalidé le jeton d\'accès. Essayez de relancer Fritter !"),
        "blue_theme_based_on_the_twitter_color_scheme":
            MessageLookupByLibrary.simpleMessage(
                "Thème bleu basé sur la palette de couleurs de Twitter"),
        "cancel": MessageLookupByLibrary.simpleMessage("Annuler"),
        "catastrophic_failure":
            MessageLookupByLibrary.simpleMessage("Défaillance catastrophique"),
        "choose": MessageLookupByLibrary.simpleMessage("Choisissez"),
        "choose_pages":
            MessageLookupByLibrary.simpleMessage("Choisir les pages"),
        "close": MessageLookupByLibrary.simpleMessage("Fermer"),
        "confirm_close_fritter": MessageLookupByLibrary.simpleMessage(
            "Êtes-vous sûr de vouloir fermer Fritter ?"),
        "contribute": MessageLookupByLibrary.simpleMessage("Contribuer"),
        "copied_address_to_clipboard": MessageLookupByLibrary.simpleMessage(
            "Copie de l\'adresse dans le presse-papiers"),
        "copied_version_to_clipboard": MessageLookupByLibrary.simpleMessage(
            "Copie de la version dans le presse-papiers"),
        "could_not_contact_twitter": MessageLookupByLibrary.simpleMessage(
            "Impossible de contacter Twitter"),
        "could_not_find_any_tweets_by_this_user":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de trouver des tweets de cet utilisateur !"),
        "could_not_find_any_tweets_from_the_last_7_days":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de trouver des tweets des 7 derniers jours !"),
        "country": MessageLookupByLibrary.simpleMessage("Pays"),
        "dark": MessageLookupByLibrary.simpleMessage("Sombre"),
        "data": MessageLookupByLibrary.simpleMessage("Données"),
        "data_exported_to_fileName": m1,
        "data_exported_to_fullPath": m2,
        "data_imported_successfully": MessageLookupByLibrary.simpleMessage(
            "Données importées avec succès"),
        "date_created":
            MessageLookupByLibrary.simpleMessage("Date de création"),
        "date_subscribed":
            MessageLookupByLibrary.simpleMessage("Date d\'inscription"),
        "default_tab":
            MessageLookupByLibrary.simpleMessage("Onglet par défaut"),
        "delete": MessageLookupByLibrary.simpleMessage("Supprimer"),
        "disable_screenshots": MessageLookupByLibrary.simpleMessage(
            "Désactiver les captures d\'écran"),
        "disable_screenshots_hint": MessageLookupByLibrary.simpleMessage(
            "Empêche la prise de captures d\'écran. Cela peut ne pas fonctionner sur tous les appareils."),
        "disabled": MessageLookupByLibrary.simpleMessage("Désactivé"),
        "don_not_send": MessageLookupByLibrary.simpleMessage("Ne pas envoyer"),
        "donate": MessageLookupByLibrary.simpleMessage("Faire un don"),
        "download": MessageLookupByLibrary.simpleMessage("Télécharger"),
        "download_handling": MessageLookupByLibrary.simpleMessage(
            "Traitement des téléchargements"),
        "download_handling_description": MessageLookupByLibrary.simpleMessage(
            "Comment le téléchargement devrait fonctionner"),
        "download_handling_type_ask":
            MessageLookupByLibrary.simpleMessage("Toujours demander"),
        "download_handling_type_directory":
            MessageLookupByLibrary.simpleMessage(
                "Enregistrer dans le répertoire"),
        "download_media_no_url": MessageLookupByLibrary.simpleMessage(
            "Téléchargement impossible. Ce média pourrais être seulement disponible sous forme de flux, ce que Fritter ne sais pas encore télécharger."),
        "download_path":
            MessageLookupByLibrary.simpleMessage("Chemin de téléchargement"),
        "downloading_media":
            MessageLookupByLibrary.simpleMessage("Téléchargement des médias…"),
        "enable_sentry":
            MessageLookupByLibrary.simpleMessage("Activer Sentry ?"),
        "ended_timeago_format_endsAt_allowFromNow_true": m3,
        "ends_timeago_format_endsAt_allowFromNow_true": m4,
        "enter_your_twitter_username": MessageLookupByLibrary.simpleMessage(
            "Entrer votre nom d\'utilisateur Twitter"),
        "export": MessageLookupByLibrary.simpleMessage("Exporter"),
        "export_settings":
            MessageLookupByLibrary.simpleMessage("Exporter les paramètres ?"),
        "export_subscription_group_members":
            MessageLookupByLibrary.simpleMessage(
                "Exporter les membres du groupe d\'abonnement ?"),
        "export_subscription_groups": MessageLookupByLibrary.simpleMessage(
            "Exporter les groupes d\'abonnement ?"),
        "export_subscriptions":
            MessageLookupByLibrary.simpleMessage("Exporter les abonnements ?"),
        "export_tweets":
            MessageLookupByLibrary.simpleMessage("Exporter les tweets ?"),
        "export_your_data":
            MessageLookupByLibrary.simpleMessage("Exporter vos données"),
        "feed": MessageLookupByLibrary.simpleMessage("Flux"),
        "filters": MessageLookupByLibrary.simpleMessage("Filtres"),
        "finished_with_snapshotData_users": m5,
        "followers": MessageLookupByLibrary.simpleMessage("Abonnés"),
        "following": MessageLookupByLibrary.simpleMessage("Abonnements"),
        "forbidden": MessageLookupByLibrary.simpleMessage(
            "Twitter informe que l\'accès est interdit"),
        "fritter": MessageLookupByLibrary.simpleMessage("Fritter"),
        "fritter_blue": MessageLookupByLibrary.simpleMessage("Fritter bleu"),
        "general": MessageLookupByLibrary.simpleMessage("Général"),
        "group_name": m6,
        "groups": MessageLookupByLibrary.simpleMessage("Groupes"),
        "help_make_fritter_even_better": MessageLookupByLibrary.simpleMessage(
            "Contribuer à l\'amélioration de Fritter"),
        "help_support_fritters_future": MessageLookupByLibrary.simpleMessage(
            "Soutenir le développement de Fritter"),
        "here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future":
            MessageLookupByLibrary.simpleMessage(
                "Voici les données qui seront envoyées. Elles ne seront utilisées que pour déterminer les appareils et les langues à prendre en charge dans Fritter à l\'avenir."),
        "hide_sensitive_tweets": MessageLookupByLibrary.simpleMessage(
            "Masquer les tweets sensibles"),
        "home": MessageLookupByLibrary.simpleMessage("Accueil"),
        "if_you_have_any_feedback_on_this_feature_please_leave_it_on":
            MessageLookupByLibrary.simpleMessage(
                "Si vous avez des commentaires sur cette fonctionnalité, veuillez m\'en faire part"),
        "import": MessageLookupByLibrary.simpleMessage("Importer"),
        "import_data_from_another_device": MessageLookupByLibrary.simpleMessage(
            "Importer des données depuis un autre appareil"),
        "import_from_twitter":
            MessageLookupByLibrary.simpleMessage("Importer depuis Twitter"),
        "import_subscriptions":
            MessageLookupByLibrary.simpleMessage("Importer des abonnements"),
        "imported_snapshot_data_users_so_far": m7,
        "include_replies":
            MessageLookupByLibrary.simpleMessage("Inclure les réponses"),
        "include_retweets":
            MessageLookupByLibrary.simpleMessage("Inclure les retweets"),
        "it_looks_like_you_have_already_said_hello_from_this_version_of_fritter":
            MessageLookupByLibrary.simpleMessage(
                "Il semble que vous ayez déjà salué cette version de Fritter !"),
        "it_looks_like_you_have_already_sent_a_ping_recently":
            MessageLookupByLibrary.simpleMessage(
                "On dirait que vous avez déjà envoyé un ping récemment 🤔"),
        "joined": m8,
        "language": MessageLookupByLibrary.simpleMessage("Langue"),
        "language_subtitle":
            MessageLookupByLibrary.simpleMessage("Nécessite un redémarrage"),
        "large": MessageLookupByLibrary.simpleMessage("Grand"),
        "legacy_android_import": MessageLookupByLibrary.simpleMessage(
            "Importation depuis un appareil Android ancien"),
        "let_the_developers_know_if_something_is_broken":
            MessageLookupByLibrary.simpleMessage(
                "Faites savoir aux développeurs si quelque chose est défectueux"),
        "licenses": MessageLookupByLibrary.simpleMessage("Licences"),
        "light": MessageLookupByLibrary.simpleMessage("Lumineux"),
        "live": MessageLookupByLibrary.simpleMessage("DIRECT"),
        "logging": MessageLookupByLibrary.simpleMessage("Enregistrement"),
        "media": MessageLookupByLibrary.simpleMessage("Médias"),
        "media_size": MessageLookupByLibrary.simpleMessage("Taille du média"),
        "medium": MessageLookupByLibrary.simpleMessage("Moyen"),
        "missing_page": MessageLookupByLibrary.simpleMessage("Page manquante"),
        "name": MessageLookupByLibrary.simpleMessage("Nom"),
        "never_send": MessageLookupByLibrary.simpleMessage("Ne jamais envoyer"),
        "newTrans": MessageLookupByLibrary.simpleMessage("Nouveau"),
        "no": MessageLookupByLibrary.simpleMessage("Non"),
        "no_data_was_returned_which_should_never_happen_please_report_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "Aucune donnée n\'a été renvoyée, ce qui ne devrait jamais arriver. Veuillez signaler une erreur, si possible !"),
        "no_results": MessageLookupByLibrary.simpleMessage("Aucun résultat"),
        "no_results_for":
            MessageLookupByLibrary.simpleMessage("Aucun résultat pour :"),
        "no_subscriptions_try_searching_or_importing_some":
            MessageLookupByLibrary.simpleMessage(
                "Aucun abonnement. Essayez d’en rechercher ou d’en importer !"),
        "not_set": MessageLookupByLibrary.simpleMessage("Non défini"),
        "note_due_to_a_twitter_limitation_not_all_tweets_may_be_included":
            MessageLookupByLibrary.simpleMessage(
                "Note : En raison d\'une limitation de Twitter, tous les tweets peuvent ne pas être inclus"),
        "numberFormat_format_total_votes": m9,
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "only_public_subscriptions_can_be_imported":
            MessageLookupByLibrary.simpleMessage(
                "Les abonnements peuvent être importés seulement de profils publics"),
        "oops_something_went_wrong": MessageLookupByLibrary.simpleMessage(
            "Oups ! Quelque chose a mal tourné 🥲"),
        "open_app_settings": MessageLookupByLibrary.simpleMessage(
            "Ouvrir les paramètres de l\'appli"),
        "page_not_found": MessageLookupByLibrary.simpleMessage(
            "Twitter informe que la page n\'existe pas, ce qui ne peux ne pas être vrai"),
        "permission_not_granted": MessageLookupByLibrary.simpleMessage(
            "Autorisation non accordée. Veuillez réessayer après avoir accordé l\'autorisation !"),
        "pick_a_color":
            MessageLookupByLibrary.simpleMessage("Choisissez une couleur !"),
        "pick_an_icon":
            MessageLookupByLibrary.simpleMessage("Choisissez une icône !"),
        "pinned_tweet": MessageLookupByLibrary.simpleMessage("Tweet épinglé"),
        "playback_speed":
            MessageLookupByLibrary.simpleMessage("Vitesse de lecture"),
        "please_check_your_internet_connection_error_message": m10,
        "please_enter_a_name":
            MessageLookupByLibrary.simpleMessage("Veuillez entrer un nom"),
        "please_make_sure_the_data_you_wish_to_import_is_located_there_then_press_the_import_button_below":
            MessageLookupByLibrary.simpleMessage(
                "Assurez-vous que les données que vous souhaitez importer s\'y trouvent, puis appuyez sur le bouton d\'importation ci-dessous."),
        "please_note_that_the_method_fritter_uses_to_import_subscriptions_is_heavily_rate_limited_by_twitter_so_this_may_fail_if_you_have_a_lot_of_followed_accounts":
            MessageLookupByLibrary.simpleMessage(
                "Veuillez noter que la méthode utilisée par Fritter pour importer les abonnements est fortement limitée par Twitter, cela peut donc échouer si vous avez beaucoup de comptes suivis."),
        "possibly_sensitive":
            MessageLookupByLibrary.simpleMessage("Potentiellement sensible"),
        "possibly_sensitive_profile": MessageLookupByLibrary.simpleMessage(
            "Ce profil peut contenir des images, un langage ou d\'autres contenus potentiellement sensibles. Voulez-vous toujours le consulter ?"),
        "possibly_sensitive_tweet": MessageLookupByLibrary.simpleMessage(
            "Ce tweet contient un contenu potentiellement sensible. Voulez-vous le voir ?"),
        "prefix": MessageLookupByLibrary.simpleMessage("préfixe"),
        "private_profile": MessageLookupByLibrary.simpleMessage("Profil privé"),
        "released_under_the_mit_license":
            MessageLookupByLibrary.simpleMessage("Publié sous la licence MIT"),
        "replying_to": MessageLookupByLibrary.simpleMessage("Réponse à"),
        "report": MessageLookupByLibrary.simpleMessage("Signaler"),
        "report_a_bug": MessageLookupByLibrary.simpleMessage("Signaler un bug"),
        "reporting_an_error":
            MessageLookupByLibrary.simpleMessage("Signaler une erreur"),
        "reset_home_pages": MessageLookupByLibrary.simpleMessage(
            "Réinitialiser les pages par défaut"),
        "retry": MessageLookupByLibrary.simpleMessage("Répondre"),
        "save": MessageLookupByLibrary.simpleMessage("Enregistrer"),
        "save_bandwidth_using_smaller_images": MessageLookupByLibrary.simpleMessage(
            "Économiser de la bande passante en chargeant des images plus petites"),
        "saved": MessageLookupByLibrary.simpleMessage("Enregistré"),
        "saved_tweet_too_large": MessageLookupByLibrary.simpleMessage(
            "Ce tweet enregistré n\'a pas pu être affiché, car il est trop lourd à charger. Veuillez le signaler aux développeurs."),
        "say_hello": MessageLookupByLibrary.simpleMessage("Saluer"),
        "say_hello_emoji":
            MessageLookupByLibrary.simpleMessage("Dites bonjour 👋"),
        "search": MessageLookupByLibrary.simpleMessage("Recherche"),
        "search_term":
            MessageLookupByLibrary.simpleMessage("Terme de recherche"),
        "select": MessageLookupByLibrary.simpleMessage("Sélectionner"),
        "selecting_individual_accounts_to_import_and_assigning_groups_are_both_planned_for_the_future_already":
            MessageLookupByLibrary.simpleMessage(
                "La sélection de comptes individuels à importer et l’affectation de groupes sont déjà en cours de développement !"),
        "send": MessageLookupByLibrary.simpleMessage("Envoyer"),
        "send_a_non_identifying_ping_to_let_me_know_you_are_using_fritter_and_to_help_future_development":
            MessageLookupByLibrary.simpleMessage(
                "Envoyer un ping non identifiant pour me faire savoir que vous utilisez Fritter, et pour aider au développement futur"),
        "send_always": MessageLookupByLibrary.simpleMessage("Toujours envoyer"),
        "send_once": MessageLookupByLibrary.simpleMessage("Envoyer une fois"),
        "share_tweet_content": MessageLookupByLibrary.simpleMessage(
            "Partager le contenu du tweet"),
        "share_tweet_content_and_link": MessageLookupByLibrary.simpleMessage(
            "Partager le contenu du tweet et le lien"),
        "share_tweet_link": MessageLookupByLibrary.simpleMessage(
            "Partager le lien vers le tweet"),
        "should_check_for_updates_description":
            MessageLookupByLibrary.simpleMessage(
                "Vérifier les mises à jour quand Fritter démarre"),
        "should_check_for_updates_label":
            MessageLookupByLibrary.simpleMessage("Vérifier les mises à jour"),
        "small": MessageLookupByLibrary.simpleMessage("Petit"),
        "something_broke_in_fritter": MessageLookupByLibrary.simpleMessage(
            "Quelque chose s\'est cassé dans Fritter."),
        "something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated":
            MessageLookupByLibrary.simpleMessage(
                "Un problème vient de se produire dans Fritter, et un rapport d\'erreur a été généré. Ce rapport peut être envoyé aux développeurs de Fritter pour les aider à résoudre le problème."),
        "sorry_the_replied_tweet_could_not_be_found":
            MessageLookupByLibrary.simpleMessage(
                "Désolé, impossible de trouver le tweet auquel on a répondu !"),
        "subscribe": MessageLookupByLibrary.simpleMessage("S\'abonner"),
        "subscriptions": MessageLookupByLibrary.simpleMessage("Abonnements"),
        "subtitles": MessageLookupByLibrary.simpleMessage("Sous-titres"),
        "successfully_saved_the_media":
            MessageLookupByLibrary.simpleMessage("Le média est sauvegardé !"),
        "system": MessageLookupByLibrary.simpleMessage("Système"),
        "tap_to_download_release_version": m11,
        "tap_to_show_getMediaType_item_type": m12,
        "thanks_for_helping_fritter": MessageLookupByLibrary.simpleMessage(
            "Merci d\'avoir aidé Fritter ! 💖"),
        "thanks_for_reporting_we_will_try_and_fix_it_in_no_time":
            MessageLookupByLibrary.simpleMessage(
                "Merci de le signaler. Nous allons essayer de le corriger en un rien de temps !"),
        "the_file_does_not_exist_please_ensure_it_is_located_at_file_path": m13,
        "the_github_issue":
            MessageLookupByLibrary.simpleMessage("le problème GitHub (nº 143)"),
        "the_tweet_did_not_contain_any_text_this_is_unexpected":
            MessageLookupByLibrary.simpleMessage(
                "Le tweet ne contenait aucun texte. C’est inattendu"),
        "theme": MessageLookupByLibrary.simpleMessage("Thème"),
        "theme_mode": MessageLookupByLibrary.simpleMessage("Mode du thème"),
        "there_were_no_trends_returned_this_is_unexpected_please_report_as_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "Aucune tendance n\'a été retournée. C\'est inattendu ! Veuillez le signaler comme un bug, si possible."),
        "this_group_contains_no_subscriptions":
            MessageLookupByLibrary.simpleMessage(
                "Ce groupe ne contient pas d\'abonnements !"),
        "this_took_too_long_to_load_please_check_your_network_connection":
            MessageLookupByLibrary.simpleMessage(
                "Le chargement est trop long. Veuillez vérifier votre connexion réseau !"),
        "this_tweet_is_unavailable": MessageLookupByLibrary.simpleMessage(
            "Ce tweet n’est pas disponible Il a probablement été supprimé."),
        "this_tweet_user_name_retweeted": m14,
        "this_user_does_not_follow_anyone":
            MessageLookupByLibrary.simpleMessage(
                "Cet utilisateur ne suit personne !"),
        "this_user_does_not_have_anyone_following_them":
            MessageLookupByLibrary.simpleMessage(
                "Cet utilisateur n\'a personne qui le suit !"),
        "thread": MessageLookupByLibrary.simpleMessage("Fil de discussion"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("Miniature"),
        "timed_out": MessageLookupByLibrary.simpleMessage("Délai expiré"),
        "timed_out_trying_to_send_the_ping":
            MessageLookupByLibrary.simpleMessage(
                "Expiration du délai d\'attente pour envoyer le ping 😢"),
        "to_import_subscriptions_from_an_existing_twitter_account_enter_your_username_below":
            MessageLookupByLibrary.simpleMessage(
                "Pour importer des abonnements depuis un compte Twitter existant, saisissez votre nom d\'utilisateur ci-dessous."),
        "toggle_all": MessageLookupByLibrary.simpleMessage("Tout basculer"),
        "trending": MessageLookupByLibrary.simpleMessage("Tendances"),
        "trends": MessageLookupByLibrary.simpleMessage("Tendances"),
        "true_black": MessageLookupByLibrary.simpleMessage("Vrai noir ?"),
        "tweets": MessageLookupByLibrary.simpleMessage("Tweets"),
        "tweets_and_replies":
            MessageLookupByLibrary.simpleMessage("Tweets & Réponses"),
        "tweets_number": m15,
        "two_home_pages_required": MessageLookupByLibrary.simpleMessage(
            "Vous devez disposer d\'au moins deux pages d\'écran d\'accueil."),
        "unable_to_find_the_available_trend_locations":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de trouver les emplacements de tendance disponibles."),
        "unable_to_find_your_saved_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de trouver vos tweets enregistrés."),
        "unable_to_import":
            MessageLookupByLibrary.simpleMessage("Importation impossible"),
        "unable_to_load_home_pages": MessageLookupByLibrary.simpleMessage(
            "Impossible de charger vos pages d\'accueil"),
        "unable_to_load_subscription_groups":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de charger les groupes d\'abonnement"),
        "unable_to_load_the_group": MessageLookupByLibrary.simpleMessage(
            "Impossible de charger le groupe"),
        "unable_to_load_the_group_settings":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de charger les paramètres du groupe"),
        "unable_to_load_the_list_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de charger la liste des abonnés"),
        "unable_to_load_the_next_page_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de charger la page suivante"),
        "unable_to_load_the_next_page_of_replies":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de charger la page suivante de réponses"),
        "unable_to_load_the_next_page_of_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de charger la page suivante de tweets"),
        "unable_to_load_the_profile": MessageLookupByLibrary.simpleMessage(
            "Impossible de charger le profil"),
        "unable_to_load_the_search_results":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de charger les résultats de la recherche."),
        "unable_to_load_the_trends_for_widget_place_name": m16,
        "unable_to_load_the_tweet": MessageLookupByLibrary.simpleMessage(
            "Impossible de charger le tweet"),
        "unable_to_load_the_tweets": MessageLookupByLibrary.simpleMessage(
            "Impossible de charger les tweets"),
        "unable_to_load_the_tweets_for_the_feed":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de charger les tweets pour le fil d\'actualité"),
        "unable_to_refresh_the_subscriptions":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de rafraîchir la liste des abonnements"),
        "unable_to_run_the_database_migrations":
            MessageLookupByLibrary.simpleMessage(
                "Impossible d\'exécuter les migrations de la base de données"),
        "unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode":
            m17,
        "unable_to_send_the_ping_e_to_string": m18,
        "unable_to_send_the_ping_the_status_code_was_response_statusCode": m19,
        "unable_to_stream_the_trend_location_preference":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de diffuser la préférence de localisation de la tendance"),
        "unknown": MessageLookupByLibrary.simpleMessage("Inconnu"),
        "unsave": MessageLookupByLibrary.simpleMessage("Désenregistrer"),
        "unsubscribe": MessageLookupByLibrary.simpleMessage("Se désabonner"),
        "unsupported_url":
            MessageLookupByLibrary.simpleMessage("URL non pris en charge"),
        "update_to_release_version_through_your_fdroid_client": m20,
        "updates": MessageLookupByLibrary.simpleMessage("Mises à jour"),
        "use_true_black_for_the_dark_mode_theme":
            MessageLookupByLibrary.simpleMessage(
                "Utilisez le noir profond pour le thème du mode sombre"),
        "user_not_found":
            MessageLookupByLibrary.simpleMessage("Utilisateur non trouvé"),
        "username": MessageLookupByLibrary.simpleMessage("Nom d’utilisateur"),
        "version": MessageLookupByLibrary.simpleMessage("Version"),
        "when_a_new_app_update_is_available": MessageLookupByLibrary.simpleMessage(
            "Lorsqu\'une nouvelle mise à jour de l\'application est disponible"),
        "whether_errors_should_be_reported_to_sentry":
            MessageLookupByLibrary.simpleMessage(
                "Si les erreurs doivent être signalées à Sentry"),
        "whether_to_hide_tweets_marked_as_sensitive":
            MessageLookupByLibrary.simpleMessage(
                "La possibilité de masquer les tweets marqués comme sensibles"),
        "which_tab_is_shown_when_the_app_opens":
            MessageLookupByLibrary.simpleMessage(
                "Quel onglet s’affiche à l’ouverture de l’application"),
        "would_you_like_to_enable_automatic_error_reporting":
            MessageLookupByLibrary.simpleMessage(
                "Voulez-vous activer le rapport d\'erreur automatique ?"),
        "yes": MessageLookupByLibrary.simpleMessage("Oui"),
        "yes_please":
            MessageLookupByLibrary.simpleMessage("Oui, s\'il vous plaît"),
        "you_have_not_saved_any_tweets_yet":
            MessageLookupByLibrary.simpleMessage(
                "Vous n\'avez pas encore enregistré de tweets !"),
        "you_must_have_at_least_2_home_screen_pages":
            MessageLookupByLibrary.simpleMessage(
                "Vous devez avoir au moins 2 pages d\'écran d\'accueil"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_data_can_only_be_imported_from":
            MessageLookupByLibrary.simpleMessage(
                "Votre appareil fonctionne sous une version d\'Android antérieure à KitKat (4.4). Les données ne peuvent donc être importées qu\'à partir de cet appareil :"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to":
            MessageLookupByLibrary.simpleMessage(
                "Votre appareil fonctionne avec une version d\'Android antérieure à KitKat (4.4), l\'exportation ne peut donc être sauvegardée que sur :"),
        "your_profile_must_be_public_otherwise_the_import_will_not_work":
            MessageLookupByLibrary.simpleMessage(
                "Votre profil doit être public, sinon l’importation ne fonctionnera pas"),
        "your_report_will_be_sent_to_fritter_sentry_project":
            MessageLookupByLibrary.simpleMessage(
                "Votre rapport sera envoyé au projet Sentry de Fritter, et les détails de la confidentialité peuvent être trouvés à l\'adresse suivante :")
      };
}
