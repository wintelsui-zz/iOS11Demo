//
//  UIImage+Extension.h
//  iOS11Demo
//
//  Created by wintel on 2017/11/23.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

- (UIImage *)scaleToSize:(CGSize)size;

- (CVPixelBufferRef)pixelBufferRef;

@end
