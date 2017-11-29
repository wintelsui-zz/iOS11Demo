//
//  PublicClass.h
//  LilysFriends
//
//  Created by wintel on 17/2/9.
//  Copyright © 2017年 wintelsui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicClass : NSObject


/**
 计算字符串需要空间

 @param string 字符串
 @param width 最大宽度
 @param font 字体
 @param limitSize 限制高度 最大值 最小值
 @return 字符串空间
 */
+ (CGSize)getLabelWithSize:(NSString*)string width:(CGFloat)width font:(UIFont *)font limit:(CGSize)limitSize;

//+ (void)showMessage:(NSString *)messgae travel:(CGFloat)travel;

+ (void)TableViewsetExtraCellLineHidden:(UITableView *)tableView;

//+ (NSInteger)connectedToNetwork;


//+ (BOOL)predictReviewPassed;


@end
