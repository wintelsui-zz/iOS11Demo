//
//  iOS11DemoActionsAndVCManager.h
//  iOS11Demo
//
//  Created by wintel on 2017/11/6.
//Copyright © 2017年 wintel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iOS11ActionsListModels.h"

#define iOS11ActionsAndVCManagerInstance [iOS11DemoActionsAndVCManager sharedManager]

#define iOS11DemoAppActionsList [[iOS11DemoActionsAndVCManager sharedManager] modelObjectsForActionsList]
#define iOS11DemoAppVCsList     [[iOS11DemoActionsAndVCManager sharedManager] modelObjectsForViewControllersList]

@interface iOS11DemoActionsAndVCManager : NSObject

+ (instancetype)sharedManager;

/**
 获取功能列表
 
 @return 功能列表
 */
- (NSArray *)modelObjectsForActionsList;

/**
 获取配置中的 ViewController 信息字典
 
 @return 配置中的 ViewController 信息字典
 */
- (NSDictionary *)modelObjectsForViewControllersList;

@end
