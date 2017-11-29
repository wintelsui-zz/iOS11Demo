//
//  BaseViewController.h
//  LilysFriends
//
//  Created by wintel on 17/2/8.
//  Copyright © 2017年 wintelsui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface BaseViewController : UIViewController
{
    UIButton *buttonLeft;
    UIButton *buttonRight;
    UIView *viewbuttonLeft;
    UIView *viewbuttonRight;
    
    UIButton *buttonMiddle;
    UIView *viewbuttonMiddle;
}

- (void)setNavLeftButtonWithImageName:(NSString *)imageName title:(NSString *)title normalColor:(UIColor *)normalColor;
- (void)setNavRightButtonWithImageName:(NSString *)imageName title:(NSString *)title normalColor:(UIColor *)normalColor;
- (void)setNavMiddleButtonWithImageName:(NSString *)imageName title:(NSString *)title normalColor:(UIColor *)normalColor;

- (void)pressedLeftButton;
- (void)pressedRightButton;
- (void)pressedMiddleButton;


/**
 *  @author wintelsui
 *
 *  @brief  是否希望页面支持侧滑返回,默认为Yes
 *
 *  @return 是否支持侧滑返回
 */
- (BOOL)isEnableSlideToBack;

@end
