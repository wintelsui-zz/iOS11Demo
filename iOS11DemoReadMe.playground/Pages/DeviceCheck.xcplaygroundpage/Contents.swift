//: [上一页](@previous)
//:
//:   # Device Check
//: - DeviceCheck允许通过自己的服务器与Apple服务器通讯，并为单个设备设置(per Device、per Developer)两个bit的数据。
//: - 使用DeviceCheck API，结合服务器到服务器的API，可以在维护用户隐私的同时，设置和查询每个设备上的2bits数据。可能会使用这些数据来识别那些已经利用你提供的促销优惠的设备，或者标记一个你认为是欺诈的设备等等。
//: - 应用程序使用DeviceCheck API生成一个标识设备的临时token。关联服务器将这个token与您从苹果接收到的认证密钥相结合，并使用该结果请求对每个设备位的访问。在成功的认证之后，苹果将这些设备的当前值以及它们最后修改的日期返回给你的服务器。
//: ---
//: - [DeviceCheck 文档](https://developer.apple.com/documentation/devicecheck)
//: -
//: [下一页](@next)


