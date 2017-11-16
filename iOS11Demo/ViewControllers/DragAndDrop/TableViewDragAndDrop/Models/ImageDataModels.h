//
//  ImageDataModels.h
//
//  Created by wintel sui on 2017/11/16
//  Copyright (c) 2017 Chinasofti. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ImageDataSourceTypeInApp,
    ImageDataSourceTypeAddition,
} ImageDataSourceType;

@interface ImageDataModels : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) ImageDataSourceType source;

+ (instancetype)modelObjectWithName:(NSString *)imageName source:(ImageDataSourceType)imageSource;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;


- (UIImage *)image;
+ (NSString *)saveFolderPath;
+ (NSString *)randomName;

@end
