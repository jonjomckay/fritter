// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_Hans locale. All the
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
  String get localeName => 'zh_Hans';

  static String m0(name) => "您确定要删除订阅组 ${name} 吗？";

  static String m1(fileName) => "导出数据到文件${fileName}";

  static String m2(fullPath) => "导出数据到路径${fullPath}";

  static String m3(timeagoFormat) => "${timeagoFormat}已结束";

  static String m4(timeagoFormat) => "${timeagoFormat}结束";

  static String m5(snapshotData) => "${snapshotData} 个关注导入完成";

  static String m6(snapshotData) => "已导入${snapshotData} 名用户";

  static String m7(date) => "加入时间：${date}";

  static String m8(num, numFormatted) =>
      "${Intl.plural(num, zero: '0 票', one: '1 票', two: '2 票', few: '${numFormatted} 票', many: '${numFormatted} 票', other: '${numFormatted} 票')}";

  static String m9(errorMessage) => "请检查您的网络连接。\n\n${errorMessage}";

  static String m10(releaseVersion) => "点击下载${releaseVersion}";

  static String m11(getMediaType) => "点击 ${getMediaType}显示";

  static String m12(state) => "不支持 ${state} 连接状态";

  static String m13(filePath) => "该文件不存在。请确保它位于${filePath}的位置";

  static String m14(thisTweetUserName) => "${thisTweetUserName} 转发了推文";

  static String m15(num, numFormatted) =>
      "${Intl.plural(num, zero: '0 推文', one: '1 推文', two: '2 推文', few: '${numFormatted} 推文', many: '${numFormatted} 推文', other: '${numFormatted}推文')}";

  static String m16(widgetPlaceName) => "无法加载${widgetPlaceName}的热门";

  static String m17(responseStatusCode) =>
      "无法保存媒体。Twitter返回的状态是${responseStatusCode}";

  static String m18(e) => "无法发送ping。${e}";

  static String m19(statusCode) => "无法发送ping。状态代码为：${statusCode}";

  static String m20(releaseVersion) => "从 F-Droid 客户端更新 ${releaseVersion}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("关于Fritter"),
        "account_suspended": MessageLookupByLibrary.simpleMessage("账户被冻结"),
        "add_to_group": MessageLookupByLibrary.simpleMessage("添加到订阅组"),
        "all": MessageLookupByLibrary.simpleMessage("全部"),
        "all_the_great_software_used_by_fritter":
            MessageLookupByLibrary.simpleMessage("Fritter使用的伟大项目😇"),
        "an_error_was_reported_to_sentry_thank_you":
            MessageLookupByLibrary.simpleMessage("已向Sentry报告了一个错误。谢谢您!"),
        "an_update_for_fritter_is_available":
            MessageLookupByLibrary.simpleMessage("Fritter有新的更新可用"),
        "are_you_sure": MessageLookupByLibrary.simpleMessage("你确定吗？"),
        "are_you_sure_you_want_to_delete_the_subscription_group_name_of_group":
            m0,
        "back": MessageLookupByLibrary.simpleMessage("返回"),
        "blue_theme_based_on_the_twitter_color_scheme":
            MessageLookupByLibrary.simpleMessage("基于Twitter配色方案的蓝色主题"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "catastrophic_failure": MessageLookupByLibrary.simpleMessage("致命问题"),
        "choose": MessageLookupByLibrary.simpleMessage("选择"),
        "close": MessageLookupByLibrary.simpleMessage("关闭"),
        "contribute": MessageLookupByLibrary.simpleMessage("贡献💖"),
        "copied_address_to_clipboard":
            MessageLookupByLibrary.simpleMessage("已将地址复制到剪切板"),
        "copied_version_to_clipboard":
            MessageLookupByLibrary.simpleMessage("已将版本号复制到剪贴板"),
        "could_not_contact_twitter":
            MessageLookupByLibrary.simpleMessage("无法访问推特"),
        "could_not_find_any_tweets_by_this_user":
            MessageLookupByLibrary.simpleMessage("找不到这个用户的任何推文!"),
        "could_not_find_any_tweets_from_the_last_7_days":
            MessageLookupByLibrary.simpleMessage("找不到过去7天的任何推文!"),
        "country": MessageLookupByLibrary.simpleMessage("国家"),
        "dark": MessageLookupByLibrary.simpleMessage("黑暗"),
        "data": MessageLookupByLibrary.simpleMessage("数据"),
        "data_exported_to_fileName": m1,
        "data_exported_to_fullPath": m2,
        "data_imported_successfully":
            MessageLookupByLibrary.simpleMessage("数据导入成功"),
        "date_created": MessageLookupByLibrary.simpleMessage("创建日期"),
        "date_subscribed": MessageLookupByLibrary.simpleMessage("订阅日期"),
        "default_tab": MessageLookupByLibrary.simpleMessage("默认页面"),
        "delete": MessageLookupByLibrary.simpleMessage("删除"),
        "disabled": MessageLookupByLibrary.simpleMessage("不显示"),
        "don_not_send": MessageLookupByLibrary.simpleMessage("不要发送"),
        "donate": MessageLookupByLibrary.simpleMessage("捐赠"),
        "download": MessageLookupByLibrary.simpleMessage("下载"),
        "download_handling": MessageLookupByLibrary.simpleMessage("下载处理"),
        "download_handling_description":
            MessageLookupByLibrary.simpleMessage("下载应该如何工作"),
        "download_handling_type_ask":
            MessageLookupByLibrary.simpleMessage("始终询问"),
        "download_handling_type_directory":
            MessageLookupByLibrary.simpleMessage("保存到目录"),
        "download_path": MessageLookupByLibrary.simpleMessage("下载路径"),
        "downloading_media": MessageLookupByLibrary.simpleMessage("正在下载媒体..."),
        "enable_sentry": MessageLookupByLibrary.simpleMessage("启用 Sentry？"),
        "ended_timeago_format_endsAt_allowFromNow_true": m3,
        "ends_timeago_format_endsAt_allowFromNow_true": m4,
        "enter_your_twitter_username":
            MessageLookupByLibrary.simpleMessage("输入你的twitter用户名"),
        "export": MessageLookupByLibrary.simpleMessage("导出"),
        "export_settings": MessageLookupByLibrary.simpleMessage("导出设置？"),
        "export_subscription_group_members":
            MessageLookupByLibrary.simpleMessage("导出订阅组成员？"),
        "export_subscription_groups":
            MessageLookupByLibrary.simpleMessage("导出订阅组？"),
        "export_subscriptions": MessageLookupByLibrary.simpleMessage("导出订阅？"),
        "export_tweets": MessageLookupByLibrary.simpleMessage("导出推文？"),
        "export_your_data": MessageLookupByLibrary.simpleMessage("导出你的数据"),
        "feed": MessageLookupByLibrary.simpleMessage("最新"),
        "filters": MessageLookupByLibrary.simpleMessage("过滤器"),
        "finished_with_snapshotData_users": m5,
        "followers": MessageLookupByLibrary.simpleMessage("粉丝"),
        "following": MessageLookupByLibrary.simpleMessage("关注"),
        "fritter": MessageLookupByLibrary.simpleMessage("Fritter"),
        "fritter_blue": MessageLookupByLibrary.simpleMessage("Fritter 蓝"),
        "general": MessageLookupByLibrary.simpleMessage("一般"),
        "groups": MessageLookupByLibrary.simpleMessage("订阅组"),
        "help_make_fritter_even_better":
            MessageLookupByLibrary.simpleMessage("一起改进Fritter，让它变得更好😉"),
        "help_support_fritters_future":
            MessageLookupByLibrary.simpleMessage("帮助Fritter的未来🍚"),
        "here_is_the_data_that_will_be_sent_it_will_only_be_used_to_determine_which_devices_and_languages_to_support_in_fritter_in_the_future":
            MessageLookupByLibrary.simpleMessage(
                "以下是将要发送的数据。 它只会用于识别Fritter未来应该支持的设备和语言。"),
        "if_you_have_any_feedback_on_this_feature_please_leave_it_on":
            MessageLookupByLibrary.simpleMessage("如果您对此功能有任何反馈，请留言给我们"),
        "import": MessageLookupByLibrary.simpleMessage("导入"),
        "import_data_from_another_device":
            MessageLookupByLibrary.simpleMessage("从其他设备导入数据"),
        "import_from_twitter":
            MessageLookupByLibrary.simpleMessage("从twitter导入"),
        "import_subscriptions": MessageLookupByLibrary.simpleMessage("导入订阅"),
        "imported_snapshot_data_users_so_far": m6,
        "include_replies": MessageLookupByLibrary.simpleMessage("包括回复"),
        "include_retweets": MessageLookupByLibrary.simpleMessage("包括转发"),
        "it_looks_like_you_have_already_said_hello_from_this_version_of_fritter":
            MessageLookupByLibrary.simpleMessage("看起来你已经从这个版本的Fritter那里打过招呼了!"),
        "it_looks_like_you_have_already_sent_a_ping_recently":
            MessageLookupByLibrary.simpleMessage("您最近似乎已经ping过一次了 🤔"),
        "joined": m7,
        "large": MessageLookupByLibrary.simpleMessage("高"),
        "legacy_android_import":
            MessageLookupByLibrary.simpleMessage("从旧的Android设备导入"),
        "let_the_developers_know_if_something_is_broken":
            MessageLookupByLibrary.simpleMessage("如果有什么问题，请告诉开发者🐦"),
        "licenses": MessageLookupByLibrary.simpleMessage("许可证"),
        "light": MessageLookupByLibrary.simpleMessage("明亮"),
        "live": MessageLookupByLibrary.simpleMessage("活跃"),
        "logging": MessageLookupByLibrary.simpleMessage("日志📜"),
        "media": MessageLookupByLibrary.simpleMessage("媒体"),
        "media_size": MessageLookupByLibrary.simpleMessage("媒体尺寸"),
        "medium": MessageLookupByLibrary.simpleMessage("中"),
        "name": MessageLookupByLibrary.simpleMessage("取个名字"),
        "never_send": MessageLookupByLibrary.simpleMessage("从不发送"),
        "newTrans": MessageLookupByLibrary.simpleMessage("新的"),
        "no": MessageLookupByLibrary.simpleMessage("不"),
        "no_data_was_returned_which_should_never_happen_please_report_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "没有数据被返回，这不应该发生。如果可能的话，请报告一个错误!"),
        "no_results": MessageLookupByLibrary.simpleMessage("没有结果"),
        "no_results_for": MessageLookupByLibrary.simpleMessage("搜索词无结果："),
        "no_subscriptions_try_searching_or_importing_some":
            MessageLookupByLibrary.simpleMessage("没有订阅。尝试搜索或导入一些!"),
        "not_set": MessageLookupByLibrary.simpleMessage("未设置"),
        "note_due_to_a_twitter_limitation_not_all_tweets_may_be_included":
            MessageLookupByLibrary.simpleMessage("注意：由于Twitter的限制，可能不会包括所有的推文"),
        "numberFormat_format_total_votes": m8,
        "ok": MessageLookupByLibrary.simpleMessage("确定"),
        "oops_something_went_wrong":
            MessageLookupByLibrary.simpleMessage("哎呀! 出了点差错😥"),
        "open_app_settings": MessageLookupByLibrary.simpleMessage("打开应用设置"),
        "permission_not_granted":
            MessageLookupByLibrary.simpleMessage("未授予权限。 请在授权后重试！"),
        "pick_a_color": MessageLookupByLibrary.simpleMessage("挑一种颜色吧！"),
        "pick_an_icon": MessageLookupByLibrary.simpleMessage("挑选图标！"),
        "pinned_tweet": MessageLookupByLibrary.simpleMessage("固定推文"),
        "playback_speed": MessageLookupByLibrary.simpleMessage("播放速度"),
        "please_check_your_internet_connection_error_message": m9,
        "please_enter_a_name": MessageLookupByLibrary.simpleMessage("请输入订阅组名称"),
        "please_make_sure_the_data_you_wish_to_import_is_located_there_then_press_the_import_button_below":
            MessageLookupByLibrary.simpleMessage("请确保您想导入的数据位于那里，然后按下面的导入按钮。"),
        "please_note_that_the_method_fritter_uses_to_import_subscriptions_is_heavily_rate_limited_by_twitter_so_this_may_fail_if_you_have_a_lot_of_followed_accounts":
            MessageLookupByLibrary.simpleMessage(
                "请注意，Fritter用来导入订阅的方法是受到Twitter限制的，所以如果你有多要导入的账号，这可能会失败。"),
        "prefix": MessageLookupByLibrary.simpleMessage("字首"),
        "private_profile": MessageLookupByLibrary.simpleMessage("个人简介"),
        "released_under_the_mit_license":
            MessageLookupByLibrary.simpleMessage("在MIT许可下发布"),
        "replying_to": MessageLookupByLibrary.simpleMessage("回复"),
        "report": MessageLookupByLibrary.simpleMessage("报告"),
        "report_a_bug": MessageLookupByLibrary.simpleMessage("报告bug🐞"),
        "reporting_an_error": MessageLookupByLibrary.simpleMessage("报告一个错误"),
        "retry": MessageLookupByLibrary.simpleMessage("重试"),
        "save": MessageLookupByLibrary.simpleMessage("保存"),
        "save_bandwidth_using_smaller_images":
            MessageLookupByLibrary.simpleMessage(
                "您可以降低图像分辨率来降低流量使用（土豪和wifi请忽略）"),
        "saved": MessageLookupByLibrary.simpleMessage("保存"),
        "say_hello": MessageLookupByLibrary.simpleMessage("问候"),
        "say_hello_emoji": MessageLookupByLibrary.simpleMessage("你好👋"),
        "search": MessageLookupByLibrary.simpleMessage("搜索"),
        "select": MessageLookupByLibrary.simpleMessage("选择"),
        "selecting_individual_accounts_to_import_and_assigning_groups_are_both_planned_for_the_future_already":
            MessageLookupByLibrary.simpleMessage("未来我们会支持导入单个账号到指定组！"),
        "send": MessageLookupByLibrary.simpleMessage("发送"),
        "send_a_non_identifying_ping_to_let_me_know_you_are_using_fritter_and_to_help_future_development":
            MessageLookupByLibrary.simpleMessage(
                "通过向开发人员发送匿名ping，表明您正在使用Feitter，以支持未来的开发"),
        "send_always": MessageLookupByLibrary.simpleMessage("总是发送"),
        "send_once": MessageLookupByLibrary.simpleMessage("发送一次"),
        "share_tweet_content": MessageLookupByLibrary.simpleMessage("分享推特内容"),
        "share_tweet_content_and_link":
            MessageLookupByLibrary.simpleMessage("分享推文内容和链接"),
        "share_tweet_link": MessageLookupByLibrary.simpleMessage("分享推特链接"),
        "should_check_for_updates_description":
            MessageLookupByLibrary.simpleMessage("Fritter 启动时检查更新"),
        "should_check_for_updates_label":
            MessageLookupByLibrary.simpleMessage("检查更新"),
        "small": MessageLookupByLibrary.simpleMessage("低"),
        "something_broke_in_fritter":
            MessageLookupByLibrary.simpleMessage("Fritter发生异常。"),
        "something_just_went_wrong_in_fritter_and_an_error_report_has_been_generated":
            MessageLookupByLibrary.simpleMessage(
                "Fritter刚刚出了点问题，已经生成了一份错误报告。该报告可以发送给Fritter的开发者，以帮助解决这个问题。"),
        "sorry_the_replied_tweet_could_not_be_found":
            MessageLookupByLibrary.simpleMessage("对不起，没有找到回复的推文！"),
        "subscribe": MessageLookupByLibrary.simpleMessage("订阅"),
        "subscriptions": MessageLookupByLibrary.simpleMessage("订阅"),
        "subtitles": MessageLookupByLibrary.simpleMessage("字幕"),
        "successfully_saved_the_media":
            MessageLookupByLibrary.simpleMessage("已保存媒体文件。"),
        "system": MessageLookupByLibrary.simpleMessage("系统"),
        "tap_to_download_release_version": m10,
        "tap_to_show_getMediaType_item_type": m11,
        "thanks_for_helping_fritter":
            MessageLookupByLibrary.simpleMessage("谢谢你帮助Fritter! 💖"),
        "thanks_for_reporting_we_will_try_and_fix_it_in_no_time":
            MessageLookupByLibrary.simpleMessage("谢谢你的报告。我们会试着在短时间内修复它!"),
        "the_connection_state_state_is_not_supported": m12,
        "the_file_does_not_exist_please_ensure_it_is_located_at_file_path": m13,
        "the_github_issue":
            MessageLookupByLibrary.simpleMessage("GitHub 问题 (#143)"),
        "the_tweet_did_not_contain_any_text_this_is_unexpected":
            MessageLookupByLibrary.simpleMessage("该推文没有包含任何文字。令人感叹"),
        "theme": MessageLookupByLibrary.simpleMessage("主题"),
        "there_were_no_trends_returned_this_is_unexpected_please_report_as_a_bug_if_possible":
            MessageLookupByLibrary.simpleMessage(
                "没有返回的热门。这是出乎意料的! 如果可能的话，请作为一个错误报告。"),
        "this_group_contains_no_subscriptions":
            MessageLookupByLibrary.simpleMessage("这个组合不包含任何订阅!"),
        "this_took_too_long_to_load_please_check_your_network_connection":
            MessageLookupByLibrary.simpleMessage("加载时间太长了。 检查您的网络连接！"),
        "this_tweet_is_unavailable":
            MessageLookupByLibrary.simpleMessage("此推文不可用"),
        "this_tweet_user_name_retweeted": m14,
        "this_user_does_not_follow_anyone":
            MessageLookupByLibrary.simpleMessage("这个人谁都没关注😅！"),
        "this_user_does_not_have_anyone_following_them":
            MessageLookupByLibrary.simpleMessage("没有人关注他，令人感叹😥！"),
        "thread": MessageLookupByLibrary.simpleMessage("时间线"),
        "thumbnail": MessageLookupByLibrary.simpleMessage("缩略图"),
        "timed_out": MessageLookupByLibrary.simpleMessage("超时"),
        "timed_out_trying_to_send_the_ping":
            MessageLookupByLibrary.simpleMessage("ping传输超时😢"),
        "to_import_subscriptions_from_an_existing_twitter_account_enter_your_username_below":
            MessageLookupByLibrary.simpleMessage(
                "要从现有的Twitter账户导入订阅，请在下面输入你的用户名。"),
        "toggle_all": MessageLookupByLibrary.simpleMessage("全选"),
        "trending": MessageLookupByLibrary.simpleMessage("热门"),
        "trends": MessageLookupByLibrary.simpleMessage("热门"),
        "true_black": MessageLookupByLibrary.simpleMessage("真正的黑色?"),
        "tweets": MessageLookupByLibrary.simpleMessage("推文"),
        "tweets_and_replies": MessageLookupByLibrary.simpleMessage("推文和回复"),
        "tweets_number": m15,
        "unable_to_check_if_this_is_a_legacy_Android_device":
            MessageLookupByLibrary.simpleMessage("无法确定它是否是旧版的安卓设备。"),
        "unable_to_find_the_app_package_info":
            MessageLookupByLibrary.simpleMessage("无法找到应用包信息"),
        "unable_to_find_the_available_trend_locations":
            MessageLookupByLibrary.simpleMessage("无法找到可用的热门位置。"),
        "unable_to_find_your_saved_tweets":
            MessageLookupByLibrary.simpleMessage("无法找到您保存的推文。"),
        "unable_to_import": MessageLookupByLibrary.simpleMessage("无法导入"),
        "unable_to_load_subscription_groups":
            MessageLookupByLibrary.simpleMessage("无法载入订阅组"),
        "unable_to_load_the_group":
            MessageLookupByLibrary.simpleMessage("无法加载该组"),
        "unable_to_load_the_group_settings":
            MessageLookupByLibrary.simpleMessage("无法加载订阅组的设置"),
        "unable_to_load_the_list_of_follows":
            MessageLookupByLibrary.simpleMessage("无法加载关注列表"),
        "unable_to_load_the_next_page_of_follows":
            MessageLookupByLibrary.simpleMessage("无法载入下一页内容"),
        "unable_to_load_the_next_page_of_replies":
            MessageLookupByLibrary.simpleMessage("无法加载下一页的回复"),
        "unable_to_load_the_next_page_of_tweets":
            MessageLookupByLibrary.simpleMessage("无法载入下一页的推文"),
        "unable_to_load_the_profile":
            MessageLookupByLibrary.simpleMessage("无法载入配置文件"),
        "unable_to_load_the_search_results":
            MessageLookupByLibrary.simpleMessage("无法载入搜索结果。"),
        "unable_to_load_the_trends_for_widget_place_name": m16,
        "unable_to_load_the_tweet":
            MessageLookupByLibrary.simpleMessage("无法载入这条推文"),
        "unable_to_load_the_tweets":
            MessageLookupByLibrary.simpleMessage("无法载入推文"),
        "unable_to_load_the_tweets_for_the_feed":
            MessageLookupByLibrary.simpleMessage("无法载入最新推文"),
        "unable_to_run_the_database_migrations":
            MessageLookupByLibrary.simpleMessage("无法进行数据迁移"),
        "unable_to_save_the_media_twitter_returned_a_status_of_response_statusCode":
            m17,
        "unable_to_send_the_ping_e_to_string": m18,
        "unable_to_send_the_ping_the_status_code_was_response_statusCode": m19,
        "unable_to_stream_the_trend_location_preference":
            MessageLookupByLibrary.simpleMessage("无法传输热门位置偏好"),
        "unknown": MessageLookupByLibrary.simpleMessage("未知"),
        "unsave": MessageLookupByLibrary.simpleMessage("取消保存"),
        "unsubscribe": MessageLookupByLibrary.simpleMessage("取消订阅"),
        "update_to_release_version_through_your_fdroid_client": m20,
        "updates": MessageLookupByLibrary.simpleMessage("更新"),
        "use_true_black_for_the_dark_mode_theme":
            MessageLookupByLibrary.simpleMessage("在黑暗主题中使用真正的黑色"),
        "user_not_found": MessageLookupByLibrary.simpleMessage("未找到用户"),
        "username": MessageLookupByLibrary.simpleMessage("用户名"),
        "version": MessageLookupByLibrary.simpleMessage("版本"),
        "when_a_new_app_update_is_available":
            MessageLookupByLibrary.simpleMessage("当有新的应用可更新时"),
        "whether_errors_should_be_reported_to_sentry":
            MessageLookupByLibrary.simpleMessage("是否向Sentry发送错误？👀"),
        "which_tab_is_shown_when_the_app_opens":
            MessageLookupByLibrary.simpleMessage("打开应用时显示哪个页面"),
        "would_you_like_to_enable_automatic_error_reporting":
            MessageLookupByLibrary.simpleMessage("您想启用自动报告错误功能吗？"),
        "yes": MessageLookupByLibrary.simpleMessage("好"),
        "you_have_not_saved_any_tweets_yet":
            MessageLookupByLibrary.simpleMessage("您还没有保存任何推文呢！"),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_data_can_only_be_imported_from":
            MessageLookupByLibrary.simpleMessage(
                "你的设备运行的是比Android（4.4）更早的安卓版本，所以数据只能从这里导入："),
        "your_device_is_running_a_version_of_android_older_than_kitKat_so_the_export_can_only_be_saved_to":
            MessageLookupByLibrary.simpleMessage(
                "你的设备运行的是比Android（4.4）更早的安卓版本，所有导出的数据只能保存到以下位置："),
        "your_profile_must_be_public_otherwise_the_import_will_not_work":
            MessageLookupByLibrary.simpleMessage("你的个人资料必须是公开的，否则将无法导入"),
        "your_report_will_be_sent_to_fritter_sentry_project":
            MessageLookupByLibrary.simpleMessage(
                "您的报告将被发送到Fritter的Sentry项目，详细的隐私信息可以在以下网站找到：")
      };
}
