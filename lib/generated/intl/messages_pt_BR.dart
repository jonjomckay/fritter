// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt_BR locale. All the
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

final messages = MessageLookup();

typedef MessageIfAbsent = String Function(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pt_BR';

  static String m1(fileName) => "Dados exportados para ${fileName}";

  static String m2(fullPath) => "Dados exportados para ${fullPath}";

  static String m7(date) => "Ingressou em ${date}";

  static String m13(filePath) => "O arquivo não existe. Certifique-se de que está localizado em ${filePath}";

  static String m19(e) => "Não foi possível enviar o ping. ${e}";

  static String m20(statusCode) => "Não foi possível enviar o ping. O código de estado era ${statusCode}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Sobre"),
        "add_to_group": MessageLookupByLibrary.simpleMessage("Adicionar ao grupo"),
        "all_the_great_software_used_by_fritter":
            MessageLookupByLibrary.simpleMessage("Todo o ótimo software usado por Fritter"),
        "an_error_was_reported_to_sentry_thank_you":
            MessageLookupByLibrary.simpleMessage("Um erro foi relatado ao Sentry. Obrigada!"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "contribute": MessageLookupByLibrary.simpleMessage("Contribuir"),
        "copied_address_to_clipboard":
            MessageLookupByLibrary.simpleMessage("Endereço copiado para a área de transferência"),
        "copied_version_to_clipboard":
            MessageLookupByLibrary.simpleMessage("Versão copiada para a área de transferência"),
        "could_not_find_any_tweets_by_this_user":
            MessageLookupByLibrary.simpleMessage("Não foi possível encontrar nenhum tweet deste usuário!"),
        "could_not_find_any_tweets_from_the_last_7_days":
            MessageLookupByLibrary.simpleMessage("Não foi possível encontrar nenhum tweet dos últimos 7 dias!"),
        "dark": MessageLookupByLibrary.simpleMessage("Escuro"),
        "data": MessageLookupByLibrary.simpleMessage("Dados"),
        "data_exported_to_fileName": m1,
        "data_exported_to_fullPath": m2,
        "data_imported_successfully": MessageLookupByLibrary.simpleMessage("Dados importados com sucesso"),
        "default_tab": MessageLookupByLibrary.simpleMessage("Aba padrão"),
        "disabled": MessageLookupByLibrary.simpleMessage("Desativado"),
        "don_not_send": MessageLookupByLibrary.simpleMessage("Não enviar"),
        "donate": MessageLookupByLibrary.simpleMessage("Doar"),
        "enable_sentry": MessageLookupByLibrary.simpleMessage("Ativar Sentry?"),
        "export": MessageLookupByLibrary.simpleMessage("Exportar"),
        "export_settings": MessageLookupByLibrary.simpleMessage("Exportar configurações?"),
        "export_subscription_group_members":
            MessageLookupByLibrary.simpleMessage("Exportar membros do grupo de inscrições?"),
        "export_subscription_groups": MessageLookupByLibrary.simpleMessage("Exportar grupos de inscrições?"),
        "export_subscriptions": MessageLookupByLibrary.simpleMessage("Exportar inscrições?"),
        "export_tweets": MessageLookupByLibrary.simpleMessage("Exportar tweets?"),
        "export_your_data": MessageLookupByLibrary.simpleMessage("Exportar seus dados"),
        "feed": MessageLookupByLibrary.simpleMessage("Feed"),
        "filters": MessageLookupByLibrary.simpleMessage("Filtros"),
        "followers": MessageLookupByLibrary.simpleMessage("Seguidores"),
        "following": MessageLookupByLibrary.simpleMessage("Seguindo"),
        "fritter": MessageLookupByLibrary.simpleMessage("Fritter"),
        "general": MessageLookupByLibrary.simpleMessage("Geral"),
        "help_make_fritter_even_better": MessageLookupByLibrary.simpleMessage("Ajude a deixar o Fritter ainda melhor"),
        "help_support_fritters_future": MessageLookupByLibrary.simpleMessage("Ajude a apoiar o futuro do Fritter"),
        "here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future":
            MessageLookupByLibrary.simpleMessage(
                "Aqui estão os dados que serão enviados. Ele será usado apenas para determinar quais dispositivos e idiomas serão suportados no Fritter no futuro."),
        "import": MessageLookupByLibrary.simpleMessage("Importar"),
        "import_data_from_another_device": MessageLookupByLibrary.simpleMessage("Importar dados de outro dispositivo"),
        "include_replies": MessageLookupByLibrary.simpleMessage("Incluir respostas"),
        "include_retweets": MessageLookupByLibrary.simpleMessage("Incluir retweets"),
        "it_looks_like_you_have_already_said_hello_from_this_version_of_fritter":
            MessageLookupByLibrary.simpleMessage("Parece que você já disse olá desta versão do Fritter!"),
        "it_looks_like_you_have_already_sent_a_ping_recently":
            MessageLookupByLibrary.simpleMessage("Parece que você já enviou um ping recentemente 🤔"),
        "joined": m7,
        "large": MessageLookupByLibrary.simpleMessage("Grande"),
        "legacy_android_import": MessageLookupByLibrary.simpleMessage("Importação do Android antigo"),
        "let_the_developers_know_if_something_is_broken":
            MessageLookupByLibrary.simpleMessage("Deixe os desenvolvedores saberem se algo está quebrado"),
        "licenses": MessageLookupByLibrary.simpleMessage("Licenças"),
        "light": MessageLookupByLibrary.simpleMessage("Claro"),
        "logging": MessageLookupByLibrary.simpleMessage("Criando Log"),
        "media": MessageLookupByLibrary.simpleMessage("Mídia"),
        "media_size": MessageLookupByLibrary.simpleMessage("Tamanho da mídia"),
        "medium": MessageLookupByLibrary.simpleMessage("Média"),
        "never_send": MessageLookupByLibrary.simpleMessage("Nunca enviar"),
        "no_results": MessageLookupByLibrary.simpleMessage("Nenhum resultado"),
        "note_due_to_a_twitter_limitation_not_all_tweets_may_be_included": MessageLookupByLibrary.simpleMessage(
            "Observação: devido a uma limitação do Twitter, nem todos os tweets podem ser incluídos"),
        "please_make_sure_the_data_you_wish_to_import_is_located_there_then_press_the_import_button_below":
            MessageLookupByLibrary.simpleMessage(
                "Verifique se os dados que você deseja importar estão localizados lá e pressione o botão de importação abaixo."),
        "prefix": MessageLookupByLibrary.simpleMessage("prefixo"),
        "report_a_bug": MessageLookupByLibrary.simpleMessage("Reportar um erro"),
        "reporting_an_error": MessageLookupByLibrary.simpleMessage("Relatar um erro"),
        "save_bandwidth_using_smaller_images":
            MessageLookupByLibrary.simpleMessage("Economize largura de banda usando imagens menores"),
        "saved": MessageLookupByLibrary.simpleMessage("Salvo"),
        "say_hello": MessageLookupByLibrary.simpleMessage("Diga Olá"),
        "say_hello_emoji": MessageLookupByLibrary.simpleMessage("Diga Olá 👋"),
        "send": MessageLookupByLibrary.simpleMessage("Enviar"),
        "send_a_non_identifying_ping_to_let_me_know_you_are_using_fritter_and_to_help_future_development":
            MessageLookupByLibrary.simpleMessage(
                "Envie um ping não identificável para me informar que você está usando o Fritter e para ajudar no desenvolvimento futuro"),
        "send_always": MessageLookupByLibrary.simpleMessage("Enviar sempre"),
        "send_once": MessageLookupByLibrary.simpleMessage("Enviar uma vez"),
        "small": MessageLookupByLibrary.simpleMessage("Pequena"),
        "something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated": MessageLookupByLibrary.simpleMessage(
            "Algo deu errado no Fritter e um relatório de erro foi gerado. O relatório pode ser enviado aos desenvolvedores do Fritter para ajudar a corrigir o problema."),
        "subscribe": MessageLookupByLibrary.simpleMessage("Inscrever-se"),
        "subscriptions": MessageLookupByLibrary.simpleMessage("Inscrições"),
        "system": MessageLookupByLibrary.simpleMessage("Sistema"),
        "thanks_for_helping_fritter": MessageLookupByLibrary.simpleMessage("Obrigado por ajudar o Fritter! 💖"),
        "thanks_for_reporting_we_will_try_and_fix_it_in_no_time": MessageLookupByLibrary.simpleMessage(
            "Obrigado por relatar. Vamos tentar corrigi-lo o mais rápido possível!"),
        "the_file_does_not_exist_please_ensure_it_is_located_at_file_path": m13,
        "theme": MessageLookupByLibrary.simpleMessage("Tema"),
        "this_group_contains_no_subscriptions":
            MessageLookupByLibrary.simpleMessage("Este grupo não contém inscrições!"),
        "this_user_does_not_follow_anyone": MessageLookupByLibrary.simpleMessage("Este usuário não segue ninguém!"),
        "this_user_does_not_have_anyone_following_them":
            MessageLookupByLibrary.simpleMessage("Este usuário não tem nenhum seguidor!"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("Miniatura"),
        "timed_out_trying_to_send_the_ping":
            MessageLookupByLibrary.simpleMessage("Tempo esgotado tentando enviar o ping 😢"),
        "trending": MessageLookupByLibrary.simpleMessage("Tendência"),
        "true_black": MessageLookupByLibrary.simpleMessage("Preto Verdadeiro?"),
        "tweets": MessageLookupByLibrary.simpleMessage("Tweets"),
        "tweets_and_replies": MessageLookupByLibrary.simpleMessage("Tweets e Respostas"),
        "unable_to_check_if_this_is_a_legacy_Android_device":
            MessageLookupByLibrary.simpleMessage("Não foi possível verificar se este é um dispositivo Android antigo."),
        "unable_to_find_the_app_package_info":
            MessageLookupByLibrary.simpleMessage("Não foi possível encontrar as informações do pacote do aplicativo"),
        "unable_to_find_your_saved_tweets":
            MessageLookupByLibrary.simpleMessage("Não foi possível encontrar seus tweets salvos."),
        "unable_to_load_subscription_groups":
            MessageLookupByLibrary.simpleMessage("Não foi possível carregar os grupos de inscrições"),
        "unable_to_load_the_group": MessageLookupByLibrary.simpleMessage("Não foi possível carregar o grupo"),
        "unable_to_load_the_group_settings":
            MessageLookupByLibrary.simpleMessage("Não foi possível carregar as configurações do grupo"),
        "unable_to_load_the_list_of_follows":
            MessageLookupByLibrary.simpleMessage("Não foi possível carregar a lista de seguidores"),
        "unable_to_load_the_next_page_of_follows":
            MessageLookupByLibrary.simpleMessage("Não foi possível carregar a próxima página de seguidores"),
        "unable_to_load_the_next_page_of_replies":
            MessageLookupByLibrary.simpleMessage("Não foi possível carregar a próxima página de respostas"),
        "unable_to_load_the_next_page_of_tweets":
            MessageLookupByLibrary.simpleMessage("Não foi possível carregar a próxima página de tweets"),
        "unable_to_load_the_profile": MessageLookupByLibrary.simpleMessage("Não foi possível carregar o perfil"),
        "unable_to_load_the_search_results":
            MessageLookupByLibrary.simpleMessage("Não foi possível carregar os resultados da pesquisa."),
        "unable_to_load_the_tweet": MessageLookupByLibrary.simpleMessage("Não foi possível carregar o tweet"),
        "unable_to_load_the_tweets": MessageLookupByLibrary.simpleMessage("Não foi possível carregar os tweets"),
        "unable_to_load_the_tweets_for_the_feed":
            MessageLookupByLibrary.simpleMessage("Não foi possível carregar os tweets para o feed"),
        "unable_to_send_the_ping_e_to_string": m19,
        "unable_to_send_the_ping_the_status_code_was_response_statusCode": m20,
        "unsubscribe": MessageLookupByLibrary.simpleMessage("Cancelar inscrição"),
        "use_true_black_for_the_dark_mode_theme":
            MessageLookupByLibrary.simpleMessage("Use preto verdadeiro para o tema do modo escuro"),
        "version": MessageLookupByLibrary.simpleMessage("Versão"),
        "whether_errors_should_be_reported_to_sentry":
            MessageLookupByLibrary.simpleMessage("Se os erros devem ser relatados ao Sentry"),
        "which_tab_is_shown_when_the_app_opens":
            MessageLookupByLibrary.simpleMessage("Qual aba é mostrada quando o aplicativo é aberto"),
        "would_you_like_to_enable_automatic_error_reporting":
            MessageLookupByLibrary.simpleMessage("Deseja ativar o relatório automático de erros?"),
        "you_have_not_saved_any_tweets_yet":
            MessageLookupByLibrary.simpleMessage("Você ainda não salvou nenhum tweet!"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_data_can_only_be_imported_from":
            MessageLookupByLibrary.simpleMessage(
                "Seu dispositivo está executando uma versão do Android anterior ao KitKat (4.4), portanto, os dados só podem ser importados de:"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to":
            MessageLookupByLibrary.simpleMessage(
                "Seu dispositivo está executando uma versão do Android anterior ao KitKat (4.4), portanto, a exportação só pode ser salva em:"),
        "your_report_will_be_sent_to_fritter_sentry_project": MessageLookupByLibrary.simpleMessage(
            "Seu relatório será enviado para o projeto Sentry do Fritter, e os detalhes de privacidade podem ser encontrados em:")
      };
}
