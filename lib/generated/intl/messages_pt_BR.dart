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

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pt_BR';

  static String m0(name) =>
      "Tem certeza de que deseja excluir o grupo de inscrições ${name}?";

  static String m1(fileName) => "Dados exportados para ${fileName}";

  static String m2(fullPath) => "Dados exportados para ${fullPath}";

  static String m3(timeagoFormat) => "Finalizado ${timeagoFormat}";

  static String m4(timeagoFormat) => "Termina ${timeagoFormat}";

  static String m5(snapshotData) => "Terminou com ${snapshotData} usuários";

  static String m6(snapshotData) =>
      "${snapshotData} usuários importados até agora";

  static String m7(date) => "Ingressou em ${date}";

  static String m8(num, numFormatted) =>
      "${Intl.plural(num, zero: 'nenhum voto', one: 'um voto', two: 'dois votos', few: '${numFormatted} votos', many: '${numFormatted} voto', other: '${numFormatted} votos')}";

  static String m9(errorMessage) =>
      "Por favor, verifique sua conexão à internet.\n\n${errorMessage}";

  static String m10(releaseVersion) => "Toque para baixar ${releaseVersion}";

  static String m11(getMediaType) => "Toque para mostrar ${getMediaType}";

  static String m12(state) => "O estado de conexão ${state} não é suportado";

  static String m13(filePath) =>
      "O arquivo não existe. Certifique-se de que está localizado em ${filePath}";

  static String m14(thisTweetUserName) => "${thisTweetUserName} retweetado";

  static String m15(num, numFormatted) =>
      "${Intl.plural(num, zero: 'nenhum tweet', one: 'um tweet', two: 'dois tweets', few: '${numFormatted} tweets', many: '${numFormatted} tweet', other: '${numFormatted} tweets')}";

  static String m16(widgetPlaceName) =>
      "Não foi possível carregar as tendências para ${widgetPlaceName}";

  static String m17(e) =>
      "Não foi possível atualizar as inscrições. O erro foi ${e}";

  static String m18(responseStatusCode) =>
      "Não foi possível salvar a mídia. O Twitter retornou um status de ${responseStatusCode}";

  static String m19(e) => "Não foi possível enviar o ping. ${e}";

  static String m20(statusCode) =>
      "Não foi possível enviar o ping. O código de estado era ${statusCode}";

  static String m21(releaseVersion) =>
      "Atualizar para ${releaseVersion} através do seu cliente F-Droid";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Sobre"),
        "account_suspended":
            MessageLookupByLibrary.simpleMessage("Conta suspensa"),
        "add_to_group":
            MessageLookupByLibrary.simpleMessage("Adicionar ao grupo"),
        "all": MessageLookupByLibrary.simpleMessage("Tudo"),
        "all_the_great_software_used_by_fritter":
            MessageLookupByLibrary.simpleMessage(
                "Todo o ótimo software usado por Fritter"),
        "an_error_was_reported_to_sentry_thank_you":
            MessageLookupByLibrary.simpleMessage(
                "Um erro foi relatado ao Sentry. Obrigada!"),
        "an_update_for_fritter_is_available":
            MessageLookupByLibrary.simpleMessage(
                "Uma atualização para o Fritter está disponível! 🚀"),
        "are_you_sure": MessageLookupByLibrary.simpleMessage("Tem certeza?"),
        "are_you_sure_you_want_to_delete_the_subscription_group_name_of_group":
            m0,
        "back": MessageLookupByLibrary.simpleMessage("Voltar"),
        "blue_theme_based_on_the_twitter_color_scheme":
            MessageLookupByLibrary.simpleMessage(
                "Tema azul baseado no esquema de cores do Twitter"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "catastrophic_failure":
            MessageLookupByLibrary.simpleMessage("Falha catastrófica"),
        "contribute": MessageLookupByLibrary.simpleMessage("Contribuir"),
        "copied_address_to_clipboard": MessageLookupByLibrary.simpleMessage(
            "Endereço copiado para a área de transferência"),
        "copied_version_to_clipboard": MessageLookupByLibrary.simpleMessage(
            "Versão copiada para a área de transferência"),
        "could_not_contact_twitter": MessageLookupByLibrary.simpleMessage(
            "Não foi possível entrar em contato com o Twitter"),
        "could_not_find_any_tweets_by_this_user":
            MessageLookupByLibrary.simpleMessage(
                "Não foi possível encontrar nenhum tweet deste usuário!"),
        "could_not_find_any_tweets_from_the_last_7_days":
            MessageLookupByLibrary.simpleMessage(
                "Não foi possível encontrar nenhum tweet dos últimos 7 dias!"),
        "country": MessageLookupByLibrary.simpleMessage("País"),
        "dark": MessageLookupByLibrary.simpleMessage("Escuro"),
        "data": MessageLookupByLibrary.simpleMessage("Dados"),
        "data_exported_to_fileName": m1,
        "data_exported_to_fullPath": m2,
        "data_imported_successfully": MessageLookupByLibrary.simpleMessage(
            "Dados importados com sucesso"),
        "date_created": MessageLookupByLibrary.simpleMessage("Data de Criação"),
        "date_subscribed":
            MessageLookupByLibrary.simpleMessage("Data de Inscrição"),
        "default_tab": MessageLookupByLibrary.simpleMessage("Aba padrão"),
        "delete": MessageLookupByLibrary.simpleMessage("Excluir"),
        "disabled": MessageLookupByLibrary.simpleMessage("Desativado"),
        "don_not_send": MessageLookupByLibrary.simpleMessage("Não enviar"),
        "donate": MessageLookupByLibrary.simpleMessage("Doar"),
        "download": MessageLookupByLibrary.simpleMessage("Download"),
        "downloading_media":
            MessageLookupByLibrary.simpleMessage("Baixando mídia..."),
        "enable_sentry": MessageLookupByLibrary.simpleMessage("Ativar Sentry?"),
        "ended_timeago_format_endsAt_allowFromNow_true": m3,
        "ends_timeago_format_endsAt_allowFromNow_true": m4,
        "enter_your_twitter_username": MessageLookupByLibrary.simpleMessage(
            "Digite seu nome de usuário do Twitter"),
        "export": MessageLookupByLibrary.simpleMessage("Exportar"),
        "export_settings":
            MessageLookupByLibrary.simpleMessage("Exportar configurações?"),
        "export_subscription_group_members":
            MessageLookupByLibrary.simpleMessage(
                "Exportar membros do grupo de inscrições?"),
        "export_subscription_groups": MessageLookupByLibrary.simpleMessage(
            "Exportar grupos de inscrições?"),
        "export_subscriptions":
            MessageLookupByLibrary.simpleMessage("Exportar inscrições?"),
        "export_tweets":
            MessageLookupByLibrary.simpleMessage("Exportar tweets?"),
        "export_your_data":
            MessageLookupByLibrary.simpleMessage("Exportar seus dados"),
        "feed": MessageLookupByLibrary.simpleMessage("Feed"),
        "filters": MessageLookupByLibrary.simpleMessage("Filtros"),
        "finished_with_snapshotData_users": m5,
        "followers": MessageLookupByLibrary.simpleMessage("Seguidores"),
        "following": MessageLookupByLibrary.simpleMessage("Seguindo"),
        "fritter": MessageLookupByLibrary.simpleMessage("Fritter"),
        "fritter_blue": MessageLookupByLibrary.simpleMessage("Fritter azul"),
        "general": MessageLookupByLibrary.simpleMessage("Geral"),
        "groups": MessageLookupByLibrary.simpleMessage("Grupos"),
        "help_make_fritter_even_better": MessageLookupByLibrary.simpleMessage(
            "Ajude a deixar o Fritter ainda melhor"),
        "help_support_fritters_future": MessageLookupByLibrary.simpleMessage(
            "Ajude a apoiar o futuro do Fritter"),
        "here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future":
            MessageLookupByLibrary.simpleMessage(
                "Aqui estão os dados que serão enviados. Ele será usado apenas para determinar quais dispositivos e idiomas serão suportados no Fritter no futuro."),
        "if_you_have_any_feedback_on_this_feature_please_leave_it_on":
            MessageLookupByLibrary.simpleMessage(
                "Se você tiver algum comentário sobre esse recurso, deixe-o em"),
        "import": MessageLookupByLibrary.simpleMessage("Importar"),
        "import_data_from_another_device": MessageLookupByLibrary.simpleMessage(
            "Importar dados de outro dispositivo"),
        "import_from_twitter":
            MessageLookupByLibrary.simpleMessage("Importar do Twitter"),
        "import_subscriptions":
            MessageLookupByLibrary.simpleMessage("Importar inscrições"),
        "imported_snapshot_data_users_so_far": m6,
        "include_replies":
            MessageLookupByLibrary.simpleMessage("Incluir respostas"),
        "include_retweets":
            MessageLookupByLibrary.simpleMessage("Incluir retweets"),
        "it_looks_like_you_have_already_said_hello_from_this_version_of_fritter":
            MessageLookupByLibrary.simpleMessage(
                "Parece que você já disse olá desta versão do Fritter!"),
        "it_looks_like_you_have_already_sent_a_ping_recently":
            MessageLookupByLibrary.simpleMessage(
                "Parece que você já enviou um ping recentemente 🤔"),
        "joined": m7,
        "large": MessageLookupByLibrary.simpleMessage("Grande"),
        "legacy_android_import": MessageLookupByLibrary.simpleMessage(
            "Importação do Android antigo"),
        "let_the_developers_know_if_something_is_broken":
            MessageLookupByLibrary.simpleMessage(
                "Deixe os desenvolvedores saberem se algo está quebrado"),
        "licenses": MessageLookupByLibrary.simpleMessage("Licenças"),
        "light": MessageLookupByLibrary.simpleMessage("Claro"),
        "live": MessageLookupByLibrary.simpleMessage("LIVE"),
        "logging": MessageLookupByLibrary.simpleMessage("Criando Log"),
        "media": MessageLookupByLibrary.simpleMessage("Mídia"),
        "media_size": MessageLookupByLibrary.simpleMessage("Tamanho da mídia"),
        "medium": MessageLookupByLibrary.simpleMessage("Média"),
        "name": MessageLookupByLibrary.simpleMessage("Nome"),
        "never_send": MessageLookupByLibrary.simpleMessage("Nunca enviar"),
        "newTrans": MessageLookupByLibrary.simpleMessage("Novo"),
        "no": MessageLookupByLibrary.simpleMessage("Não"),
        "no_data_was_returned_which_should_never_happen_please_report_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "Nenhum dado foi retornado, o que nunca deveria acontecer. Por favor, reporte um bug, se possível!"),
        "no_results": MessageLookupByLibrary.simpleMessage("Nenhum resultado"),
        "no_subscriptions_try_searching_or_importing_some":
            MessageLookupByLibrary.simpleMessage(
                "Nenhuma inscrição. Tente pesquisar ou importar alguns!"),
        "note_due_to_a_twitter_limitation_not_all_tweets_may_be_included":
            MessageLookupByLibrary.simpleMessage(
                "Observação: devido a uma limitação do Twitter, nem todos os tweets podem ser incluídos"),
        "numberFormat_format_total_votes": m8,
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "oops_something_went_wrong":
            MessageLookupByLibrary.simpleMessage("Ops! Algo deu errado 🥲"),
        "pick_a_color":
            MessageLookupByLibrary.simpleMessage("Escolha uma cor!"),
        "pinned_tweet": MessageLookupByLibrary.simpleMessage("Tweet fixado"),
        "playback_speed":
            MessageLookupByLibrary.simpleMessage("Velocidade de reprodução"),
        "please_check_your_internet_connection_error_message": m9,
        "please_enter_a_name":
            MessageLookupByLibrary.simpleMessage("Por favor, digite um nome"),
        "please_make_sure_the_data_you_wish_to_import_is_located_there_then_press_the_import_button_below":
            MessageLookupByLibrary.simpleMessage(
                "Verifique se os dados que você deseja importar estão localizados lá e pressione o botão de importação abaixo."),
        "please_note_that_the_method_fritter_uses_to_import_subscriptions_is_heavily_rate_limited_by_twitter_so_this_may_fail_if_you_have_a_lot_of_followed_accounts":
            MessageLookupByLibrary.simpleMessage(
                "Observe que o método que o Fritter usa para importar inscrições é fortemente limitado pelo Twitter, portanto, isso pode falhar se você estiver seguindo muitas contas."),
        "prefix": MessageLookupByLibrary.simpleMessage("prefixo"),
        "private_profile":
            MessageLookupByLibrary.simpleMessage("Perfil privado"),
        "released_under_the_mit_license":
            MessageLookupByLibrary.simpleMessage("Lançado sob a licença MIT"),
        "replying_to": MessageLookupByLibrary.simpleMessage("Respondendo a"),
        "report": MessageLookupByLibrary.simpleMessage("Reportar"),
        "report_a_bug":
            MessageLookupByLibrary.simpleMessage("Reportar um erro"),
        "reporting_an_error":
            MessageLookupByLibrary.simpleMessage("Relatar um erro"),
        "retry": MessageLookupByLibrary.simpleMessage("Tentar novamente"),
        "save": MessageLookupByLibrary.simpleMessage("Salvar"),
        "save_bandwidth_using_smaller_images":
            MessageLookupByLibrary.simpleMessage(
                "Economize largura de banda usando imagens menores"),
        "saved": MessageLookupByLibrary.simpleMessage("Salvo"),
        "say_hello": MessageLookupByLibrary.simpleMessage("Diga Olá"),
        "say_hello_emoji": MessageLookupByLibrary.simpleMessage("Diga Olá 👋"),
        "selecting_individual_accounts_to_import_and_assigning_groups_are_both_planned_for_the_future_already":
            MessageLookupByLibrary.simpleMessage(
                "A seleção de contas individuais para importação e a atribuição de grupos já estão planejadas para o futuro!"),
        "send": MessageLookupByLibrary.simpleMessage("Enviar"),
        "send_a_non_identifying_ping_to_let_me_know_you_are_using_fritter_and_to_help_future_development":
            MessageLookupByLibrary.simpleMessage(
                "Envie um ping não identificável para me informar que você está usando o Fritter e para ajudar no desenvolvimento futuro"),
        "send_always": MessageLookupByLibrary.simpleMessage("Enviar sempre"),
        "send_once": MessageLookupByLibrary.simpleMessage("Enviar uma vez"),
        "share_tweet_content": MessageLookupByLibrary.simpleMessage(
            "Compartilhar conteúdo do tweet"),
        "share_tweet_link":
            MessageLookupByLibrary.simpleMessage("Compartilhar link do tweet"),
        "small": MessageLookupByLibrary.simpleMessage("Pequena"),
        "something_broke_in_fritter":
            MessageLookupByLibrary.simpleMessage("Algo quebrou no Fritter."),
        "something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated":
            MessageLookupByLibrary.simpleMessage(
                "Algo deu errado no Fritter e um relatório de erro foi gerado. O relatório pode ser enviado aos desenvolvedores do Fritter para ajudar a corrigir o problema."),
        "sorry_the_replied_tweet_could_not_be_found":
            MessageLookupByLibrary.simpleMessage(
                "Desculpe, o tweet respondido não foi encontrado!"),
        "subscribe": MessageLookupByLibrary.simpleMessage("Inscrever-se"),
        "subscriptions": MessageLookupByLibrary.simpleMessage("Inscrições"),
        "subtitles": MessageLookupByLibrary.simpleMessage("Legendas"),
        "successfully_saved_the_media":
            MessageLookupByLibrary.simpleMessage("Mídia salva com sucesso!"),
        "system": MessageLookupByLibrary.simpleMessage("Sistema"),
        "tap_to_download_release_version": m10,
        "tap_to_show_getMediaType_item_type": m11,
        "thanks_for_helping_fritter": MessageLookupByLibrary.simpleMessage(
            "Obrigado por ajudar o Fritter! 💖"),
        "thanks_for_reporting_we_will_try_and_fix_it_in_no_time":
            MessageLookupByLibrary.simpleMessage(
                "Obrigado por relatar. Vamos tentar corrigi-lo o mais rápido possível!"),
        "the_connection_state_state_is_not_supported": m12,
        "the_file_does_not_exist_please_ensure_it_is_located_at_file_path": m13,
        "the_tweet_did_not_contain_any_text_this_is_unexpected":
            MessageLookupByLibrary.simpleMessage(
                "O tweet não continha nenhum texto. Isso é inesperado"),
        "theme": MessageLookupByLibrary.simpleMessage("Tema"),
        "there_were_no_trends_returned_this_is_unexpected_please_report_as_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "Não houve tendências devolvidas. Isso é inesperado! Por favor, reporte como um bug, se possível."),
        "this_group_contains_no_subscriptions":
            MessageLookupByLibrary.simpleMessage(
                "Este grupo não contém inscrições!"),
        "this_took_too_long_to_load_please_check_your_network_connection":
            MessageLookupByLibrary.simpleMessage(
                "Isso demorou muito para carregar. Verifique sua conexão de rede!"),
        "this_tweet_is_unavailable": MessageLookupByLibrary.simpleMessage(
            "Este tweet está indisponível"),
        "this_tweet_user_name_retweeted": m14,
        "this_user_does_not_follow_anyone":
            MessageLookupByLibrary.simpleMessage(
                "Este usuário não segue ninguém!"),
        "this_user_does_not_have_anyone_following_them":
            MessageLookupByLibrary.simpleMessage(
                "Este usuário não tem nenhum seguidor!"),
        "thread": MessageLookupByLibrary.simpleMessage("Thread"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("Miniatura"),
        "timed_out": MessageLookupByLibrary.simpleMessage("Tempo esgotado"),
        "timed_out_trying_to_send_the_ping":
            MessageLookupByLibrary.simpleMessage(
                "Tempo esgotado tentando enviar o ping 😢"),
        "to_import_subscriptions_from_an_existing_twitter_account_enter_your_username_below":
            MessageLookupByLibrary.simpleMessage(
                "Para importar assinaturas de uma conta existente do Twitter, digite seu nome de usuário abaixo."),
        "toggle_all": MessageLookupByLibrary.simpleMessage("Alternar Tudo"),
        "trending": MessageLookupByLibrary.simpleMessage("Tendência"),
        "trends": MessageLookupByLibrary.simpleMessage("Tendências"),
        "true_black": MessageLookupByLibrary.simpleMessage("Preto Verdadeiro?"),
        "tweets": MessageLookupByLibrary.simpleMessage("Tweets"),
        "tweets_and_replies":
            MessageLookupByLibrary.simpleMessage("Tweets e Respostas"),
        "tweets_number": m15,
        "unable_to_check_if_this_is_a_legacy_Android_device":
            MessageLookupByLibrary.simpleMessage(
                "Não foi possível verificar se este é um dispositivo Android antigo."),
        "unable_to_find_the_app_package_info": MessageLookupByLibrary.simpleMessage(
            "Não foi possível encontrar as informações do pacote do aplicativo"),
        "unable_to_find_the_available_trend_locations":
            MessageLookupByLibrary.simpleMessage(
                "Não foi possível encontrar os locais de tendências disponíveis."),
        "unable_to_find_your_saved_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Não foi possível encontrar seus tweets salvos."),
        "unable_to_import":
            MessageLookupByLibrary.simpleMessage("Não foi possível importar"),
        "unable_to_load_subscription_groups":
            MessageLookupByLibrary.simpleMessage(
                "Não foi possível carregar os grupos de inscrições"),
        "unable_to_load_the_group": MessageLookupByLibrary.simpleMessage(
            "Não foi possível carregar o grupo"),
        "unable_to_load_the_group_settings":
            MessageLookupByLibrary.simpleMessage(
                "Não foi possível carregar as configurações do grupo"),
        "unable_to_load_the_list_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Não foi possível carregar a lista de seguidores"),
        "unable_to_load_the_next_page_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Não foi possível carregar a próxima página de seguidores"),
        "unable_to_load_the_next_page_of_replies":
            MessageLookupByLibrary.simpleMessage(
                "Não foi possível carregar a próxima página de respostas"),
        "unable_to_load_the_next_page_of_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Não foi possível carregar a próxima página de tweets"),
        "unable_to_load_the_profile": MessageLookupByLibrary.simpleMessage(
            "Não foi possível carregar o perfil"),
        "unable_to_load_the_search_results":
            MessageLookupByLibrary.simpleMessage(
                "Não foi possível carregar os resultados da pesquisa."),
        "unable_to_load_the_trends_for_widget_place_name": m16,
        "unable_to_load_the_tweet": MessageLookupByLibrary.simpleMessage(
            "Não foi possível carregar o tweet"),
        "unable_to_load_the_tweets": MessageLookupByLibrary.simpleMessage(
            "Não foi possível carregar os tweets"),
        "unable_to_load_the_tweets_for_the_feed":
            MessageLookupByLibrary.simpleMessage(
                "Não foi possível carregar os tweets para o feed"),
        "unable_to_refresh_the_subscriptions_the_error_was_e": m17,
        "unable_to_run_the_database_migrations":
            MessageLookupByLibrary.simpleMessage(
                "Não é possível executar as migrações de banco de dados"),
        "unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode":
            m18,
        "unable_to_send_the_ping_e_to_string": m19,
        "unable_to_send_the_ping_the_status_code_was_response_statusCode": m20,
        "unable_to_stream_the_trend_location_preference":
            MessageLookupByLibrary.simpleMessage(
                "Não é possível transmitir a preferência de localização da tendência"),
        "unknown": MessageLookupByLibrary.simpleMessage("Desconhecido"),
        "unsave": MessageLookupByLibrary.simpleMessage("Remover dos salvos"),
        "unsubscribe":
            MessageLookupByLibrary.simpleMessage("Cancelar inscrição"),
        "update_to_release_version_through_your_fdroid_client": m21,
        "updates": MessageLookupByLibrary.simpleMessage("Atualizações"),
        "use_true_black_for_the_dark_mode_theme":
            MessageLookupByLibrary.simpleMessage(
                "Use preto verdadeiro para o tema do modo escuro"),
        "user_not_found":
            MessageLookupByLibrary.simpleMessage("Usuário não encontrado"),
        "username": MessageLookupByLibrary.simpleMessage("Nome de usuário"),
        "version": MessageLookupByLibrary.simpleMessage("Versão"),
        "when_a_new_app_update_is_available":
            MessageLookupByLibrary.simpleMessage(
                "Quando uma nova atualização do aplicativo está disponível"),
        "whether_errors_should_be_reported_to_sentry":
            MessageLookupByLibrary.simpleMessage(
                "Se os erros devem ser relatados ao Sentry"),
        "which_tab_is_shown_when_the_app_opens":
            MessageLookupByLibrary.simpleMessage(
                "Qual aba é mostrada quando o aplicativo é aberto"),
        "would_you_like_to_enable_automatic_error_reporting":
            MessageLookupByLibrary.simpleMessage(
                "Deseja ativar o relatório automático de erros?"),
        "yes": MessageLookupByLibrary.simpleMessage("Sim"),
        "you_have_not_saved_any_tweets_yet":
            MessageLookupByLibrary.simpleMessage(
                "Você ainda não salvou nenhum tweet!"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_data_can_only_be_imported_from":
            MessageLookupByLibrary.simpleMessage(
                "Seu dispositivo está executando uma versão do Android anterior ao KitKat (4.4), portanto, os dados só podem ser importados de:"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to":
            MessageLookupByLibrary.simpleMessage(
                "Seu dispositivo está executando uma versão do Android anterior ao KitKat (4.4), portanto, a exportação só pode ser salva em:"),
        "your_profile_must_be_public_otherwise_the_import_will_not_work":
            MessageLookupByLibrary.simpleMessage(
                "Seu perfil deve ser público, caso contrário a importação não funcionará"),
        "your_report_will_be_sent_to_fritter_sentry_project":
            MessageLookupByLibrary.simpleMessage(
                "Seu relatório será enviado para o projeto Sentry do Fritter, e os detalhes de privacidade podem ser encontrados em:")
      };
}
