//
//  FileProviderViewController.m
//  iOS11Demo
//
//  Created by wintelsui on 2017/10/21.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "FileProviderViewController.h"
#import "DocumentBrowserViewController.h"
#import "DocumentViewController.h"

#import "BFPaperButton.h"
#import "Document.h"


#define UTIContentTypes \
  @[@"com.microsoft.word.doc",\
    @"org.openxmlformats.wordprocessingml.document",\
    @"com.microsoft.powerpoint.ppt",\
    @"org.openxmlformats.presentationml.presentation",\
    @"com.microsoft.excel.xls",\
    @"org.openxmlformats.spreadsheetml.sheet",\
    @"com.adobe.pdf",\
    @"public.plain-text",\
    @"public.text"\
    ]\

@interface FileProviderViewController ()
<
UIDocumentPickerDelegate
>
{
    BFPaperButton *_documentBrowserButton;
    BFPaperButton *_documentPickerButton;
}
@end

@implementation FileProviderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _documentBrowserButton = ({
        BFPaperButton *btn = [[BFPaperButton alloc] initWithFrame:CGRectMake(20, 20, 280, 43) raised:NO];
        [btn setTitleFont:[UIFont systemFontOfSize:17.0]];
        btn.backgroundColor = RGB(52, 152, 219);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        [btn setTitle:@"Document Browser" forState:UIControlStateNormal];
        btn;
    });
    [self.view addSubview:_documentBrowserButton];
    [_documentBrowserButton addTarget:self action:@selector(documentBrowserButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_documentBrowserButton setHidden:YES];
    
    _documentPickerButton = ({
        BFPaperButton *btn = [[BFPaperButton alloc] initWithFrame:CGRectMake(20, 20, 280, 43) raised:NO];
        [btn setTitleFont:[UIFont systemFontOfSize:17.0]];
        btn.backgroundColor = RGB(52, 152, 219);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [btn setTitle:@"Document Picker" forState:UIControlStateNormal];
        btn;
    });
    [_documentPickerButton addTarget:self action:@selector(documentPickerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_documentPickerButton];
    
    [_documentBrowserButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_documentPickerButton.mas_top).offset(-20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
    }];
    
    
    [_documentPickerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20 - IPHONEX_HEIGHT_SAFE_BOTTOM_VERTICAL);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
    }];
}

/**
 基于文件浏览器

 @param sender sender
 */
- (void)documentBrowserButtonPressed:(id)sender{
    DocumentBrowserViewController *browser = [[DocumentBrowserViewController alloc] initForOpeningFilesWithContentTypes:@[@"public.text",@"public.plain-text"]];
    __weak typeof(self)weakself = self;
    [self presentViewController:browser animated:YES completion:^{
        [[WTSuspensionBall sharedSuspensionBall] setSuspensionBallHidden:NO];
        [[WTSuspensionBall sharedSuspensionBall] setActionObject:weakself
                                                 performSelector:@"dismissViewControllerAnimated:"
                                                      withObject:@(YES)];
    }];
}


/**
 文件选取器

 @param sender sender
 */
- (void)documentPickerButtonPressed:(id)sender{
    UIDocumentPickerViewController *picker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:UTIContentTypes inMode:UIDocumentPickerModeOpen];
    picker.delegate = self;
    picker.allowsMultipleSelection = YES;
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - -- Document Picker Delegate Start --

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray <NSURL *>*)urls{
    //选择文件
    NSLog(@"urls:%@",urls);
    if (urls == nil || [urls count] == 0) {
        return;
    }
    DocumentViewController *documentViewController = [[DocumentViewController alloc] init];
    documentViewController.document = [[Document alloc] initWithFileURL:[urls firstObject]];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:documentViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller{
    //取消选择
}

#pragma mark - -- Document Picker Delegate End --


- (void)dismissViewControllerAnimated:(NSNumber *)flag{
    if (flag) {
        [self dismissViewControllerAnimated:[flag boolValue] completion:nil];
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    [[WTSuspensionBall sharedSuspensionBall] setSuspensionBallHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
