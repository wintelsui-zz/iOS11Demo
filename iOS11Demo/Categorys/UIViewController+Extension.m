//
//  UIViewController+Extension.m
//  iOS11Demo
//
//  Created by wintel on 2017/10/23.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

- (void)showSimpleAlertTitle:(NSString *)title
                        body:(NSString *)body
                      cancel:(NSString *)cancel
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:body preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (MBProgressHUD *)showProgressHUD:(NSString *)info{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = info;
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    return hud;
}

- (void)hideProgressHUD:(MBProgressHUD *)hud{
    if (hud) {
        [hud hideAnimated:YES];
        [hud removeFromSuperview];
        hud = nil;
    }
}

- (UIStoryboard *)storyboardByMyName:(NSString *)name{
    if (name) {
        if ([name isEqualToString:@"main"]) {
            return self.storyboard;
        }else{
            return [UIStoryboard storyboardWithName:name bundle:nil];
        }
    }
    return nil;
}

@end
