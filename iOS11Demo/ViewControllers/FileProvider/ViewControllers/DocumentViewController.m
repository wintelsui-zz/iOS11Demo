//
//  DocumentViewController.m
//  OneDocumentTest
//
//  Created by wintel on 2017/10/30.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "DocumentViewController.h"

#import "PDFKitViewController.h"

@interface DocumentViewController()
{
    UITextView *_documentNameText;
    PDFKitViewController *_pdfViewController;
}

@end

@implementation DocumentViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    self.title = @"TXT Reader&Editor";
    
    self.view.backgroundColor = [UIColor whiteColor];

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissDocumentViewController)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveDocument)];
    self.navigationItem.rightBarButtonItem = saveItem;
    
    _documentNameText = ({
        UITextView *textView = [[UITextView alloc] init];
        textView.backgroundColor = [UIColor whiteColor];
        textView.textColor = [UIColor blackColor];
        textView.text = @"";
        textView;
    });
    [self.view addSubview:_documentNameText];
    
    __weak typeof(self)weakself = self;
    [_documentNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0.0f);
        make.bottom.mas_equalTo(weakself.view.mas_centerY);
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_documentNameText resignFirstResponder];
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Access the document
    __weak typeof(self)weakself = self;
    [self.document openWithCompletionHandler:^(BOOL success) {
        if (success) {
            NSString *documentName = self.document.fileURL.lastPathComponent;
            if (documentName) {
                weakself.title = documentName;
                NSArray *arrayName = [documentName componentsSeparatedByString:@"."];
                if (arrayName && [arrayName count] > 1) {
                    //有后缀名
                    NSString *type = [arrayName lastObject];
                    if ([[type lowercaseString] isEqualToString:@"txt"]) {
                        NSString *documantStr = [NSString stringWithContentsOfURL:self.document.fileURL encoding:NSUTF8StringEncoding error:nil];
                        _documentNameText.text = documantStr;
                    }else if ([[type lowercaseString] isEqualToString:@"pdf"]) {
                        [[weakself PDFViewController] loadPDF];
                    }
                }else{
                    //无后缀名
                }
            }
            // Display the content of the document, e.g.:
        } else {
            // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
        }
    }];
}

- (void)saveDocument{
    [_documentNameText resignFirstResponder];
}

- (PDFKitViewController *)PDFViewController{
    if (_pdfViewController == nil) {
        iOS11ActionsListModels *actionInfo = [iOS11DemoAppVCsList objectForKey:@"PDFKit"];
        NSString *className = actionInfo.className;
        
        UIStoryboard *storyboard = [self storyboardByMyName:actionInfo.storyboard];
        UIViewController *page;
        if (storyboard && actionInfo.storyboardid) {
            page = [storyboard instantiateViewControllerWithIdentifier:actionInfo.storyboardid];
        }
        if (!page) {
            page = [[NSClassFromString(className) alloc] init];
        }
        _pdfViewController = (PDFKitViewController *)page;
        
        if (_pdfViewController) {
            [self addChildViewController:_pdfViewController];
            [self.view addSubview:_pdfViewController.view];
            _pdfViewController.openUrl = self.document.fileURL;
            
            [_pdfViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.right.mas_equalTo(0.0f);
            }];
        }
    }
    return _pdfViewController;
}

- (void)dismissDocumentViewController {
    [_documentNameText resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^ {
        [self.document closeWithCompletionHandler:nil];
    }];
}

@end
