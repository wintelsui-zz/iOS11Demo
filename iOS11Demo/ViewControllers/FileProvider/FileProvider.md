#  [FileProvider 和 FileProviderUI] - 提供一套类似 Files app 的界面，让你可以获取用户设备上或者云端的文件。

在系统应用 “文件（Files App）” 中显示应用提供的文件。

1：基于  DocumentBrowser 的应用
使用UIDocumentBrowserViewController，这个视图控制并不包含返回按钮，所以用于创建基于系统提供的 UI 的文档浏览器的应用‘；
需要在 Info.plist中添加 UISupportsDocumentBrowser


2：仅仅选取 Document
UIDocumentPickerViewController



创建插件：FileProviderExtension



 PS:
 UTI:https://developer.apple.com/library/content/documentation/Miscellaneous/Reference/UTIRef/Articles/System-DeclaredUniformTypeIdentifiers.html
 例如：office文件的iOS-UTI支持
 文件格式    UTI Types
 doc                com.microsoft.word.doc
 docx              org.openxmlformats.wordprocessingml.document
 ppt                 com.microsoft.powerpoint.ppt
 pptx               org.openxmlformats.presentationml.presentation
 xls                  com.microsoft.excel.xls
 xlsx                org.openxmlformats.spreadsheetml.sheet
