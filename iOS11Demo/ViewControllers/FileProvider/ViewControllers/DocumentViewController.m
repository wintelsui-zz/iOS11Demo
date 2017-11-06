//
//  DocumentViewController.m
//  OneDocumentTest
//
//  Created by wintel on 2017/10/30.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "DocumentViewController.h"

@interface DocumentViewController()
{
    UITextView *_documentNameText;
}

@end

@implementation DocumentViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
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
    [self.document openWithCompletionHandler:^(BOOL success) {
        if (success) {
            NSString *documentName = self.document.fileURL.lastPathComponent;
            if (documentName) {
                self.title = documentName;
                NSArray *arrayName = [documentName componentsSeparatedByString:@"."];
                if (arrayName && [arrayName count] > 1) {
                    //有后缀名
                    NSString *type = [arrayName lastObject];
                    if ([type isEqualToString:@"txt"]) {
                        NSString *documantStr = [NSString stringWithContentsOfURL:self.document.fileURL encoding:NSUTF8StringEncoding error:nil];
                        _documentNameText.text = documantStr;
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

- (void)dismissDocumentViewController {
    [_documentNameText resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^ {
        [self.document closeWithCompletionHandler:nil];
    }];
}

@end
