//
//  UIImageFormDrawCanvas.m
//  doc360StudyCircles
//
//  Created by 隋文涛 on 15/12/18.
//  Copyright © 2015年 ids. All rights reserved.
//

#import "UIImageFormDrawCanvas.h"

@implementation UIImageFormDrawCanvas

//截屏
+ (UIImage *)imageFromView: (UIView *) theView
{
    // Draw a view’s contents into an image context
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    return [self imageWithImageSimple:theImage scaledToSize:CGSizeMake(theImage.size.width/2, theImage.size.height/2)];
}

//压缩图片
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    //End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

+ (UIImage *)imageWithFullColorInSize:(CGSize)size AndColor:(UIColor*)color{
    UIGraphicsBeginImageContextWithOptions(size, 0, 1.0);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

+ (UIImage *)UIImageCircleWithColor:(UIColor *) color AndlineWidth:(float) lineWidth InSize:(CGSize)size {
    float width = size.width - lineWidth * 2;
    float height = size.height - lineWidth * 2;
    float radius = width>height?(height/2.0):(width/2.0);
    
    
    UIGraphicsBeginImageContextWithOptions(size, 0, 1.0);
    
    if (lineWidth > 0) {
        UIBezierPath* bezierPath = UIBezierPath.bezierPath;
        [bezierPath moveToPoint: CGPointMake(radius + lineWidth, lineWidth)];
        [bezierPath addCurveToPoint: CGPointMake(lineWidth, radius + lineWidth) controlPoint1: CGPointMake(radius + lineWidth, lineWidth) controlPoint2: CGPointMake(lineWidth, lineWidth)];
        [bezierPath addCurveToPoint: CGPointMake(radius + lineWidth, height + lineWidth) controlPoint1: CGPointMake(lineWidth, height + lineWidth) controlPoint2: CGPointMake(radius, height)];
        [bezierPath addLineToPoint: CGPointMake((width - radius + lineWidth), height + lineWidth)];
        [bezierPath addCurveToPoint: CGPointMake(width + lineWidth, radius + lineWidth) controlPoint1: CGPointMake((width - radius + lineWidth), height + lineWidth) controlPoint2: CGPointMake(width + lineWidth, height + lineWidth)];
        [bezierPath addCurveToPoint: CGPointMake((width - radius + lineWidth), lineWidth) controlPoint1: CGPointMake(width + lineWidth, lineWidth) controlPoint2: CGPointMake((width - radius + lineWidth), lineWidth)];
        [bezierPath addLineToPoint: CGPointMake(radius + lineWidth, lineWidth)];
        
        [color setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
    }else{
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, size.width, size.height)];
        [color setFill];
        [ovalPath fill];
    }
    
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

//对图片进行裁剪(图片,起始点,大小)
+ (UIImage *)ImageCutterWithImage:(UIImage *)bigImage FromPoint:(CGPoint)point BySize:(CGSize)thesize{
    CGRect myImageRect = CGRectMake(point.x, point.y, thesize.width, thesize.height);
    
    CGImageRef imageRef = bigImage.CGImage;
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    
    
    CGSize size;
    
    size.width = 240;
    
    size.height = 180;
    
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, myImageRect, subImageRef);
    
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    
    UIGraphicsEndImageContext();
    
    
    return smallImage;
}

+ (UIImage *)UIImageAddImage:(UIImage *)image1 toImage:(UIImage *)image2 WithStartPoint:(CGPoint)statrpoint
{
    if (image2 == nil) {
        CGSize imageSize = image1.size;
        UIGraphicsBeginImageContextWithOptions(imageSize, 0, 1.0);
        [[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0] set];
        UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
        UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        image2 = pressedColorImg;
    }
    UIGraphicsBeginImageContext(image2.size);
    //Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    float X = 0;
    float Y = 0;
    
    //Draw image1
    [image1 drawInRect:CGRectMake(X, Y, image1.size.width, image1.size.height)];
    
    UIImage *resultImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

/**
 *  两张图片合并
 *
 *  @param image1 上层图片
 *  @param image2 下层图片
 *
 *  @return 合并后图片
 */
+ (UIImage *)UIImageAddImage:(UIImage *)image1 toImage:(UIImage *)image2 WithSize:(CGSize)size
{
    if (image2 == nil) {
        CGSize imageSize = size;
        UIGraphicsBeginImageContextWithOptions(imageSize, 0, 1.0);
        [[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] set];
        UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
        UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        image2 = pressedColorImg;
    }
    UIGraphicsBeginImageContext(image2.size);
    //Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    float X = 0;
    float Y = 0;
    
    if (image2.size.width != image1.size.width ||  image2.size.height != image1.size.height) {
        if (image2.size.width - image1.size.width > 0) {
            X = (image2.size.width - image1.size.width)/2.0;
        }
        
        if (image2.size.height - image1.size.height > 0) {
            Y = (image2.size.height - image1.size.height)/2.0;
        }
    }
    //Draw image1
    [image1 drawInRect:CGRectMake(X, Y, image1.size.width, image1.size.height)];
    
    UIImage *resultImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

+ (UIImage *)UIImageSetImage:(UIImage *)image withAlpha:(CGFloat)alpha{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -area.size.height);
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    CGContextSetAlpha(context, alpha);
    CGContextDrawImage(context, area, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+ (UIImage *)UIImageSetText:(NSString *)textContent Color:(UIColor *)textcolor Font:(UIFont *)textFont withAlpha:(CGFloat)alpha{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    //// Text Drawing
    CGRect textRect = CGRectMake(0, 0, 36, 36);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -textRect.size.height);
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    CGContextSetAlpha(context, alpha);
    {
        [textcolor setFill];
        CGFloat textTextHeight = [textContent sizeWithFont: textFont constrainedToSize: CGSizeMake(CGRectGetWidth(textRect), INFINITY) lineBreakMode:NSLineBreakByWordWrapping].height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, textRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (CGRectGetHeight(textRect) - textTextHeight) / 2, CGRectGetWidth(textRect), textTextHeight) withFont: textFont lineBreakMode:NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
        CGContextRestoreGState(context);
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//
//UIImage *image01 = [self UIImageChatBubbleForLeftWithColor:UIColor.whiteColor];
//_ImageView01.image = [image01 stretchableImageWithLeftCapWidth:20 topCapHeight:16];
+ (UIImage *)UIImageChatBubbleForLeftWithColor:(UIColor *)colorBubble{
    UIGraphicsBeginImageContextWithOptions((CGSize){43.0,33.0}, 0, 1.0);
    
    {
        //// General Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        //// Shadow Declarations
        NSShadow* shadow = [[NSShadow alloc] init];
        [shadow setShadowColor: UIColor.lightGrayColor];
        [shadow setShadowOffset: CGSizeMake(1, 1)];
        [shadow setShadowBlurRadius:2];
        
        //// Polygon Drawing
        UIBezierPath* polygonPath = [UIBezierPath bezierPath];
        [polygonPath moveToPoint: CGPointMake(1, 1)];
        [polygonPath addLineToPoint: CGPointMake(41, 1)];
        [polygonPath addLineToPoint: CGPointMake(41, 31)];
        [polygonPath addLineToPoint: CGPointMake(13, 31)];
        [polygonPath addLineToPoint: CGPointMake(13, 19)];
        [polygonPath closePath];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
        [colorBubble setFill];
        [polygonPath fill];
        CGContextRestoreGState(context);
    }
    
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

//UIImage *image02 = [self UIImageChatBubbleForRightWithColor:[UIColor colorWithRed:0.094 green:0.710 blue:0.173 alpha:1.000]];
//_ImageView02.image = [image02 stretchableImageWithLeftCapWidth:20 topCapHeight:16];
+ (UIImage *)UIImageChatBubbleForRightWithColor:(UIColor *)colorBubble{
    UIGraphicsBeginImageContextWithOptions((CGSize){43.0,33.0}, 0, 1.0);
    
    {
        //// General Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        //// Shadow Declarations
        NSShadow* shadow = [[NSShadow alloc] init];
        [shadow setShadowColor: UIColor.lightGrayColor];
        [shadow setShadowOffset: CGSizeMake(1, 1)];
        [shadow setShadowBlurRadius:2];
        
        //// Polygon Drawing
        UIBezierPath* polygonPath = [UIBezierPath bezierPath];
        [polygonPath moveToPoint: CGPointMake(1, 1)];
        [polygonPath addLineToPoint: CGPointMake(41, 1)];
        [polygonPath addLineToPoint: CGPointMake(28, 19)];
        [polygonPath addLineToPoint: CGPointMake(28, 31)];
        [polygonPath addLineToPoint: CGPointMake(1, 31)];
        [polygonPath closePath];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
        [colorBubble setFill];
        [polygonPath fill];
        CGContextRestoreGState(context);
    }
    
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

+ (UIImage *)UIImagedrawCanvasStarWithColor:(UIColor *)colorStar AndJustHalf:(BOOL) bHalf HalfColor:(UIColor *)colorhalfStar InWidth:(float)fwidth
{
    UIGraphicsBeginImageContextWithOptions((CGSize){fwidth,fwidth}, 0, 1.0);
    float flongneed = fwidth/45.0 * 1.0;
    //默认尺寸45;
    if (!bHalf) {
        UIBezierPath* starPath = [UIBezierPath bezierPath];
        [starPath moveToPoint: CGPointMake(22.5 * flongneed, 0)];
        [starPath addLineToPoint: CGPointMake(27.53 * flongneed, 15.58 * flongneed)];
        [starPath addLineToPoint: CGPointMake(43.9 * flongneed, 15.55 * flongneed)];
        [starPath addLineToPoint: CGPointMake(30.63 * flongneed, 25.14 * flongneed)];
        [starPath addLineToPoint: CGPointMake(35.73 * flongneed, 40.7 * flongneed)];
        [starPath addLineToPoint: CGPointMake(22.5 * flongneed, 31.05 * flongneed)];
        
        [starPath addLineToPoint: CGPointMake(9.27 * flongneed, 40.7 * flongneed)];
        [starPath addLineToPoint: CGPointMake(14.37 * flongneed, 25.14 * flongneed)];
        [starPath addLineToPoint: CGPointMake(1.1 * flongneed, 15.55 * flongneed)];
        [starPath addLineToPoint: CGPointMake(17.47 * flongneed, 15.58 * flongneed)];
        [starPath closePath];
        [colorStar setFill];
        [starPath fill];
    }else{
        UIBezierPath* starPath = [UIBezierPath bezierPath];
        [starPath moveToPoint: CGPointMake(22.5 * flongneed, 0)];
        [starPath addLineToPoint: CGPointMake(27.53 * flongneed, 15.58 * flongneed)];
        [starPath addLineToPoint: CGPointMake(43.9 * flongneed, 15.55 * flongneed)];
        [starPath addLineToPoint: CGPointMake(30.63 * flongneed, 25.14 * flongneed)];
        [starPath addLineToPoint: CGPointMake(35.73 * flongneed, 40.7 * flongneed)];
        [starPath addLineToPoint: CGPointMake(22.5 * flongneed, 31.05 * flongneed)];
        [starPath closePath];
        [colorhalfStar setFill];
        [starPath fill];
        
        UIBezierPath* starPath2 = [UIBezierPath bezierPath];
        [starPath2 moveToPoint: CGPointMake(22.5 * flongneed, 31.05 * flongneed)];
        [starPath2 addLineToPoint: CGPointMake(9.27 * flongneed, 40.7 * flongneed)];
        [starPath2 addLineToPoint: CGPointMake(14.37 * flongneed, 25.14 * flongneed)];
        [starPath2 addLineToPoint: CGPointMake(1.1 * flongneed, 15.55 * flongneed)];
        [starPath2 addLineToPoint: CGPointMake(17.47 * flongneed, 15.58 * flongneed)];
        [starPath2 addLineToPoint: CGPointMake(22.5 * flongneed, 0)];
        [starPath2 closePath];
        [colorStar setFill];
        [starPath2 fill];
    }
    
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

+ (UIImage *)UIImagedrawCanvasTextCurveBGWithColor:(UIColor *)color height:(CGFloat)heightX1{
    CGFloat height = heightX1 * [[UIScreen mainScreen] scale];
//    CGFloat height = heightX1;
    //float widyhMin = height * 2;
    float space = 10;
    float radius = height/2.0;
    
    UIGraphicsBeginImageContextWithOptions((CGSize){height * 2 + space,height}, 0, 1);
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0, 0)];
    [bezierPath addCurveToPoint: CGPointMake(radius, radius) controlPoint1: CGPointMake(0, 0) controlPoint2: CGPointMake(radius, 0)];
    [bezierPath addCurveToPoint: CGPointMake(radius * 2, radius * 2) controlPoint1: CGPointMake(radius, radius * 2) controlPoint2: CGPointMake(radius * 2, radius * 2)];
    [bezierPath addLineToPoint: CGPointMake(radius * 2 + space, radius * 2)];
    [bezierPath addCurveToPoint: CGPointMake(radius * 3 + space, radius) controlPoint1: CGPointMake(radius * 2 + space, radius * 2) controlPoint2: CGPointMake(radius * 3 + space, radius * 2)];
    [bezierPath addCurveToPoint: CGPointMake(radius * 4 + space, 0) controlPoint1: CGPointMake(radius * 3 + space, 0) controlPoint2: CGPointMake(radius * 4 + space, 0)];
    [bezierPath addLineToPoint: CGPointMake(0, 0)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
   
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
//    return pressedColorImg;
    
    NSData *imageData = UIImagePNGRepresentation(pressedColorImg);
    UIImage *pressedColor = [UIImage imageWithData:imageData scale:[[UIScreen mainScreen] scale]];
    
    return pressedColor;
}

@end
