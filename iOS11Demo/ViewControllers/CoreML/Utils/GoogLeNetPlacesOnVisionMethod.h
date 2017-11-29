//
//  GoogLeNetPlacesOnVisionMethod.h
//  iOS11Demo
//
//  Created by wintel on 2017/11/29.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoogLeNetPlacesOnVisionMethod : NSObject

+ (void)thinkOfImage:(UIImage *)image completion:(void (^)(NSString *info))completion;

@end
