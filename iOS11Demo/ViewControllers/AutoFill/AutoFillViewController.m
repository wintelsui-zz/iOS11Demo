//
//  AutoFillViewController.m
//  iOS11Demo
//
//  Created by wintelsui on 2017/10/21.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "AutoFillViewController.h"

@interface AutoFillViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation AutoFillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userNameField.textContentType = UITextContentTypeUsername;
    _passwordField.textContentType = UITextContentTypePassword;
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
