//
//  iOS11ActionsListModels.h
//
//  Created by Sui Wintel on 2017/10/22
//  Copyright (c) 2017 360doc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    iOS11DemoActionStatusNotStarted = 0,
    iOS11DemoActionStatusDeveloped,
    iOS11DemoActionStatusDeveloping,
} iOS11DemoActionStatus;


@interface iOS11ActionsListModels : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString  *storyboard;
@property (nonatomic, strong) NSString  *storyboardid;
@property (nonatomic, strong) NSString  *key;
@property (nonatomic, strong) NSString  *className;
@property (nonatomic, strong) NSString  *name;
@property (nonatomic, assign) NSInteger status;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

+ (NSArray *)modelObjectsForActionsList;

@end
