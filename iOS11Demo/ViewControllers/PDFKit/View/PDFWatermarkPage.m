//
//  PDFWatermarkPage.m
//  iOS11Demo
//
//  Created by wintel on 2017/10/16.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "PDFWatermarkPage.h"

@implementation PDFWatermarkPage

- (void)drawWithBox:(PDFDisplayBox)box toContext:(CGContextRef)context{
    [super drawWithBox:box toContext:context];
    
    UIGraphicsPushContext(context);
    CGContextSaveGState(context);
    
    CGRect pageBounds = [self boundsForBox:box];
    
    CGContextTranslateCTM(context, 0.0, pageBounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, M_PI_4);
    NSString *info = @"RCS WATER MARK";
    NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle alloc] init];
    textStyle.alignment = NSTextAlignmentLeft;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 64.0],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5],
                                 NSParagraphStyleAttributeName: textStyle};

    [info drawAtPoint:CGPointMake(255, 40) withAttributes:attributes];
    
    CGContextRestoreGState(context);
    UIGraphicsPopContext();
}


@end
