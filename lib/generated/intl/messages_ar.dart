// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(name) => "هل أنت متأكد من حذف اسم مجموعة الاشتراك ${name}?";

  static String m1(fileName) => "صُدِّرَت البيانات إلى ${fileName}";

  static String m2(fullPath) => "صُدِّرَت البيانات إلى ${fullPath}";

  static String m3(timeagoFormat) => "اتنهى ${timeagoFormat}";

  static String m4(timeagoFormat) => "يتنهي ${timeagoFormat}";

  static String m5(snapshotData) => "تم الانتهاء بـ${snapshotData} مستخدم";

  static String m6(snapshotData) => "استورد ${snapshotData} مستخدم لحد الآن";

  static String m7(date) => "انضم ${date}";

  static String m8(num, numFormatted) =>
      "${Intl.plural(num, zero: 'ولا تصويت', one: 'تصويت واحد', two: 'تصويتان', few: '${numFormatted} تصويتات', many: '${numFormatted} تصويت', other: '${numFormatted} تصويتات')}";

  static String m9(errorMessage) =>
      "رجائاً تحقق من اتصال الشبكة لديك.\n\n${errorMessage}";

  static String m10(releaseVersion) => "انقر للتحميل ${releaseVersion}";

  static String m11(getMediaType) => "انقر للعرض ${getMediaType}";

  static String m12(state) => "حالة اتصال الـ${state} غير مدعومة";

  static String m13(filePath) =>
      "الملف غير موجود. رجائاً تأكد أنه موجو في ${filePath}";

  static String m14(thisTweetUserName) => "${thisTweetUserName} أعاد التغريد";

  static String m15(num, numFormatted) =>
      "${Intl.plural(num, zero: 'لا تغريدات', one: 'تغريدة واحدة', two: 'تغريدتان', few: '${numFormatted} تغريدات', many: '${numFormatted} تغريدة', other: '${numFormatted} تغريدات')}";

  static String m16(widgetPlaceName) =>
      "غير قادر على تحميل الترندات لـ${widgetPlaceName}";

  static String m17(e) =>
      "غير قادر على تحديث الاشتراكات. الخطأ هو كالتالي ${e}";

  static String m18(responseStatusCode) =>
      "تعذر حفظ الوسائط. أعاد تويتر حالة ${responseStatusCode}";

  static String m19(e) => "غير قادر على إرسال البنج. ${e}";

  static String m20(statusCode) =>
      "تعذر إرسال الأمر ping. كان رمز الحالة ${statusCode}";

  static String m21(releaseVersion) =>
      "حدّث إلى ${releaseVersion} عبر عميل الـF-Droid لديك";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("عن"),
        "account_suspended":
            MessageLookupByLibrary.simpleMessage("الحساب معلق"),
        "add_to_group":
            MessageLookupByLibrary.simpleMessage("أضف إلى المجموعة"),
        "all": MessageLookupByLibrary.simpleMessage("الكل"),
        "all_the_great_software_used_by_fritter":
            MessageLookupByLibrary.simpleMessage(
                "كل البرمجيات الرائعة التي يستخدمها فريتر"),
        "an_error_was_reported_to_sentry_thank_you":
            MessageLookupByLibrary.simpleMessage("بُلِّغ عن خطأ للحارس. شكرا!"),
        "an_update_for_fritter_is_available":
            MessageLookupByLibrary.simpleMessage("هناك تحديث متاح لفريتر! 🚀"),
        "are_you_sure": MessageLookupByLibrary.simpleMessage("هل أنت متأكد؟"),
        "are_you_sure_you_want_to_delete_the_subscription_group_name_of_group":
            m0,
        "back": MessageLookupByLibrary.simpleMessage("رجوع"),
        "blue_theme_based_on_the_twitter_color_scheme":
            MessageLookupByLibrary.simpleMessage(
                "السمة الزرقاء بنائاً على سمة تويتر"),
        "cancel": MessageLookupByLibrary.simpleMessage("الغاء"),
        "catastrophic_failure":
            MessageLookupByLibrary.simpleMessage("فشل ذريع"),
        "contribute": MessageLookupByLibrary.simpleMessage("المساهمة"),
        "copied_address_to_clipboard":
            MessageLookupByLibrary.simpleMessage("نُسخ العنوان إلى الحافظة"),
        "copied_version_to_clipboard":
            MessageLookupByLibrary.simpleMessage("نُسخ الإصدار إلى الحافظة"),
        "could_not_contact_twitter": MessageLookupByLibrary.simpleMessage(
            "غير قادر على التواصل مع تويتر"),
        "could_not_find_any_tweets_by_this_user":
            MessageLookupByLibrary.simpleMessage(
                "لم يتم العثور على أي تغريدة من هذا المستخدم!"),
        "could_not_find_any_tweets_from_the_last_7_days":
            MessageLookupByLibrary.simpleMessage(
                "لم يُعثر على أي تغريدات من الأيام الـ7 الماضية!"),
        "country": MessageLookupByLibrary.simpleMessage("البلد"),
        "dark": MessageLookupByLibrary.simpleMessage("داكن"),
        "data": MessageLookupByLibrary.simpleMessage("البيانات"),
        "data_exported_to_fileName": m1,
        "data_exported_to_fullPath": m2,
        "data_imported_successfully":
            MessageLookupByLibrary.simpleMessage("استوردت البيانات بنجاح"),
        "date_created": MessageLookupByLibrary.simpleMessage("تاريخ الإنشاء"),
        "date_subscribed":
            MessageLookupByLibrary.simpleMessage("تاريخ الاشتراك"),
        "default_tab":
            MessageLookupByLibrary.simpleMessage("التبويب الافتراضي"),
        "delete": MessageLookupByLibrary.simpleMessage("حذف"),
        "disabled": MessageLookupByLibrary.simpleMessage("معطل"),
        "don_not_send": MessageLookupByLibrary.simpleMessage("لا تبعث"),
        "donate": MessageLookupByLibrary.simpleMessage("التبرع"),
        "download": MessageLookupByLibrary.simpleMessage("تحميل"),
        "downloading_media":
            MessageLookupByLibrary.simpleMessage("تحميل الوسائط..."),
        "enable_sentry": MessageLookupByLibrary.simpleMessage("تفعيل الحارس؟"),
        "ended_timeago_format_endsAt_allowFromNow_true": m3,
        "ends_timeago_format_endsAt_allowFromNow_true": m4,
        "enter_your_twitter_username":
            MessageLookupByLibrary.simpleMessage("ادخل اسم مستخدم للتويتر"),
        "export": MessageLookupByLibrary.simpleMessage("تصدير"),
        "export_settings":
            MessageLookupByLibrary.simpleMessage("تصدير الإعدادات؟"),
        "export_subscription_group_members":
            MessageLookupByLibrary.simpleMessage(
                "تصدير أفراد مجموعات الاشتراكات؟"),
        "export_subscription_groups":
            MessageLookupByLibrary.simpleMessage("تصدير مجموعات الاشتراكات؟"),
        "export_subscriptions":
            MessageLookupByLibrary.simpleMessage("تصدير الاشتراكات؟"),
        "export_tweets":
            MessageLookupByLibrary.simpleMessage("تصدير التغريدات؟"),
        "export_your_data":
            MessageLookupByLibrary.simpleMessage("تصدير بياناتك"),
        "feed": MessageLookupByLibrary.simpleMessage("التلقيم"),
        "filters": MessageLookupByLibrary.simpleMessage("المرشحات"),
        "finished_with_snapshotData_users": m5,
        "followers": MessageLookupByLibrary.simpleMessage("المتابِعون"),
        "following": MessageLookupByLibrary.simpleMessage("المتابَعون"),
        "fritter": MessageLookupByLibrary.simpleMessage("فريتر"),
        "fritter_blue": MessageLookupByLibrary.simpleMessage("فريتر أزرق"),
        "general": MessageLookupByLibrary.simpleMessage("العامة"),
        "groups": MessageLookupByLibrary.simpleMessage("المجموعات"),
        "help_make_fritter_even_better":
            MessageLookupByLibrary.simpleMessage("المساعدة في جعل فريتر أفضل"),
        "help_support_fritters_future":
            MessageLookupByLibrary.simpleMessage("ساعد على دعم مستقبل فريتر"),
        "here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future":
            MessageLookupByLibrary.simpleMessage(
                "هنا البيانات التي سيتم إرسالها. سيتم استخدامه فقط لتحديد الأجهزة واللغات التي يجب دعمها في Fritter في المستقبل."),
        "if_you_have_any_feedback_on_this_feature_please_leave_it_on":
            MessageLookupByLibrary.simpleMessage(
                "إذا كان لديك أي تعليقات عن هذه الميزة، رجائاً اكتبها هنا"),
        "import": MessageLookupByLibrary.simpleMessage("استيراد"),
        "import_data_from_another_device": MessageLookupByLibrary.simpleMessage(
            "استيراد البيانات من جهاز آخر"),
        "import_from_twitter":
            MessageLookupByLibrary.simpleMessage("الاستيراد من تويتر"),
        "import_subscriptions":
            MessageLookupByLibrary.simpleMessage("استيراد الاشتراكات"),
        "imported_snapshot_data_users_so_far": m6,
        "include_replies": MessageLookupByLibrary.simpleMessage("تضمين الردود"),
        "include_retweets":
            MessageLookupByLibrary.simpleMessage("تضمين إعادات التغاريد"),
        "it_looks_like_you_have_already_said_hello_from_this_version_of_fritter":
            MessageLookupByLibrary.simpleMessage(
                "يبدوا أنك قد سلمت بالفعل من إصدار فريتر هذا!"),
        "it_looks_like_you_have_already_sent_a_ping_recently":
            MessageLookupByLibrary.simpleMessage(
                "يبدوا أنك بالفعل قد أرسلت بينج حديثاً 🤔"),
        "joined": m7,
        "large": MessageLookupByLibrary.simpleMessage("كبير"),
        "legacy_android_import": MessageLookupByLibrary.simpleMessage(
            "استيردات البيانات للأندرويد القديم"),
        "let_the_developers_know_if_something_is_broken":
            MessageLookupByLibrary.simpleMessage(
                "دع المطورين يعرفون ما إذا كان هناك خطأ ما"),
        "licenses": MessageLookupByLibrary.simpleMessage("الرخص"),
        "light": MessageLookupByLibrary.simpleMessage("فاتح"),
        "live": MessageLookupByLibrary.simpleMessage("مباشر"),
        "logging": MessageLookupByLibrary.simpleMessage("تسجيل البيانات"),
        "media": MessageLookupByLibrary.simpleMessage("الوسائط"),
        "media_size": MessageLookupByLibrary.simpleMessage("حجم الوسائط"),
        "medium": MessageLookupByLibrary.simpleMessage("متوسط"),
        "name": MessageLookupByLibrary.simpleMessage("الاسم"),
        "never_send": MessageLookupByLibrary.simpleMessage("يا ويلك لو تبعث"),
        "newTrans": MessageLookupByLibrary.simpleMessage("الجديد"),
        "no": MessageLookupByLibrary.simpleMessage("لا"),
        "no_data_was_returned_which_should_never_happen_please_report_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "لم يتم إرجاع أي بيانات، وهو ما لا ينبغي أن يحدث أبدا. يرجى الإبلاغ عن وجود خلل، إذا كان ذلك ممكنا!"),
        "no_results": MessageLookupByLibrary.simpleMessage("لا نتائج"),
        "no_subscriptions_try_searching_or_importing_some":
            MessageLookupByLibrary.simpleMessage(
                "لا اشتراكات. حاول أن تبحث أو أن تستورد البعض!"),
        "note_due_to_a_twitter_limitation_not_all_tweets_may_be_included":
            MessageLookupByLibrary.simpleMessage(
                "ملاحظة: نظراً لقَيد معين من تويتر، قد لا يتم تضمين جميع التغريدات"),
        "numberFormat_format_total_votes": m8,
        "ok": MessageLookupByLibrary.simpleMessage("تمام"),
        "oops_something_went_wrong":
            MessageLookupByLibrary.simpleMessage("أوبسي! حدث خطأ ما 🥲"),
        "pick_a_color": MessageLookupByLibrary.simpleMessage("اختر لون!"),
        "pinned_tweet":
            MessageLookupByLibrary.simpleMessage("التغريدة المثبتة"),
        "playback_speed": MessageLookupByLibrary.simpleMessage("سرعة التشغيل"),
        "please_check_your_internet_connection_error_message": m9,
        "please_enter_a_name":
            MessageLookupByLibrary.simpleMessage("رجائاً اكتب اسماً"),
        "please_make_sure_the_data_you_wish_to_import_is_located_there_then_press_the_import_button_below":
            MessageLookupByLibrary.simpleMessage(
                "رجائاً تأكد ما إذا كانت البيانات موجودة هناك, ومن ثم اضغط على زر الاستيراد في أدناه."),
        "please_note_that_the_method_fritter_uses_to_import_subscriptions_is_heavily_rate_limited_by_twitter_so_this_may_fail_if_you_have_a_lot_of_followed_accounts":
            MessageLookupByLibrary.simpleMessage(
                "يرجى ملاحظة أن الطريقة التي يستخدمها Fritter لاستيراد الاشتراكات محدودة بشكل كبير من قبل Twitter ، لذلك قد يفشل هذا إذا كان لديك الكثير من الحسابات المتابعة."),
        "prefix": MessageLookupByLibrary.simpleMessage("السابقة"),
        "private_profile": MessageLookupByLibrary.simpleMessage("ملف شخصي خاص"),
        "released_under_the_mit_license": MessageLookupByLibrary.simpleMessage(
            "منشور تحت رخصة الإم أي تي (MIT License)"),
        "replying_to": MessageLookupByLibrary.simpleMessage("يرد على"),
        "report": MessageLookupByLibrary.simpleMessage("إبلاغ"),
        "report_a_bug": MessageLookupByLibrary.simpleMessage("الإبلاغ عن خطأ"),
        "reporting_an_error":
            MessageLookupByLibrary.simpleMessage("الإبلاغ غن خطأ"),
        "retry": MessageLookupByLibrary.simpleMessage("إعادة المحاوة"),
        "save": MessageLookupByLibrary.simpleMessage("حفظ"),
        "save_bandwidth_using_smaller_images":
            MessageLookupByLibrary.simpleMessage(
                "الحفاظ على عرض النطاق (البيانات) باستخدام صور أصغر"),
        "saved": MessageLookupByLibrary.simpleMessage("المحفوظ"),
        "say_hello": MessageLookupByLibrary.simpleMessage("سَلّم"),
        "say_hello_emoji": MessageLookupByLibrary.simpleMessage("سَلّم 👋"),
        "selecting_individual_accounts_to_import_and_assigning_groups_are_both_planned_for_the_future_already":
            MessageLookupByLibrary.simpleMessage(
                "تحديد حسابات مفردة، وتعيين مجموعات هما ميزات قد خُطط لها بالفعل للمستقبل!"),
        "send": MessageLookupByLibrary.simpleMessage("إرسال"),
        "send_a_non_identifying_ping_to_let_me_know_you_are_using_fritter_and_to_help_future_development":
            MessageLookupByLibrary.simpleMessage(
                "أرسل ping غير محدد الهوية لإخباري بأنك تستخدم Fritter وللمساعدة في التطوير المستقبلي"),
        "send_always": MessageLookupByLibrary.simpleMessage("ابعث كل مرة"),
        "send_once": MessageLookupByLibrary.simpleMessage("ابعث مرة واحدة"),
        "share_tweet_content":
            MessageLookupByLibrary.simpleMessage("مشاركة محتوى التغريدة"),
        "share_tweet_link":
            MessageLookupByLibrary.simpleMessage("مشاركة رابط التغريدة"),
        "small": MessageLookupByLibrary.simpleMessage("صغير"),
        "something_broke_in_fritter":
            MessageLookupByLibrary.simpleMessage("حدث خطأ ما في فريتر."),
        "something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated":
            MessageLookupByLibrary.simpleMessage(
                "حدث خطأ ما في فريتر، تم إنشاء تقرير لهذا الخطأ، تستطيع أن تبعث التقرير إلى مطورين فريتر لمساعدتهم على إصلاح المشكلة."),
        "sorry_the_replied_tweet_could_not_be_found":
            MessageLookupByLibrary.simpleMessage(
                "عذرا ، لم يتم العثور على التغريدة التي تم الرد عليها!"),
        "subscribe": MessageLookupByLibrary.simpleMessage("الاشتراك"),
        "subscriptions": MessageLookupByLibrary.simpleMessage("الإشتراكات"),
        "subtitles": MessageLookupByLibrary.simpleMessage("السطرجة"),
        "successfully_saved_the_media":
            MessageLookupByLibrary.simpleMessage("تم حفظ الوسائط بنجاح!!"),
        "system": MessageLookupByLibrary.simpleMessage("النظام"),
        "tap_to_download_release_version": m10,
        "tap_to_show_getMediaType_item_type": m11,
        "thanks_for_helping_fritter": MessageLookupByLibrary.simpleMessage(
            "شكراً على مساعدتك لفريتر! 💖"),
        "thanks_for_reporting_we_will_try_and_fix_it_in_no_time":
            MessageLookupByLibrary.simpleMessage(
                "شكراً علي تبليغك لنا. سنحاول أن نصحله بأسرع ما يمكن!"),
        "the_connection_state_state_is_not_supported": m12,
        "the_file_does_not_exist_please_ensure_it_is_located_at_file_path": m13,
        "the_tweet_did_not_contain_any_text_this_is_unexpected":
            MessageLookupByLibrary.simpleMessage(
                "التغريدة لا تحتوي على أي نص. هذا غير متوقع"),
        "theme": MessageLookupByLibrary.simpleMessage("السمة"),
        "there_were_no_trends_returned_this_is_unexpected_please_report_as_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "لم يتم إرجاع أي ترند. هذا غير متوقع! رجائاً أبلغ عن خطأ، إذا كان ممكناً."),
        "this_group_contains_no_subscriptions":
            MessageLookupByLibrary.simpleMessage(
                "هذه المجموعة لا تحتوي على أي مجموعات!"),
        "this_took_too_long_to_load_please_check_your_network_connection":
            MessageLookupByLibrary.simpleMessage(
                "استغرق هذا وقتا طويلا للتحميل. رجائاً تأكد من اتصال الشبكة لديك!"),
        "this_tweet_is_unavailable":
            MessageLookupByLibrary.simpleMessage("هذه التغريدة غير متاحة"),
        "this_tweet_user_name_retweeted": m14,
        "this_user_does_not_follow_anyone":
            MessageLookupByLibrary.simpleMessage(
                "هذا المستخدم لا يتابِع أحداً!"),
        "this_user_does_not_have_anyone_following_them":
            MessageLookupByLibrary.simpleMessage(
                "هذا المستخدم ليس لديه أي اشخاص يتابعهم!"),
        "thread": MessageLookupByLibrary.simpleMessage("سلسلة"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("الصورة المصغرة"),
        "timed_out": MessageLookupByLibrary.simpleMessage("انتهت المهلة"),
        "timed_out_trying_to_send_the_ping":
            MessageLookupByLibrary.simpleMessage(
                "انتهت مهلة المحاولة لإرسال البنج 😢"),
        "to_import_subscriptions_from_an_existing_twitter_account_enter_your_username_below":
            MessageLookupByLibrary.simpleMessage(
                "لاستيراد الاشتراكات من حساب تويتر موجود، أدخل اسم المستخدم أدناه."),
        "toggle_all": MessageLookupByLibrary.simpleMessage("تبديل الكل"),
        "trending": MessageLookupByLibrary.simpleMessage("الشائع"),
        "trends": MessageLookupByLibrary.simpleMessage("الترندات"),
        "true_black": MessageLookupByLibrary.simpleMessage("أسود حقيقي؟"),
        "tweets": MessageLookupByLibrary.simpleMessage("التغريدات"),
        "tweets_and_replies":
            MessageLookupByLibrary.simpleMessage("التغريدات والردود"),
        "tweets_number": m15,
        "unable_to_check_if_this_is_a_legacy_Android_device":
            MessageLookupByLibrary.simpleMessage(
                "غير قادر على التحقق ما إذا كان جهاز الأندرويد هذا قديم."),
        "unable_to_find_the_app_package_info":
            MessageLookupByLibrary.simpleMessage(
                "غير قادر على العثور على معلومات حزمة التطبيق"),
        "unable_to_find_the_available_trend_locations":
            MessageLookupByLibrary.simpleMessage(
                "غير قادر على تحديد موقع الترندات."),
        "unable_to_find_your_saved_tweets":
            MessageLookupByLibrary.simpleMessage(
                "غير قادر على العثور على تغريداتك المحفوظة."),
        "unable_to_import":
            MessageLookupByLibrary.simpleMessage("غير قادر على الاستيراد"),
        "unable_to_load_subscription_groups":
            MessageLookupByLibrary.simpleMessage(
                "غير قادر على تحميل مجموعات الاشتراك"),
        "unable_to_load_the_group":
            MessageLookupByLibrary.simpleMessage("غير قادر على تحميل المجموعة"),
        "unable_to_load_the_group_settings":
            MessageLookupByLibrary.simpleMessage(
                "غير قادر على تحميل إعدادات المجموعة"),
        "unable_to_load_the_list_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "غير قادر على تحميل قائمة المتابَعون"),
        "unable_to_load_the_next_page_of_follows":
            MessageLookupByLibrary.simpleMessage(
                "غير قادر على تحميل الصفحة المتابَعون التالية"),
        "unable_to_load_the_next_page_of_replies":
            MessageLookupByLibrary.simpleMessage(
                "غير قادر على تحميل الصفحة التالية من الردود"),
        "unable_to_load_the_next_page_of_tweets":
            MessageLookupByLibrary.simpleMessage(
                "غير قادر على تحميل الصفحة التالية من التغريدات"),
        "unable_to_load_the_profile": MessageLookupByLibrary.simpleMessage(
            "غير قادر على تحميل الملف الشخصي"),
        "unable_to_load_the_search_results":
            MessageLookupByLibrary.simpleMessage(
                "غير قادر على تحميل نتائج البحث."),
        "unable_to_load_the_trends_for_widget_place_name": m16,
        "unable_to_load_the_tweet": MessageLookupByLibrary.simpleMessage(
            "غير قادر على تحميل التغريدات"),
        "unable_to_load_the_tweets": MessageLookupByLibrary.simpleMessage(
            "غير قادر على تحميل التغريدات"),
        "unable_to_load_the_tweets_for_the_feed":
            MessageLookupByLibrary.simpleMessage(
                "غير قادر على تحميل التغريدات للمُلقّم"),
        "unable_to_refresh_the_subscriptions_the_error_was_e": m17,
        "unable_to_run_the_database_migrations":
            MessageLookupByLibrary.simpleMessage(
                "غير قادر على تشغيل تحديث قاعدة البيانات"),
        "unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode":
            m18,
        "unable_to_send_the_ping_e_to_string": m19,
        "unable_to_send_the_ping_the_status_code_was_response_statusCode": m20,
        "unable_to_stream_the_trend_location_preference":
            MessageLookupByLibrary.simpleMessage(
                "غير قادر على بث تفضيل موقع الترندات"),
        "unknown": MessageLookupByLibrary.simpleMessage("غير معروف"),
        "unsave": MessageLookupByLibrary.simpleMessage("الغاء الحفظ"),
        "unsubscribe": MessageLookupByLibrary.simpleMessage("إلغاء الاشتراك"),
        "update_to_release_version_through_your_fdroid_client": m21,
        "updates": MessageLookupByLibrary.simpleMessage("التحديثات"),
        "use_true_black_for_the_dark_mode_theme":
            MessageLookupByLibrary.simpleMessage(
                "استخدم ميزة الأسود الحقيقي للسمة الداكنة"),
        "user_not_found":
            MessageLookupByLibrary.simpleMessage("لم يُعثر على المستخدم"),
        "username": MessageLookupByLibrary.simpleMessage("اسم المستخدم"),
        "version": MessageLookupByLibrary.simpleMessage("الإصدار"),
        "when_a_new_app_update_is_available":
            MessageLookupByLibrary.simpleMessage(
                "عندما يكون هناك تحديث جديد للتطبيق"),
        "whether_errors_should_be_reported_to_sentry":
            MessageLookupByLibrary.simpleMessage(
                "ما إذا يجب على الأخطاء البرمجية أن يُبلّغ عنها إلى الحارس"),
        "which_tab_is_shown_when_the_app_opens":
            MessageLookupByLibrary.simpleMessage(
                "أي تبويب يظهر عندما يفتح التطبيق"),
        "would_you_like_to_enable_automatic_error_reporting":
            MessageLookupByLibrary.simpleMessage(
                "هل تُحب أن تفعل مُبَلغ الأخطاء الآلي؟"),
        "yes": MessageLookupByLibrary.simpleMessage("نعم"),
        "you_have_not_saved_any_tweets_yet":
            MessageLookupByLibrary.simpleMessage("لم تحفظ أي تغريدة حتى الآن!"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_data_can_only_be_imported_from":
            MessageLookupByLibrary.simpleMessage(
                "جهازك يشتغل على نظام أقدم من أندرويد كيت كات (4.4)، لذلك ستُستورد البيانات من:"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to":
            MessageLookupByLibrary.simpleMessage(
                "جهازك يشتغل على نظام أقدم من أندرويد كيت كات (4.4)، لذلك يستطيع التصدير أن يُحفظ فقط إلى:"),
        "your_profile_must_be_public_otherwise_the_import_will_not_work":
            MessageLookupByLibrary.simpleMessage(
                "يجب أن يكون ملف التعريف الخاص بك عاما، وإلا لن يعمل الاستيراد"),
        "your_report_will_be_sent_to_fritter_sentry_project":
            MessageLookupByLibrary.simpleMessage(
                "تقريرك سيُبعث إلى مشروع حراسة فريتر، ويمكن العثور على تفاصيل الخصوصية في:")
      };
}
