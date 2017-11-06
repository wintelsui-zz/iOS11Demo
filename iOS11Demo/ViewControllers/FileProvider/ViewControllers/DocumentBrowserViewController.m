//
//  DocumentBrowserViewController.m
//  iOS11Demo
//
//  Created by wintel on 2017/10/30.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "DocumentBrowserViewController.h"
#import "DocumentViewController.h"

#import "Document.h"

@interface DocumentBrowserViewController ()
<
UIDocumentBrowserViewControllerDelegate
>

@end

@implementation DocumentBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.browserUserInterfaceStyle = UIDocumentBrowserUserInterfaceStyleDark;
    self.delegate = self;
    self.allowsDocumentCreation = YES;       //是否允许创建
    self.allowsPickingMultipleItems = YES;   //是否允许多选
    
    // 添加一个关于
    UIBarButtonItem *aboutItem = [[UIBarButtonItem alloc] initWithTitle:@"About" style:UIBarButtonItemStylePlain target:self action:@selector(showAboutDocumentBrowser)];
    [self setAdditionalLeadingNavigationBarButtonItems:@[aboutItem]];
}

#pragma mark - -- Document Browser Delegate Start --

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller didRequestDocumentCreationWithHandler:(void(^)(NSURL *_Nullable urlToImport, UIDocumentBrowserImportMode importMode))importHandler{
    //收到创建文档回调
    //获得默认文件
    NSURL *newDocumentURL = [[NSBundle mainBundle] URLForResource:@"CreateDefaultTXT" withExtension:@"txt"];
    // Set the URL for the new document here. Optionally, you can present a template chooser before calling the importHandler.
    // Make sure the importHandler is always called, even if the user cancels the creation request.
    if (newDocumentURL != nil) {
        importHandler(newDocumentURL, UIDocumentBrowserImportModeCopy);
    } else {
        importHandler(newDocumentURL, UIDocumentBrowserImportModeNone);
    }
    NSLog(@"didRequestDocumentCreationWithHandler:\n%@",newDocumentURL);
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller didPickDocumentURLs:(NSArray <NSURL *> *)documentURLs{
    // 选择文档回调
    NSURL *sourceURL = documentURLs.firstObject;
    if (!sourceURL) {
        return;
    }
    
    // Present the Document View Controller for the first document that was picked.
    // If you support picking multiple items, make sure you handle them all.
    [self presentDocumentAtURL:sourceURL];
    NSLog(@"didPickDocumentURLs:\n%@",documentURLs);
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller didImportDocumentAtURL:(NSURL *)sourceURL toDestinationURL:(NSURL *)destinationURL{
    //导入文档回调
    // Present the Document View Controller for the new newly created document
    [self presentDocumentAtURL:destinationURL];
    NSLog(@"didImportDocumentAtURL:\n%@\nto\n%@",sourceURL,destinationURL);
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller failedToImportDocumentAtURL:(NSURL *)documentURL error:(NSError * _Nullable)error{
    //导入文档失败回调
    NSLog(@"failedToImportDocumentAtURL:\n%@\nError:%@",documentURL,error);
    
}

#pragma mark - -- Document Browser Delegate End --

- (void)presentDocumentAtURL:(NSURL *)documentURL {
    DocumentViewController *documentViewController = [[DocumentViewController alloc] init];
    documentViewController.document = [[Document alloc] initWithFileURL:documentURL];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:documentViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)showAboutDocumentBrowser{
    [self showSimpleAlertTitle:@"Document Browser About" body:@"基于DocumentBrowser的文件管理浏览功能" cancel:@"OK"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
