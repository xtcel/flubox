/// 多语言翻译支持文件
import 'package:get/get.dart';

class GetLocalizations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'login': 'Login',
          'mobile': 'Mobile',
          'password': 'Password',
          'setting': 'Setting',
          'logged_in': 'logged in as @name with email @email', // 带参示例
          'loginOut': 'Login Out',
          'Pull to refresh': 'Pull to refresh',
          'Release to refresh': 'Release to refresh',
          'Refreshing...': 'Refreshing...',
          'Refresh completed': 'Refresh completed',
          'Refresh failed': 'Refresh failed',
          'No more': 'No more',
        },
        'zh_CN': {
          'login': '登陆',
          'mobile': '手机号',
          'password': '密码',
          'setting': '设置',
          'logged_in': '你好 @name，你的邮箱是 @email',
          'loginOut': '退出登陆',
          'Pull to refresh': '下拉刷新',
          'Release to refresh': '释放刷新',
          'Refreshing...': '正在刷新...',
          'Refresh completed': '刷新完成',
          'Refresh failed': '刷新失败',
          'No more': '没有更多了',
        },
        'zh_HK': {
          'login': '登陸',
          'mobile': '手機號',
          'password': '密碼',
          'setting': '設置',
          'logged_in': '你好 @name，你的郵箱是 @email',
          'loginOut': '退出登陸',
          'Pull to refresh': '下拉刷新',
          'Release to refresh': '釋放刷新',
          'Refreshing...': '正在刷新...',
          'Refresh completed': '刷新完成',
          'Refresh failed': '刷新失敗',
          'No more': '沒有更多了',
        },
      };
}
