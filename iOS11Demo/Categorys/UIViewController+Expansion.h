//
//  UIViewController+Expansion.h
//  iOS11Demo
//
//  Created by wintel on 2017/10/23.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (Expansion)


/**
 在当前 ViewController 内显示 Alert

 @param title   标题
 @param body    信息
 @param cancel  取消
 */
- (void)showSimpleAlertTitle:(NSString *)title
                        body:(NSString *)body
                      cancel:(NSString *)cancel;


/**
 在当前 ViewController 内显示 MBProgressHUD，不会自己消失

 @param info 提示语
 @return MBProgressHUD
 */
- (MBProgressHUD *)showProgressHUD:(NSString *)info;

/**
 在当前 ViewController 内结束 MBProgressHUD

 @param hud 需要结束的MBProgressHUD
 */
- (void)hideProgressHUD:(MBProgressHUD *)hud;

/**
 获取 UIStoryboard

 @param name UIStoryboard 名称
 @return UIStoryboard
 */
- (UIStoryboard *)storyboardByMyName:(NSString *)name;

@end
