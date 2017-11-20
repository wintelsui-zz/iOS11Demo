//
//  UIColor+Extension.m
//  iOS11Demo
//
//  Created by wintel on 2017/11/20.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)randomColor{
    CGFloat red   = (arc4random() % 256) / 256.0;
    CGFloat green = (arc4random() % 256) / 256.0;
    CGFloat blue  = (arc4random() % 256) / 256.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}


@end
