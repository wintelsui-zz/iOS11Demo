//:   #iOS 11 Demo#
//: - 更新说明：[OS 11 更新说明][1]
//: ---
//: - 1:[PDFKit][2] - 这是一个在 macOS 上已经长期存在的框架，但却在 iOS 上姗姗来迟。你可以使用这个框架显示和操作 pdf 文件。
//: - 2:[IdentityLookup][3]  - 使用 app extension 来拦截系统 SMS 和 MMS 的信息。
//: - 3:[DeviceCheck][9] - DeviceCheck允许通过自己的服务器与Apple服务器通讯，并为单个设备设置(per Device、per Developer)两个bit的数据。
//: - 4:[FileProvider 和 FileProviderUI][4] - 提供一套类似 Files app 的界面，让你可以获取用户设备上或者云端的文件。
//: - 5:[Drag and Drop][5] - 拖拽功能，文本，图片，在屏幕内拖拽内容到在屏幕内另一个地方，由于iPad 支持分屏，所以支持当前屏幕内跨应用拖拽。
//: - 6:[Core NFC][6]- 在 iPhone 7 及其以上机器提供基础的近场通讯读取功能。可以进行读取 NFC 标签。
//: - 7:[Auto Fill][7] - 从 iCloud Keychain 中获取密码，自动填充的功能现在开放给第三方开发者。UITextInputTraits 的 textContentType 中添加了 username 和 password，对适合的 text view 或者 text field 的 content type 进行配置，可以在要求输入用户名密码时获取键盘上方的自动填充，帮助用户快速登录。
//: - 8:ARKit - 。
//: - 9:[Core ML][8] - 。
//: ---
//: - XCode 9
//: - 1:NameColor  - 在 xcassets 里添加颜色,使用[UIColor colorNamed:@"ColorMyPink”]()读取。（AVAILABLE\_IOS(11\_0);）
//: ---
//: [1]:https://developer.apple.com/library/content/releasenotes/General/WhatsNewIniOS/Articles/iOS%5C_11%5C_0.html#//apple%5C_ref/doc/uid/TP40017637-SW2 "iOS 11 更新说明"
//: [2]:https://developer.apple.com/documentation/pdfkit "PDFKit"
//: [3]:https://developer.apple.com/documentation/identitylookup "IdentityLookup"
//: [4]:https://developer.apple.com/documentation/fileprovider "[FileProvider 和 FileProviderUI]"
//: [5]:https://developer.apple.com/documentation/uikit/drag_and_drop "Drag and Drop"
//: [6]:https://developer.apple.com/documentation/corenfc "Core NFC"
//: [7]:https://developer.apple.com/videos/play/wwdc2017/206/ "Auto Fill"
//: [8]:https://developer.apple.com/machine-learning/ "Core ML"
//: [9]:  https://developer.apple.com/documentation/devicecheck "DeviceCheck"
//: ---
//: [Next](@next)
