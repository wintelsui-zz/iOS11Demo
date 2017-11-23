//: [上一页](@previous)
//:
//:  # AutoFill
//: - 用户名，密码的快捷输入
//: ---
//: - 从 iCloud Keychain 中获取密码，自动填充的功能现在开放给第三方开发者。UITextInputTraits 的 textContentType 中添加了 username 和 password，对适合的 text view 或者 text field 的 content type 进行配置，可以在要求输入用户名密码时获取键盘上方的自动填充，帮助用户快速登录
//: ---
//:
//: ![img](autoFill.png)
//:
//: - 1：支持UI 类型：
//: - UITextField
//: - UITextView
//: - UITextInput
//: -
//: - 2：使用
//: - (1)设置相应的textContentType属性，AutoFill 会自动关联，
//: - _userNameField.textContentType = UITextContentTypeUsername;
//: - _passwordField.textContentType = UITextContentTypePassword;
//: - (2)设置当输入密码时，自动关联网站密码
//: - 需要在项目中设置Associated Domains，
//: - 格式为：webcredentials:example.com(域名)
//: - 服务器需要配置
//: - [https://example.com/.well-known/apple-app-site-association](https://example.com/.well-known/apple-app-site-association)
//: - [https://example.com/apple-app-site-association](https://example.com/apple-app-site-association)
//: - apple-app-site-association文件格式为
//: ```
//:  {
//:      "webcredentials":{
//:         "apps":["ER82ALNC99.orz.wintelsui.test.iOS11Demo"]
//:     }
//:  }
//: ```
//: - 服务器域名需要SSL证书
//: -
//: ---
//: [下一页](@next)
