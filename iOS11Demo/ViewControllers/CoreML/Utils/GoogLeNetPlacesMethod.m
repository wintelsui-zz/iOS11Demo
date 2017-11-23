//
//  GoogLeNetPlacesMethod.m
//  iOS11Demo
//
//  Created by wintel on 2017/11/23.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "GoogLeNetPlacesMethod.h"

#import "GoogLeNetPlaces.h"
#import "UIImage+Extension.h"

@implementation GoogLeNetPlacesMethod

+ (NSString *)thinkOfImage:(UIImage *)image{
    GoogLeNetPlaces *model = [[GoogLeNetPlaces alloc] init];
    NSError *error;
    //模型规定输入大小为224*224
    CVPixelBufferRef buffer = [[image scaleToSize:CGSizeMake(224, 224)] pixelBufferRef];
    GoogLeNetPlacesInput *input = [[GoogLeNetPlacesInput alloc] initWithSceneImage:buffer];
    GoogLeNetPlacesOutput *output = [model predictionFromFeatures:input error:&error];
    
    NSLog(@"%@",output.sceneLabelProbs);
    
    NSString *label = output.sceneLabel;
    if (label) {
        NSNumber *ratio = [output.sceneLabelProbs objectForKey:label];
        NSString *info = [NSString stringWithFormat:@"%.2f%%可能是%@",[ratio doubleValue] * 100,label];
        return info;
    }
    return nil;
}

@end
