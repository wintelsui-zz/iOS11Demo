//
//  ImageDataModels.m
//
//  Created by wintel sui on 2017/11/16
//  Copyright (c) 2017 Chinasofti. All rights reserved.
//

#import "ImageDataModels.h"


NSString *const kImageDataModelsName = @"name";
NSString *const kImageDataModelsSource = @"source";


@interface ImageDataModels ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ImageDataModels

@synthesize name = _name;
@synthesize source = _source;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

+ (instancetype)modelObjectWithName:(NSString *)imageName source:(ImageDataSourceType)imageSource{
    ImageDataModels *imageData = [[self alloc] init];
    imageData.name = imageName;
    imageData.source = imageSource;
    return imageData;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.name = [self objectOrNilForKey:kImageDataModelsName fromDictionary:dict];
            self.source = [[self objectOrNilForKey:kImageDataModelsSource fromDictionary:dict] integerValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kImageDataModelsName];
    [mutableDict setValue:[NSNumber numberWithInteger:self.source] forKey:kImageDataModelsSource];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.name = [aDecoder decodeObjectForKey:kImageDataModelsName];
    self.source = [aDecoder decodeIntegerForKey:kImageDataModelsSource];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kImageDataModelsName];
    [aCoder encodeInteger:_source forKey:kImageDataModelsSource];
}

- (id)copyWithZone:(NSZone *)zone
{
    ImageDataModels *copy = [[ImageDataModels alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.source = self.source;
    }
    
    return copy;
}

- (UIImage *)image{
    if (self.source == ImageDataSourceTypeInApp) {
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.name ofType:@""]];
        return image;
    }else if (self.source == ImageDataSourceTypeInApp) {
        
    }
    return nil;
}

+ (NSString *)saveFolderPath{
    
    return @"";
}

+ (NSString *)randomName{
    
    return @"";
}

@end
