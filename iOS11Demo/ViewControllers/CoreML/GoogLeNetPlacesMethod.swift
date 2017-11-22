//
//  GoogLeNetPlacesMethod.swift
//  iOS11Demo
//
//  Created by 隋文涛 on 2017/11/22.
//  Copyright © 2017年 wintel. All rights reserved.
//

import UIKit

public class GoogLeNetPlacesMethod {
    
    func thinkOf(Image image : UIImage) -> NSString? {
        var model = GoogLeNetPlaces()
        
        return ""
    }
    
}


//extension UIImage {
//    func pixelBufferFrom(Image image : UIImage ) -> CVPixelBufferRef {
//        
//    }
//}


/**
 
 GoogLeNetPlaces *model = [[GoogLeNetPlaces alloc] init];
 NSError *error;
 UIImage *scaledImage = [image scaleToSize:CGSizeMake(224, 224)];
 CVPixelBufferRef buffer = [image pixelBufferFromCGImage:scaledImage];
 GoogLeNetPlacesInput *input = [[GoogLeNetPlacesInput alloc] initWithSceneImage:buffer];
 GoogLeNetPlacesOutput *output = [model predictionFromFeatures:input error:&error];
 return output.sceneLabel;
 
 
 //
 //  UIImage+Utils.m
 //  CoreMLDemo
 //
 //  Created by chenyi on 08/06/2017.
 //  Copyright © 2017 chenyi. All rights reserved.
 //
 
 #import "UIImage+Utils.h"
 
 @implementation UIImage (Utils)
 
 - (UIImage *)scaleToSize:(CGSize)size {
 UIGraphicsBeginImageContext(size);
 [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
 UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 return scaledImage;
 }
 
 - (CVPixelBufferRef)pixelBufferFromCGImage:(UIImage *)originImage {
 CGImageRef image = originImage.CGImage;
 NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
 [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
 [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey,
 nil];
 
 CVPixelBufferRef pxbuffer = NULL;
 
 CGFloat frameWidth = CGImageGetWidth(image);
 CGFloat frameHeight = CGImageGetHeight(image);
 
 CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
 frameWidth,
 frameHeight,
 kCVPixelFormatType_32ARGB,
 (__bridge CFDictionaryRef) options,
 &pxbuffer);
 
 NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
 
 CVPixelBufferLockBaseAddress(pxbuffer, 0);
 void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
 NSParameterAssert(pxdata != NULL);
 
 CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
 
 CGContextRef context = CGBitmapContextCreate(pxdata,
 frameWidth,
 frameHeight,
 8,
 CVPixelBufferGetBytesPerRow(pxbuffer),
 rgbColorSpace,
 (CGBitmapInfo)kCGImageAlphaNoneSkipFirst);
 NSParameterAssert(context);
 CGContextConcatCTM(context, CGAffineTransformIdentity);
 CGContextDrawImage(context, CGRectMake(0,
 0,
 frameWidth,
 frameHeight),
 image);
 CGColorSpaceRelease(rgbColorSpace);
 CGContextRelease(context);
 
 CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
 
 return pxbuffer;
 }
 
 @end
 
 **/
