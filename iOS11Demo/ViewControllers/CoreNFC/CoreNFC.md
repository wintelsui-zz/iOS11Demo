#  CoreNFC

功能限制：
1：只支持NFC Tags的读取
2：不支持输出和格式设置
3：仅支持iphone 7及其以上机型
4：读取NFC Tags应用必须在前台
5：一次读取超时时间为60s

Core NFC框架使用的要求：
1：工程需要设置 Capabilites 中开启 Near Field Communication Tag Reading
2：需要添加Privacy - NFC Scan Usage Description权限使用描述
