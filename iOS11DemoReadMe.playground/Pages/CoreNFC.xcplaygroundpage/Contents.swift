//: [上一页](@previous)
//:
//:   # CoreNFC
//: - 在 iPhone 7 及其以上机器提供基础的近场通讯读取功能。可以进行读取 NFC 标签。
//: ---
//:   ## 功能限制：
//: - 1：只支持NFC Tags的读取，目前权限为只读状态，非接触式支付功能是不被开放的。
//: - 2：不支持输出和格式设置
//: - 3：仅支持iphone 7及其以上机型
//: - 4：读取NFC Tags应用必须在前台
//: - 5：一次读取超时时间为60s
//: ---
//:   ## Core NFC框架使用的要求：
//: - 1：工程需要设置 Capabilities中启用 “Near Field Communication Tag Readering” 。
//: - 2：需要添加Privacy - NFC Scan Usage Description权限使用描述
//: ---
//: ![img](nearFieldCommunicationTagReadering.png)
//: ![img](comAppleDeveloperNfcReadersessionFormats.png)
//: ---
//: [下一页](@next)
