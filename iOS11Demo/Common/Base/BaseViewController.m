//
//  BaseViewController.m
//  LilysFriends
//
//  Created by wintel on 17/2/8.
//  Copyright © 2017年 wintelsui. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    
}
@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self navigationBarTitleColor];
    [self navigationBarBackgroundImage];
    [self.view setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:255.0/255.0]];
}

- (void)navigationBarTitleColor{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f],NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)navigationBarBackgroundImage{
//    UIImage *image = [UIImageFormDrawCanvas imageWithFullColorInSize:CGSizeMake(APP_SCREEN_WIDTH, 64) AndColor:lastNavigationBarColor];
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)setNavLeftButtonWithImageName:(NSString *)imageName title:(NSString *)title normalColor:(UIColor *)normalColor{
    UIView *viewbuttonLeftTemp = [[UIView alloc] init];
    [viewbuttonLeftTemp setBackgroundColor:[UIColor clearColor]];
    
    UIButton *buttonTemp = [UIButton buttonWithType:UIButtonTypeCustom];
    BOOL hasImage = NO;
    if ((imageName != nil && imageName.length > 0)) {
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            hasImage = YES;
        }
    }
    if ((title== nil || title.length == 0) && !hasImage) {
        return;
    }
    if ((hasImage && (title== nil || title.length == 0)) || (!hasImage && (title != nil && title.length > 0))) {
        if (hasImage) {
            [buttonTemp setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        }else{
            [buttonTemp setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        }
    }else{
        [buttonTemp setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    }
    CGSize imageSize = CGSizeZero;
    if (hasImage) {
        UIImage *image = [UIImage imageNamed:imageName];
        if (image.size.height > 44) {
            imageSize = CGSizeMake((image.size.width * 44 * 1.0)/image.size.height, 44);
        }else{
            imageSize = image.size;
        }
        [buttonTemp setImage:image forState:UIControlStateNormal];
    }
    
    CGSize titleSize = CGSizeZero;
    if (title != nil && title.length > 0) {
        titleSize = [PublicClass getLabelWithSize:title width:120 font:[UIFont systemFontOfSize:16.0f] limit:CGSizeMake(0, 120)];
        [buttonTemp setTitle:title forState:UIControlStateNormal];
        [buttonTemp.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        if (normalColor) {
            [buttonTemp setTitleColor:normalColor forState:UIControlStateNormal];
        }
    }
    float width = 0;
    float heigth = 44;
    if (imageSize.width > 0) {
        width = imageSize.width + 10;
    }
    if (titleSize.width > 0) {
        width += (titleSize.width + 10);
    }
    if (width < 44) {
        width = 44;
    }
    [viewbuttonLeftTemp setFrame:CGRectMake(0, 0, width, heigth)];
    [buttonTemp setFrame:CGRectMake(-6, 0, width+6, heigth)];
    [buttonTemp setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 6)];
    
    [viewbuttonLeftTemp addSubview:buttonTemp];
    
    viewbuttonLeft = viewbuttonLeftTemp;
    buttonLeft = buttonTemp;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:viewbuttonLeft];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    [buttonLeft addTarget:self action:@selector(pressedLeftButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setNavRightButtonWithImageName:(NSString *)imageName title:(NSString *)title normalColor:(UIColor *)normalColor{
    UIView *viewbuttonRightTemp = [[UIView alloc] init];
    [viewbuttonRightTemp setBackgroundColor:[UIColor clearColor]];
    
    UIButton *buttonTemp = [UIButton buttonWithType:UIButtonTypeCustom];
    BOOL hasImage = NO;
    if ((imageName != nil && imageName.length > 0)) {
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            hasImage = YES;
        }
    }
    if ((title== nil || title.length == 0) && !hasImage) {
        return;
    }
    if ((hasImage && (title== nil || title.length == 0)) || (!hasImage && (title != nil && title.length > 0))) {
        //只有一个
        if (hasImage) {
            [buttonTemp setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        }else{
            [buttonTemp setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        }
    }else{
        [buttonTemp setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
    CGSize imageSize = CGSizeZero;
    if (hasImage) {
        UIImage *image = [UIImage imageNamed:imageName];
        if (image.size.height > 44) {
            imageSize = CGSizeMake((image.size.width * 44 * 1.0)/image.size.height, 44);
        }else{
            imageSize = image.size;
        }
        [buttonTemp setImage:image forState:UIControlStateNormal];
    }
    CGSize titleSize = CGSizeZero;
    if (title != nil && title.length > 0) {
        titleSize = [PublicClass getLabelWithSize:title width:120 font:[UIFont systemFontOfSize:16.0f] limit:CGSizeMake(0, 120)];
        [buttonTemp setTitle:title forState:UIControlStateNormal];
        [buttonTemp.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [buttonTemp setTitleColor:normalColor forState:UIControlStateNormal];
    }
    float width = 0;
    float heigth = 44;
    if (imageSize.width > 0) {
        width = imageSize.width + 10;
    }
    if (titleSize.width > 0) {
        width += (titleSize.width + 10);
    }
    if (width < 44) {
        width = 44;
    }
    
    [viewbuttonRightTemp setFrame:CGRectMake(0, 0, width, heigth)];
    [buttonTemp setFrame:CGRectMake(0, 0, width+6, heigth)];
    [buttonTemp setContentEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    
    [viewbuttonRightTemp addSubview:buttonTemp];
    
    viewbuttonRight = viewbuttonRightTemp;
    
    buttonRight = buttonTemp;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:viewbuttonRight];
    [self.navigationItem setRightBarButtonItem:backItem];
    
    [buttonRight addTarget:self action:@selector(pressedRightButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setNavMiddleButtonWithImageName:(NSString *)imageName title:(NSString *)title normalColor:(UIColor *)normalColor{
    UIView *viewbuttonMiddleTemp = [[UIView alloc] init];
    [viewbuttonMiddleTemp setBackgroundColor:[UIColor clearColor]];
    
    UIButton *buttonTemp = [UIButton buttonWithType:UIButtonTypeCustom];
    BOOL hasImage = NO;
    if ((imageName != nil && imageName.length > 0)) {
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            hasImage = YES;
        }
    }
    if ((title== nil || title.length == 0) && !hasImage) {
        return;
    }
    
    [buttonTemp setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    
    CGSize imageSize = CGSizeZero;
    if (hasImage) {
        UIImage *image = [UIImage imageNamed:imageName];
        if (image.size.height > 44) {
            imageSize = CGSizeMake((image.size.width * 44 * 1.0)/image.size.height, 44);
        }else{
            imageSize = image.size;
        }
        [buttonTemp setImage:image forState:UIControlStateNormal];
    }
    float titleWidthMax = 200 - (imageSize.width > 0 ? (imageSize.width + 10) : 0);
    CGSize titleSize = CGSizeZero;
    if (title != nil && title.length > 0) {
        titleSize = [PublicClass getLabelWithSize:title width:titleWidthMax font:[UIFont systemFontOfSize:16.0f] limit:CGSizeMake(0, 44)];
        [buttonTemp setTitle:title forState:UIControlStateNormal];
        [buttonTemp.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [buttonTemp setTitleColor:normalColor forState:UIControlStateNormal];
    }
    float width = 0;
    float heigth = 44;
    if (imageSize.width > 0) {
        width = imageSize.width + 10;
    }
    if (titleSize.width > 0) {
        width += (titleSize.width + 10);
    }
    if (width < 44) {
        width = 44;
    }
    
    [viewbuttonMiddleTemp setFrame:CGRectMake(0, 0, width, heigth)];
    [buttonTemp setFrame:CGRectMake(0, 0, width, heigth)];
    
    [viewbuttonMiddleTemp addSubview:buttonTemp];
    
    viewbuttonMiddle = viewbuttonMiddleTemp;
    
    buttonMiddle = buttonTemp;
    [self.navigationItem setTitleView:viewbuttonMiddle];
    
    [buttonMiddle addTarget:self action:@selector(pressedMiddleButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pressedLeftButton{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pressedRightButton{
    
}

- (void)pressedMiddleButton{
    
}



- (BOOL)isEnableSlideToBack{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
