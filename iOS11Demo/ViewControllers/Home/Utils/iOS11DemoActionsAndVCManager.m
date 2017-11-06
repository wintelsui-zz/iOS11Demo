//
//  iOS11DemoActionsAndVCManager.m
//  iOS11Demo
//
//  Created by wintel on 2017/11/6.
//Copyright © 2017年 wintel. All rights reserved.
//

#import "iOS11DemoActionsAndVCManager.h"

static iOS11DemoActionsAndVCManager * _instance;

@interface iOS11DemoActionsAndVCManager ()
{
    NSArray *_actions;
    NSDictionary *_viewControllers;
}
@end

@implementation iOS11DemoActionsAndVCManager

+ (instancetype)sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _instance = [[[self class] alloc] init];
        
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}


- (NSArray *)modelObjectsForActionsList{
    if (_actions == nil) {
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
        _actions = actionsMulti;
    }
    if (_actions == nil) {
        _actions = @[];
    }
    return _actions;
}

- (NSDictionary *)modelObjectsForViewControllersList{
    if (_viewControllers == nil) {
        NSString *actionsPath = [[NSBundle mainBundle] pathForResource:@"viewControllersList" ofType:@"plist"];
        NSDictionary *actions = [[NSDictionary alloc] initWithContentsOfFile:actionsPath];
        NSMutableDictionary *actionsMulti = [[NSMutableDictionary alloc] init];
        for (NSDictionary *action in [actions allValues]) {
            iOS11ActionsListModels *actionModel = [iOS11ActionsListModels modelObjectWithDictionary:action];
            if (actionModel) {
                NSInteger pageStatus    = actionModel.status;
                if (pageStatus != iOS11DemoActionStatusNotStarted) {
                    NSString *key = actionModel.key;
                    [actionsMulti setObject:actionModel forKey:key];
                }
            }
        }
        _viewControllers = actionsMulti;
    }
    if (_viewControllers == nil) {
        _viewControllers = @{};
    }
    return _viewControllers;
}

@end
