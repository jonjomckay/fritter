// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a tr locale. All the
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
  String get localeName => 'tr';

  static String m0(name) =>
      "${name} abonelik grubunu silmek istediğinizden emin misiniz?";

  static String m1(fileName) => "Veriler ${fileName}\'a aktarıldı";

  static String m2(fullPath) => "Veriler ${fullPath} konumuna aktarıldı";

  static String m3(timeagoFormat) => "${timeagoFormat} sona erdi";

  static String m4(timeagoFormat) => "Bitiş ${timeagoFormat}";

  static String m5(snapshotData) => "${snapshotData} kullanıcı ile tamamlandı";

  static String m6(snapshotData) =>
      "Şimdiye kadar ${snapshotData} kullanıcı içe aktarıldı";

  static String m7(date) => "${date} tarihinde katıldı";

  static String m8(num, numFormatted) =>
      "${Intl.plural(num, zero: 'oy yok', one: 'one oy', two: '', few: '${numFormatted} oy', many: '${numFormatted} oy', other: '${numFormatted} oy')}";

  static String m9(errorMessage) =>
      "Lütfen internet bağlantınızı kontrol edin.\n\n${errorMessage}";

  static String m10(releaseVersion) =>
      "${releaseVersion} sürümünü indirmek için dokunun";

  static String m11(getMediaType) => "${getMediaType} göstermek için dokunun";

  static String m12(state) => "${state} bağlantı durumu desteklenmiyor";

  static String m13(filePath) =>
      "Dosya yok. Lütfen ${filePath} konumunda olduğundan emin olun";

  static String m14(thisTweetUserName) => "${thisTweetUserName} retweet\'ledi";

  static String m15(num, numFormatted) =>
      "${Intl.plural(num, zero: 'tweet yok', one: 'bir tweet', two: 'iki tweet', few: '${numFormatted} tweet', many: '${numFormatted} tweet', other: '${numFormatted} tweet')}";

  static String m16(widgetPlaceName) =>
      "${widgetPlaceName} için trendler yüklenemiyor";

  static String m17(e) => "Abonelikler yenilenemiyor. Hata şu: ${e}";

  static String m18(responseStatusCode) =>
      "Medya kaydedilemiyor. Twitter ${responseStatusCode} durumuyla döndü";

  static String m19(e) => "Ping gönderilemiyor. ${e}";

  static String m20(statusCode) =>
      "Ping gönderilemedi. Durum kodu ${statusCode}";

  static String m21(releaseVersion) =>
      "F-Droid istemciniz aracılığıyla ${releaseVersion} sürümüne güncelleyin";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Hakkında"),
        "account_suspended":
            MessageLookupByLibrary.simpleMessage("Hesap askıya alındı"),
        "add_to_group": MessageLookupByLibrary.simpleMessage("Gruba ekle"),
        "all": MessageLookupByLibrary.simpleMessage("Hepsi"),
        "all_the_great_software_used_by_fritter":
            MessageLookupByLibrary.simpleMessage(
                "Fritter tarafından kullanılan tüm harika yazılımlar"),
        "an_error_was_reported_to_sentry_thank_you":
            MessageLookupByLibrary.simpleMessage(
                "Sentry\'ye bir hata bildirildi. Teşekkürler!"),
        "an_update_for_fritter_is_available":
            MessageLookupByLibrary.simpleMessage(
                "Fritter için bir güncelleme mevcut! 🚀"),
        "are_you_sure": MessageLookupByLibrary.simpleMessage("Emin misiniz?"),
        "are_you_sure_you_want_to_delete_the_subscription_group_name_of_group":
            m0,
        "back": MessageLookupByLibrary.simpleMessage("Geri"),
        "blue_theme_based_on_the_twitter_color_scheme":
            MessageLookupByLibrary.simpleMessage(
                "Twitter renk şemasına dayalı mavi tema"),
        "cancel": MessageLookupByLibrary.simpleMessage("İptal et"),
        "catastrophic_failure":
            MessageLookupByLibrary.simpleMessage("Feci arıza"),
        "choose": MessageLookupByLibrary.simpleMessage("Seç"),
        "close": MessageLookupByLibrary.simpleMessage("Kapat"),
        "contribute": MessageLookupByLibrary.simpleMessage("Katkıda bulunun"),
        "copied_address_to_clipboard":
            MessageLookupByLibrary.simpleMessage("Adres panoya kopyalandı"),
        "copied_version_to_clipboard":
            MessageLookupByLibrary.simpleMessage("Sürüm panoya kopyalandı"),
        "could_not_contact_twitter": MessageLookupByLibrary.simpleMessage(
            "Twitter ile iletişim kurulamadı"),
        "could_not_find_any_tweets_by_this_user":
            MessageLookupByLibrary.simpleMessage(
                "Bu kullanıcıya ait tweet bulunamadı!"),
        "could_not_find_any_tweets_from_the_last_7_days":
            MessageLookupByLibrary.simpleMessage(
                "Son 7 güne ait tweet bulunamadı!"),
        "country": MessageLookupByLibrary.simpleMessage("Ülke"),
        "dark": MessageLookupByLibrary.simpleMessage("Koyu"),
        "data": MessageLookupByLibrary.simpleMessage("Veriler"),
        "data_exported_to_fileName": m1,
        "data_exported_to_fullPath": m2,
        "data_imported_successfully": MessageLookupByLibrary.simpleMessage(
            "Veriler başarıyla içe aktarıldı"),
        "date_created":
            MessageLookupByLibrary.simpleMessage("Oluşturulma Tarihi"),
        "date_subscribed":
            MessageLookupByLibrary.simpleMessage("Abone Olunan Tarih"),
        "default_tab": MessageLookupByLibrary.simpleMessage("Varsayılan sekme"),
        "delete": MessageLookupByLibrary.simpleMessage("Sil"),
        "disabled": MessageLookupByLibrary.simpleMessage("Devre dışı"),
        "don_not_send": MessageLookupByLibrary.simpleMessage("Gönderme"),
        "donate": MessageLookupByLibrary.simpleMessage("Bağış yapın"),
        "download": MessageLookupByLibrary.simpleMessage("İndir"),
        "download_handling":
            MessageLookupByLibrary.simpleMessage("İndirmelerin ele alınması"),
        "download_handling_description": MessageLookupByLibrary.simpleMessage(
            "İndirmeler nasıl ele alınmalı"),
        "download_handling_type_ask":
            MessageLookupByLibrary.simpleMessage("Her zaman sor"),
        "download_handling_type_directory":
            MessageLookupByLibrary.simpleMessage("Dizine kaydet"),
        "download_path": MessageLookupByLibrary.simpleMessage("İndirme yolu"),
        "downloading_media":
            MessageLookupByLibrary.simpleMessage("Medya indiriliyor..."),
        "enable_sentry":
            MessageLookupByLibrary.simpleMessage("Sentry etkinleştirilsin mi?"),
        "ended_timeago_format_endsAt_allowFromNow_true": m3,
        "ends_timeago_format_endsAt_allowFromNow_true": m4,
        "enter_your_twitter_username": MessageLookupByLibrary.simpleMessage(
            "Twitter kullanıcı adınızı girin"),
        "export": MessageLookupByLibrary.simpleMessage("Dışa aktar"),
        "export_settings":
            MessageLookupByLibrary.simpleMessage("Ayarlar aktarılsın mı?"),
        "export_subscription_group_members":
            MessageLookupByLibrary.simpleMessage(
                "Abonelik grubu üyeleri aktarılsın mı?"),
        "export_subscription_groups": MessageLookupByLibrary.simpleMessage(
            "Abonelik grupları aktarılsın mı?"),
        "export_subscriptions":
            MessageLookupByLibrary.simpleMessage("Abonelikler aktarılsın mı?"),
        "export_tweets":
            MessageLookupByLibrary.simpleMessage("Tweet\'ler aktarılsın mı?"),
        "export_your_data":
            MessageLookupByLibrary.simpleMessage("Verilerinizi dışa aktarın"),
        "feed": MessageLookupByLibrary.simpleMessage("Akış"),
        "filters": MessageLookupByLibrary.simpleMessage("Filtreler"),
        "finished_with_snapshotData_users": m5,
        "followers": MessageLookupByLibrary.simpleMessage("Takipçiler"),
        "following": MessageLookupByLibrary.simpleMessage("Takip ediyor"),
        "fritter": MessageLookupByLibrary.simpleMessage("Fritter"),
        "fritter_blue": MessageLookupByLibrary.simpleMessage("Fritter mavisi"),
        "general": MessageLookupByLibrary.simpleMessage("Genel"),
        "groups": MessageLookupByLibrary.simpleMessage("Gruplar"),
        "help_make_fritter_even_better": MessageLookupByLibrary.simpleMessage(
            "Fritter\'ı daha da iyi hale getirmeye yardımcı olun"),
        "help_support_fritters_future": MessageLookupByLibrary.simpleMessage(
            "Fritter\'ın geleceğini desteklemeye yardımcı olun"),
        "here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future":
            MessageLookupByLibrary.simpleMessage(
                "İşte gönderilecek veriler. Yalnızca gelecekte Fritter\'da hangi cihazların ve dillerin destekleneceğini belirlemek için kullanılacaktır."),
        "if_you_have_any_feedback_on_this_feature_please_leave_it_on":
            MessageLookupByLibrary.simpleMessage(
                "Bu özellikle ilgili herhangi bir görüşünüz varsa lütfen geri bildirim yapın"),
        "import": MessageLookupByLibrary.simpleMessage("İçe aktar"),
        "import_data_from_another_device": MessageLookupByLibrary.simpleMessage(
            "Verileri başka bir cihazdan aktarın"),
        "import_from_twitter":
            MessageLookupByLibrary.simpleMessage("Twitter\'dan içe aktar"),
        "import_subscriptions":
            MessageLookupByLibrary.simpleMessage("Abonelikleri içe aktar"),
        "imported_snapshot_data_users_so_far": m6,
        "include_replies":
            MessageLookupByLibrary.simpleMessage("Yanıtları dahil et"),
        "include_retweets":
            MessageLookupByLibrary.simpleMessage("Retweet\'leri dahil et"),
        "it_looks_like_you_have_already_said_hello_from_this_version_of_fritter":
            MessageLookupByLibrary.simpleMessage(
                "Görünüşe göre Fritter\'ın bu versiyonundan zaten merhaba demişsiniz!"),
        "it_looks_like_you_have_already_sent_a_ping_recently":
            MessageLookupByLibrary.simpleMessage(
                "Görünüşe göre yakın zamanda bir ping göndermişsin 🤔"),
        "joined": m7,
        "large": MessageLookupByLibrary.simpleMessage("Büyük"),
        "legacy_android_import": MessageLookupByLibrary.simpleMessage(
            "Eski Android için içe aktarma"),
        "let_the_developers_know_if_something_is_broken":
            MessageLookupByLibrary.simpleMessage(
                "Yanlış giden şeyler varsa geliştiricilere bildirin"),
        "licenses": MessageLookupByLibrary.simpleMessage("Lisanslar"),
        "light": MessageLookupByLibrary.simpleMessage("Açık"),
        "live": MessageLookupByLibrary.simpleMessage("CANLI"),
        "logging": MessageLookupByLibrary.simpleMessage("Günlük tutma"),
        "media": MessageLookupByLibrary.simpleMessage("Medya"),
        "media_size": MessageLookupByLibrary.simpleMessage("Medya boyutu"),
        "medium": MessageLookupByLibrary.simpleMessage("Orta"),
        "name": MessageLookupByLibrary.simpleMessage("Ad"),
        "never_send": MessageLookupByLibrary.simpleMessage("Asla gönderme"),
        "newTrans": MessageLookupByLibrary.simpleMessage("Yeni"),
        "no": MessageLookupByLibrary.simpleMessage("Hayır"),
        "no_data_was_returned_which_should_never_happen_please_report_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "Hiçbir veri dönmedi, bu asla olmamalıydı. Mümkünse lütfen bir hata bildirin!"),
        "no_results": MessageLookupByLibrary.simpleMessage("Sonuç yok"),
        "no_results_for":
            MessageLookupByLibrary.simpleMessage("Sonuç bulunamadı:"),
        "no_subscriptions_try_searching_or_importing_some":
            MessageLookupByLibrary.simpleMessage(
                "Abonelik yok. Bazılarını aramayı veya içe aktarmayı deneyin!"),
        "not_set": MessageLookupByLibrary.simpleMessage("Ayarlanmadı"),
        "note_due_to_a_twitter_limitation_not_all_tweets_may_be_included":
            MessageLookupByLibrary.simpleMessage(
                "Not: Twitter\'ın sınırlaması nedeniyle, tüm tweet\'ler dahil edilmeyebilir"),
        "numberFormat_format_total_votes": m8,
        "ok": MessageLookupByLibrary.simpleMessage("TAMAM"),
        "oops_something_went_wrong": MessageLookupByLibrary.simpleMessage(
            "Hop! Bir şeyler ters gitti 🥲"),
        "open_app_settings":
            MessageLookupByLibrary.simpleMessage("Uygulama ayarlarını aç"),
        "permission_not_granted": MessageLookupByLibrary.simpleMessage(
            "İzin verilmedi. Lütfen verdikten sonra tekrar deneyin!"),
        "pick_a_color": MessageLookupByLibrary.simpleMessage("Bir renk seçin!"),
        "pick_an_icon":
            MessageLookupByLibrary.simpleMessage("Bir simge seçin!"),
        "pinned_tweet":
            MessageLookupByLibrary.simpleMessage("Sabitlenmiş tweet"),
        "playback_speed": MessageLookupByLibrary.simpleMessage("Oynatma hızı"),
        "please_check_your_internet_connection_error_message": m9,
        "please_enter_a_name":
            MessageLookupByLibrary.simpleMessage("Lütfen bir ad girin"),
        "please_make_sure_the_data_you_wish_to_import_is_located_there_then_press_the_import_button_below":
            MessageLookupByLibrary.simpleMessage(
                "Lütfen içe aktarmak istediğiniz verilerin orada olduğundan emin olun, ardından aşağıdaki içe aktar düğmesine basın."),
        "please_note_that_the_method_fritter_uses_to_import_subscriptions_is_heavily_rate_limited_by_twitter_so_this_may_fail_if_you_have_a_lot_of_followed_accounts":
            MessageLookupByLibrary.simpleMessage(
                "Lütfen Fritter\'ın abonelikleri içe aktarmak için kullandığı yöntemin Twitter tarafından büyük ölçüde sınırlı olduğunu unutmayın, bu nedenle çok sayıda takip ettiğiniz hesap varsa bu başarısız olabilir."),
        "prefix": MessageLookupByLibrary.simpleMessage("ön ek"),
        "private_profile": MessageLookupByLibrary.simpleMessage("Gizli profil"),
        "released_under_the_mit_license": MessageLookupByLibrary.simpleMessage(
            "MIT Lisansı altında yayınlandı"),
        "replying_to": MessageLookupByLibrary.simpleMessage("Yanıtlıyor"),
        "report": MessageLookupByLibrary.simpleMessage("Bildir"),
        "report_a_bug": MessageLookupByLibrary.simpleMessage("Hata bildir"),
        "reporting_an_error":
            MessageLookupByLibrary.simpleMessage("Hata bildirme"),
        "retry": MessageLookupByLibrary.simpleMessage("Yeniden dene"),
        "save": MessageLookupByLibrary.simpleMessage("Kaydet"),
        "save_bandwidth_using_smaller_images": MessageLookupByLibrary.simpleMessage(
            "Daha küçük görüntüler kullanarak bant genişliğinden tasarruf edin"),
        "saved": MessageLookupByLibrary.simpleMessage("Kaydedilmiş"),
        "say_hello": MessageLookupByLibrary.simpleMessage("Merhaba deyin"),
        "say_hello_emoji":
            MessageLookupByLibrary.simpleMessage("Merhaba deyin 👋"),
        "search": MessageLookupByLibrary.simpleMessage("Ara"),
        "select": MessageLookupByLibrary.simpleMessage("Seç"),
        "selecting_individual_accounts_to_import_and_assigning_groups_are_both_planned_for_the_future_already":
            MessageLookupByLibrary.simpleMessage(
                "İçe aktarılacak bireysel hesapların seçilmesi ve grupların atanması şimdiden gelecek için planlanmıştır!"),
        "send": MessageLookupByLibrary.simpleMessage("Gönder"),
        "send_a_non_identifying_ping_to_let_me_know_you_are_using_fritter_and_to_help_future_development":
            MessageLookupByLibrary.simpleMessage(
                "Fritter kullandığınızı bildirmek ve gelecekteki geliştirmelere yardımcı olmak için tanımlayıcı olmayan bir ping gönderin"),
        "send_always": MessageLookupByLibrary.simpleMessage("Her zaman gönder"),
        "send_once": MessageLookupByLibrary.simpleMessage("Bir kez gönder"),
        "share_tweet_content":
            MessageLookupByLibrary.simpleMessage("Tweet içeriğini paylaş"),
        "share_tweet_content_and_link": MessageLookupByLibrary.simpleMessage(
            "Tweet içeriğini ve bağlantısını paylaş"),
        "share_tweet_link":
            MessageLookupByLibrary.simpleMessage("Tweet bağlantısını paylaş"),
        "should_check_for_updates_description":
            MessageLookupByLibrary.simpleMessage(
                "Fritter başladığında güncellemeleri denetle"),
        "should_check_for_updates_label":
            MessageLookupByLibrary.simpleMessage("Güncellemeleri denetle"),
        "small": MessageLookupByLibrary.simpleMessage("Küçük"),
        "something_broke_in_fritter": MessageLookupByLibrary.simpleMessage(
            "Fritter\'da bir şey bozuldu."),
        "something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated":
            MessageLookupByLibrary.simpleMessage(
                "Fritter\'da bir şeyler ters gitti ve bir hata raporu oluşturuldu. Bu rapor sorunu çözmeye yardımcı olması için Fritter geliştiricilerine gönderilebilir."),
        "sorry_the_replied_tweet_could_not_be_found":
            MessageLookupByLibrary.simpleMessage(
                "Üzgünüz, yanıtlanan tweet bulunamadı!"),
        "subscribe": MessageLookupByLibrary.simpleMessage("Abone ol"),
        "subscriptions": MessageLookupByLibrary.simpleMessage("Abonelikler"),
        "subtitles": MessageLookupByLibrary.simpleMessage("Altyazılar"),
        "successfully_saved_the_media":
            MessageLookupByLibrary.simpleMessage("Medya kaydedildi."),
        "system": MessageLookupByLibrary.simpleMessage("Sistem"),
        "tap_to_download_release_version": m10,
        "tap_to_show_getMediaType_item_type": m11,
        "thanks_for_helping_fritter": MessageLookupByLibrary.simpleMessage(
            "Fritter\'a yardım ettiğin için teşekkürler! 💖"),
        "thanks_for_reporting_we_will_try_and_fix_it_in_no_time":
            MessageLookupByLibrary.simpleMessage(
                "Raporladığınz için teşekkürler. En kısa sürede düzeltmeye çalışacağız!"),
        "the_connection_state_state_is_not_supported": m12,
        "the_file_does_not_exist_please_ensure_it_is_located_at_file_path": m13,
        "the_github_issue":
            MessageLookupByLibrary.simpleMessage("GitHub sorunu (#143)"),
        "the_tweet_did_not_contain_any_text_this_is_unexpected":
            MessageLookupByLibrary.simpleMessage(
                "Tweet\'te herhangi bir metin yoktu. Bu beklenmedik bir şey"),
        "theme": MessageLookupByLibrary.simpleMessage("Tema"),
        "there_were_no_trends_returned_this_is_unexpected_please_report_as_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "Geri dönen trend yoktu. Bu beklenmedik! Mümkünse lütfen bir hata olarak bildirin."),
        "this_group_contains_no_subscriptions":
            MessageLookupByLibrary.simpleMessage("Bu grup abonelik içermiyor!"),
        "this_took_too_long_to_load_please_check_your_network_connection":
            MessageLookupByLibrary.simpleMessage(
                "Bunun yüklenmesi çok uzun sürdü. Lütfen internet bağlantınızı kontrol edin!"),
        "this_tweet_is_unavailable":
            MessageLookupByLibrary.simpleMessage("Bu tweet kullanılamıyor"),
        "this_tweet_user_name_retweeted": m14,
        "this_user_does_not_follow_anyone":
            MessageLookupByLibrary.simpleMessage(
                "Bu kullanıcı kimseyi takip etmiyor!"),
        "this_user_does_not_have_anyone_following_them":
            MessageLookupByLibrary.simpleMessage(
                "Bu kullanıcıyı takip eden kimse yok!"),
        "thread": MessageLookupByLibrary.simpleMessage("Başlık"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("Küçük resim"),
        "timed_out":
            MessageLookupByLibrary.simpleMessage("Zaman aşımına uğradı"),
        "timed_out_trying_to_send_the_ping":
            MessageLookupByLibrary.simpleMessage(
                "Ping göndermeye çalışırken zaman aşımına uğradı 😢"),
        "to_import_subscriptions_from_an_existing_twitter_account_enter_your_username_below":
            MessageLookupByLibrary.simpleMessage(
                "Mevcut bir Twitter hesabından abonelikleri içe aktarmak için aşağıya kullanıcı adınızı girin."),
        "toggle_all": MessageLookupByLibrary.simpleMessage("Tümünü Aç/Kapat"),
        "trending": MessageLookupByLibrary.simpleMessage("Trend"),
        "trends": MessageLookupByLibrary.simpleMessage("Trendler"),
        "true_black": MessageLookupByLibrary.simpleMessage("Gerçek siyah mı?"),
        "tweets": MessageLookupByLibrary.simpleMessage("Tweet\'ler"),
        "tweets_and_replies":
            MessageLookupByLibrary.simpleMessage("Tweet\'ler & Yanıtlar"),
        "tweets_number": m15,
        "unable_to_check_if_this_is_a_legacy_Android_device":
            MessageLookupByLibrary.simpleMessage(
                "Bunun eski bir Android cihazı olup olmadığı kontrol edilemiyor."),
        "unable_to_find_the_app_package_info":
            MessageLookupByLibrary.simpleMessage(
                "Uygulamanın paket bilgisi bulunamadı"),
        "unable_to_find_the_available_trend_locations":
            MessageLookupByLibrary.simpleMessage(
                "Mevcut trend konumları bulunamadı."),
        "unable_to_find_your_saved_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Kaydedilmiş tweetleriniz bulunamadı."),
        "unable_to_import":
            MessageLookupByLibrary.simpleMessage("İçe aktarılamıyor"),
        "unable_to_load_subscription_groups":
            MessageLookupByLibrary.simpleMessage(
                "Abonelik grupları yüklenemiyor"),
        "unable_to_load_the_group":
            MessageLookupByLibrary.simpleMessage("Grup yüklenemedi"),
        "unable_to_load_the_group_settings":
            MessageLookupByLibrary.simpleMessage("Grup ayarları yüklenemedi"),
        "unable_to_load_the_list_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Aşağıdakilerin listesi yüklenemiyor"),
        "unable_to_load_the_next_page_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "Aşağıdakilerin sonraki sayfası yüklenemiyor"),
        "unable_to_load_the_next_page_of_replies":
            MessageLookupByLibrary.simpleMessage(
                "Yanıtların bir sonraki sayfası yüklenemedi"),
        "unable_to_load_the_next_page_of_tweets":
            MessageLookupByLibrary.simpleMessage(
                "Tweetlerin bir sonraki sayfası yüklenemiyor"),
        "unable_to_load_the_profile":
            MessageLookupByLibrary.simpleMessage("Profil yüklenemedi"),
        "unable_to_load_the_search_results":
            MessageLookupByLibrary.simpleMessage(
                "Arama sonuçları yüklenemiyor."),
        "unable_to_load_the_trends_for_widget_place_name": m16,
        "unable_to_load_the_tweet":
            MessageLookupByLibrary.simpleMessage("Tweet yüklenemedi"),
        "unable_to_load_the_tweets":
            MessageLookupByLibrary.simpleMessage("Tweetler yüklenemedi"),
        "unable_to_load_the_tweets_for_the_feed":
            MessageLookupByLibrary.simpleMessage(
                "Akış için tweetler yüklenemedi"),
        "unable_to_refresh_the_subscriptions_the_error_was_e": m17,
        "unable_to_run_the_database_migrations":
            MessageLookupByLibrary.simpleMessage(
                "Veritabanı geçişleri çalıştırılamıyor"),
        "unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode":
            m18,
        "unable_to_send_the_ping_e_to_string": m19,
        "unable_to_send_the_ping_the_status_code_was_response_statusCode": m20,
        "unable_to_stream_the_trend_location_preference":
            MessageLookupByLibrary.simpleMessage(
                "Trend konumu tercihi aktarılamıyor"),
        "unknown": MessageLookupByLibrary.simpleMessage("Bilinmeyen"),
        "unsave": MessageLookupByLibrary.simpleMessage("Kaydetmeyi iptal et"),
        "unsubscribe": MessageLookupByLibrary.simpleMessage("Abonelikten çık"),
        "update_to_release_version_through_your_fdroid_client": m21,
        "updates": MessageLookupByLibrary.simpleMessage("Güncellemeler"),
        "use_true_black_for_the_dark_mode_theme":
            MessageLookupByLibrary.simpleMessage(
                "Koyu tema için gerçek siyahı kullanın"),
        "user_not_found":
            MessageLookupByLibrary.simpleMessage("Kullanıcı bulunamadı"),
        "username": MessageLookupByLibrary.simpleMessage("Kullanıcı adı"),
        "version": MessageLookupByLibrary.simpleMessage("Sürüm"),
        "when_a_new_app_update_is_available":
            MessageLookupByLibrary.simpleMessage(
                "Yeni bir uygulama güncellemesi mevcut olduğunda"),
        "whether_errors_should_be_reported_to_sentry":
            MessageLookupByLibrary.simpleMessage(
                "Hataların Sentry\'ye rapor edilip edilmeyeceği"),
        "which_tab_is_shown_when_the_app_opens":
            MessageLookupByLibrary.simpleMessage(
                "Uygulama açıldığında hangi sekme gösteriliyor"),
        "would_you_like_to_enable_automatic_error_reporting":
            MessageLookupByLibrary.simpleMessage(
                "Otomatik hata raporlamayı etkinleştirmek ister misiniz?"),
        "yes": MessageLookupByLibrary.simpleMessage("Evet"),
        "you_have_not_saved_any_tweets_yet":
            MessageLookupByLibrary.simpleMessage(
                "Henüz hiç tweet kaydetmediniz!"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_data_can_only_be_imported_from":
            MessageLookupByLibrary.simpleMessage(
                "Cihazınız KitKat\'tan (4.4) daha eski bir Android sürümü çalıştırıyor, bu nedenle veriler yalnızca şuradan içe aktarılabilir:"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to":
            MessageLookupByLibrary.simpleMessage(
                "Cihazınız KitKat\'tan (4.4) daha eski bir Android sürümü çalıştırıyor, bu nedenle dışa aktarma sadece şuraya kaydedilebilir:"),
        "your_profile_must_be_public_otherwise_the_import_will_not_work":
            MessageLookupByLibrary.simpleMessage(
                "Profiliniz herkese açık olmalıdır, aksi takdirde alma işlemi çalışmaz"),
        "your_report_will_be_sent_to_fritter_sentry_project":
            MessageLookupByLibrary.simpleMessage(
                "Raporunuz Fritter\'ın Sentry projesine gönderilecek ve gizlilik ayrıntıları şu adreste bulunabilir:")
      };
}
