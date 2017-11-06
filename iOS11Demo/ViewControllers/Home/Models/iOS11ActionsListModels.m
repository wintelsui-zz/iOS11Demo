//
//  iOS11ActionsListModels.m
//
//  Created by Sui Wintel on 2017/10/22
//  Copyright (c) 2017 360doc. All rights reserved.
//

#import "iOS11ActionsListModels.h"


NSString *const kiOS11ActionsListModelsStoryboard = @"storyboard";
NSString *const kiOS11ActionsListModelsStoryboardid = @"storyboardid";
NSString *const kiOS11ActionsListModelsKey = @"key";
NSString *const kiOS11ActionsListModelsClass = @"class";
NSString *const kiOS11ActionsListModelsName = @"name";
NSString *const kiOS11ActionsListModelsStatus = @"status";


@interface iOS11ActionsListModels ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation iOS11ActionsListModels

@synthesize storyboard   = _storyboard;
@synthesize storyboardid = _storyboardid;
@synthesize key          = _key;
@synthesize className    = _className;
@synthesize name         = _name;
@synthesize status       = _status;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.storyboard = [self objectOrNilForKey:kiOS11ActionsListModelsStoryboard fromDictionary:dict];
            self.storyboardid = [self objectOrNilForKey:kiOS11ActionsListModelsStoryboardid fromDictionary:dict];
            self.key = [self objectOrNilForKey:kiOS11ActionsListModelsKey fromDictionary:dict];
            self.className = [self objectOrNilForKey:kiOS11ActionsListModelsClass fromDictionary:dict];
            self.name = [self objectOrNilForKey:kiOS11ActionsListModelsName fromDictionary:dict];
            self.status = [[self objectOrNilForKey:kiOS11ActionsListModelsStatus fromDictionary:dict] integerValue];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.storyboard forKey:kiOS11ActionsListModelsStoryboard];
    [mutableDict setValue:self.storyboardid forKey:kiOS11ActionsListModelsStoryboardid];
    [mutableDict setValue:self.key forKey:kiOS11ActionsListModelsKey];
    [mutableDict setValue:self.className forKey:kiOS11ActionsListModelsClass];
    [mutableDict setValue:self.name forKey:kiOS11ActionsListModelsName];
    [mutableDict setValue:@(self.status) forKey:kiOS11ActionsListModelsStatus];
    
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

    self.storyboard = [aDecoder decodeObjectForKey:kiOS11ActionsListModelsStoryboard];
    self.storyboardid = [aDecoder decodeObjectForKey:kiOS11ActionsListModelsStoryboardid];
    self.key = [aDecoder decodeObjectForKey:kiOS11ActionsListModelsKey];
    self.className = [aDecoder decodeObjectForKey:kiOS11ActionsListModelsClass];
    self.name = [aDecoder decodeObjectForKey:kiOS11ActionsListModelsName];
    self.status = [[aDecoder decodeObjectForKey:kiOS11ActionsListModelsStatus] integerValue];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_storyboard forKey:kiOS11ActionsListModelsStoryboard];
    [aCoder encodeObject:_storyboardid forKey:kiOS11ActionsListModelsStoryboardid];
    [aCoder encodeObject:_key forKey:kiOS11ActionsListModelsKey];
    [aCoder encodeObject:_className forKey:kiOS11ActionsListModelsClass];
    [aCoder encodeObject:_name forKey:kiOS11ActionsListModelsName];
    [aCoder encodeObject:@(_status) forKey:kiOS11ActionsListModelsStatus];
    
}

- (id)copyWithZone:(NSZone *)zone
{
    iOS11ActionsListModels *copy = [[iOS11ActionsListModels alloc] init];
    
    if (copy) {

        copy.storyboard = [self.storyboard copyWithZone:zone];
        copy.storyboardid = [self.storyboardid copyWithZone:zone];
        copy.key = [self.key copyWithZone:zone];
        copy.className = [self.className copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}

+ (NSArray *)modelObjectsForActionsList{
    NSString *actionsPath = [[NSBundle mainBundle] pathForResource:@"actionsList" ofType:@"plist"];
    NSArray *actions = [[NSArray alloc] initWithContentsOfFile:actionsPath];
    NSMutableArray *actionsMulti = [[NSMutableArray alloc] init];
    for (NSDictionary *action in actions) {
        iOS11ActionsListModels *actionModel = [iOS11ActionsListModels modelObjectWithDictionary:action];
        if (actionModel) {
            NSInteger pageStatus    = actionModel.status;
            if (pageStatus != iOS11DemoActionStatusNotStarted) {
                [actionsMulti addObject:actionModel];
            }
        }
    }
    return actionsMulti;
}
@end
