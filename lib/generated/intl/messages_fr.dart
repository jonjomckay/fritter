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

  static String m7(date) => "S\'est inscrit·e le ${date}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_to_group":
            MessageLookupByLibrary.simpleMessage("Ajouter au groupe"),
        "an_error_was_reported_to_sentry_thank_you":
            MessageLookupByLibrary.simpleMessage(
                "Une erreur a été signalée à Sentry. Merci !"),
        "could_not_find_any_tweets_by_this_user":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de trouver des tweets de cet utilisateur !"),
        "could_not_find_any_tweets_from_the_last_7_days":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de trouver des tweets des 7 derniers jours !"),
        "don_not_send": MessageLookupByLibrary.simpleMessage("Ne pas envoyer"),
        "export": MessageLookupByLibrary.simpleMessage("Exporter"),
        "feed": MessageLookupByLibrary.simpleMessage("Flux"),
        "joined": m7,
        "never_send": MessageLookupByLibrary.simpleMessage("Ne jamais envoyer"),
        "no_results": MessageLookupByLibrary.simpleMessage("Aucun résultat"),
        "reporting_an_error":
            MessageLookupByLibrary.simpleMessage("Signaler une erreur"),
        "saved": MessageLookupByLibrary.simpleMessage("Enregistré"),
        "send_always": MessageLookupByLibrary.simpleMessage("Toujours envoyer"),
        "send_once": MessageLookupByLibrary.simpleMessage("Envoyer une fois"),
        "something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated":
            MessageLookupByLibrary.simpleMessage(
                "Un problème vient de se produire dans Fritter, et un rapport d\'erreur a été généré. Ce rapport peut être envoyé aux développeurs de Fritter pour les aider à résoudre le problème."),
        "subscribe": MessageLookupByLibrary.simpleMessage("S\'abonner"),
        "subscriptions": MessageLookupByLibrary.simpleMessage("Abonnements"),
        "thanks_for_reporting_we_will_try_and_fix_it_in_no_time":
            MessageLookupByLibrary.simpleMessage(
                "Merci de le signaler. Nous allons essayer de le corriger en un rien de temps !"),
        "this_group_contains_no_subscriptions":
            MessageLookupByLibrary.simpleMessage(
                "Ce groupe ne contient pas d\'abonnements !"),
        "trending": MessageLookupByLibrary.simpleMessage("Tendances"),
        "unable_to_load_subscription_groups":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de charger les groupes d\'abonnement"),
        "unable_to_load_the_group": MessageLookupByLibrary.simpleMessage(
            "Impossible de charger le groupe"),
        "unable_to_load_the_list_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de charger la liste des abonnés"),
        "unable_to_load_the_next_page_of_replies":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de charger la page suivante de réponses"),
        "unable_to_load_the_next_page_of_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de charger la page suivante de tweets"),
        "unable_to_load_the_tweet": MessageLookupByLibrary.simpleMessage(
            "Impossible de charger le tweet"),
        "unable_to_load_the_tweets_for_the_feed":
            MessageLookupByLibrary.simpleMessage(
                "Impossible de charger les tweets pour le fil d\'actualité"),
        "unsubscribe": MessageLookupByLibrary.simpleMessage("Se désabonner"),
        "would_you_like_to_enable_automatic_error_reporting":
            MessageLookupByLibrary.simpleMessage(
                "Voulez-vous activer le rapport d\'erreur automatique ?"),
        "your_report_will_be_sent_to_fritter_sentry_project":
            MessageLookupByLibrary.simpleMessage(
                "Votre rapport sera envoyé au projet Sentry de Fritter, et les détails de la confidentialité peuvent être trouvés à l\'adresse suivante :")
      };
}
