//:   # iOS 11 Demo
//: - 更新说明：[OS 11 更新说明](https://developer.apple.com/library/content/releasenotes/General/WhatsNewIniOS/Articles/iOS%5C_11%5C_0.html#//apple%5C_ref/doc/uid/TP40017637-SW2)
//: ---
//: - 1:[PDFKit](https://developer.apple.com/documentation/pdfkit) - 使用这个框架显示和操作 pdf 文件。
//: - 2:[IdentityLookup](https://developer.apple.com/documentation/identitylookup)  - 使用 app extension 来拦截系统 SMS 和 MMS 的信息。
//: - 3:[DeviceCheck](https://developer.apple.com/documentation/devicecheck) - DeviceCheck允许通过自己的服务器与Apple服务器通讯，并为单个设备设置(per Device、per Developer)两个bit的数据。
//: - 4:[Drag and Drop](https://developer.apple.com/documentation/uikit/drag_and_drop) - 拖拽功能，文本，图片，在屏幕内拖拽内容到在屏幕内另一个地方，由于iPad 支持分屏，所以支持当前屏幕内跨应用拖拽。
//: - 5:[Core NFC](https://developer.apple.com/documentation/corenfc)- 在 iPhone 7 及其以上机器提供基础的近场通讯读取功能。可以进行读取 NFC 标签。
//: - 6:[Auto Fill](https://developer.apple.com/videos/play/wwdc2017/206/) - 从 iCloud Keychain 中获取密码，自动填充的功能现在开放给第三方开发者。UITextInputTraits 的 textContentType 中添加了 username 和 password，对适合的 text view 或者 text field 的 content type 进行配置，可以在要求输入用户名密码时获取键盘上方的自动填充，帮助用户快速登录。
//: - 9:[Core ML](https://developer.apple.com/machine-learning/) - Machine Learning。
//: ---
//: - 尚未实现完成
//: - 7:[FileProvider 和 FileProviderUI](https://developer.apple.com/documentation/fileprovider) - 提供一套类似 Files app 的界面，让你可以获取用户设备上或者云端的文件。
//: - 8:ARKit - 。
//: ---
//: - XCode 9
//: - 1:NameColor  - 在 xcassets 里添加颜色,使用\[UIColor colorNamed:@"ColorMyPink"\]读取。（AVAILABLE\_IOS(11\_0);）
import UIKit
var color = UIColor(named:"ColorMyPink")
//: ---
//:
//: [下一页](@next)
