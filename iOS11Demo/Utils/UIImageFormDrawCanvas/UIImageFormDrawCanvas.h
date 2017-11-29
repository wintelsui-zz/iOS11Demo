//
//  UIImageFormDrawCanvas.h
//  doc360StudyCircles
//
//  Created by 隋文涛 on 15/12/18.
//  Copyright © 2015年 ids. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImageFormDrawCanvas : NSObject
/**
 获取View截图

 @param theView 目标View
 @return View截图
 */
+ (UIImage *)imageFromView: (UIView *) theView;

+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

/**
 *  为图片设置透明度
 *
 *  @param image 原始图片
 *  @param alpha 透明度
 *
 *  @return 透明图片
 */
+ (UIImage *)UIImageSetImage:(UIImage *)image withAlpha:(CGFloat)alpha;

+ (UIImage *)ImageCutterWithImage:(UIImage *)bigImage FromPoint:(CGPoint)point BySize:(CGSize)thesize;
/**
 *  创建一张图片
 *
 *  @param size 尺寸
 *  @param color 颜色
 *
 *  @return 创建一张图片
 */
+ (UIImage *)imageWithFullColorInSize:(CGSize)size AndColor:(UIColor*)color;

/**
 *  创建一张图片(一个空心圈)
 *
 *  @param color 颜色
 *  @param lineWidth 线宽
 *  @param size 尺寸
 *
 *  @return 图片
 */
+ (UIImage *)UIImageCircleWithColor:(UIColor *) color AndlineWidth:(float) lineWidth InSize:(CGSize)size;

+ (UIImage *)UIImageAddImage:(UIImage *)image1 toImage:(UIImage *)image2 WithStartPoint:(CGPoint)statrpoint;

+ (UIImage *)UIImageAddImage:(UIImage *)image1 toImage:(UIImage *)image2 WithSize:(CGSize)size;

+ (UIImage *)UIImageChatBubbleForLeftWithColor:(UIColor *)colorBubble;

+ (UIImage *)UIImageChatBubbleForRightWithColor:(UIColor *)colorBubble;

/**
 *  画一个五角星
 *
 *  @param colorStar     五角星颜色
 *  @param bHalf         是否要分半
 *  @param colorhalfStar 分半后另一半颜色
 *  @param fwidth        星星大小(方形)
 *
 *  @return 五角星纯色图片
 */
+ (UIImage *)UIImagedrawCanvasStarWithColor:(UIColor *)colorStar AndJustHalf:(BOOL) bHalf HalfColor:(UIColor *)colorhalfStar InWidth:(float)fwidth;


+ (UIImage *)UIImagedrawCanvasTextCurveBGWithColor:(UIColor *)color height:(CGFloat)heightX1;
@end
