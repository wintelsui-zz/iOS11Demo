//
//  GoogLeNetPlacesOnVisionMethod.m
//  iOS11Demo
//
//  Created by wintel on 2017/11/29.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "GoogLeNetPlacesOnVisionMethod.h"

#import <CoreML/CoreML.h>
#import <Vision/Vision.h>

#import "GoogLeNetPlaces.h"
#import "UIImage+Extension.h"

@implementation GoogLeNetPlacesOnVisionMethod

+ (void)thinkOfImage:(UIImage *)image completion:(void (^)(NSString *info))completion{
    // 创建 CoreML model
    GoogLeNetPlaces *model = [[GoogLeNetPlaces alloc] init];
    
    // 创建 Vision model
    NSError *errorVison;
    VNCoreMLModel *vnmodel = [VNCoreMLModel modelForMLModel:model.model error:&errorVison];
    if (!errorVison) {
        // 创建处理 request Handler
        VNImageRequestHandler *vnhandler = [[VNImageRequestHandler alloc] initWithCGImage:image.CGImage options:@{}];
        
        // 创建一个带有 completion handler 的 Vision 请求
        VNCoreMLRequest *vnrequest = [[VNCoreMLRequest alloc] initWithModel:vnmodel completionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
            if (request.results)
            {
                VNClassificationObservation *firstResult = [request.results firstObject];
                NSString *label = firstResult.identifier;
                VNConfidence confidence = firstResult.confidence;
                
                NSString *info = [NSString stringWithFormat:@"%.2f%%可能是%@",confidence * 100,label];
                NSLog(@"info:%@",info);
                completion(info);
            }else{
                completion(nil);
            }
        }];
        
        // 发送识别请求
        NSError *vnerror;
        [vnhandler performRequests:@[vnrequest] error:&vnerror];
        if (vnerror) {
            NSLog(@"%@",vnerror.localizedDescription);
        }
    }else{
        completion(nil);
    }
}

@end
