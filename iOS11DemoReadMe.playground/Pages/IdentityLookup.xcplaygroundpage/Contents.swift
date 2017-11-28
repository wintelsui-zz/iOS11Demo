//: [上一页](@previous)
//:
//:   # IdentityLookup
//: - 使用 IdentityLookup app extension 来拦截系统 SMS 和 MMS 的信息
//: ---
//: - 使用IdentityLookup来进行未知短信过滤，过滤并不能阻挡未知信息，只会讲信息过滤到系统指定的文件夹中。
//: - 该功能需要实现 “Message Filter Extension”。
//: - 在Message Filter Extension中，实时的根据号码或者内容查询本地或网络是否需要过滤信息。
//: - 信息应用只允许一个插件进行短信过滤操作，开关在系统设置的“信息”-“未知与过滤信息”中设置。
//: -
//: - 该插件与通话的“来电阻止与身份识别”过程不同，它是实时查询是否需要过滤，
//: - 既每次后会运行插件来判断是否需要过滤。
//: - 而“Call Directory Extension”是一次将所有号码提交给系统，
//: - 每次来电后系统从系统的存储区查询是否显示内容或阻止来电。
//: ---
//: - CallDirectory Extension iOS11后新增增量更新代码，而在 iOS10中，每次数据更新都是全量重新导入系统
//: ---
//: -
getMessageFilterExtension()
//: ![MessageFilter—Extension -w500](MessageFilterExtension.png)
//: -
//: ---
//: -
getCallDirectoryExtension()
//: ![CallDirectory-Extension -w500](CallDirectoryExtension.png)
//: -
//: ---
//:
//: [下一页](@next)



