//
//  MessageFilterExtension.m
//  MessageFilterE
//
//  Created by wintel on 2017/10/17.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "MessageFilterExtension.h"
#import "iOS11DemoPublicString.h"


@interface MessageFilterExtension () <ILMessageFilterQueryHandling>
@end

@implementation MessageFilterExtension

#pragma mark - ILMessageFilterQueryHandling

- (void)handleQueryRequest:(ILMessageFilterQueryRequest *)queryRequest context:(ILMessageFilterExtensionContext *)context completion:(void (^)(ILMessageFilterQueryResponse *))completion {
    // First, check whether to filter using offline data (if possible).
    // 首先检查本地号码标记是否存在
    // 如果不存在，离线返回（ILMessageFilterActionNone）则发起远程
    
    ILMessageFilterAction offlineAction = [self offlineActionForQueryRequest:queryRequest];
    
    switch (offlineAction) {
        case ILMessageFilterActionAllow:
        case ILMessageFilterActionFilter: {
            // Based on offline data, we know this message should either be Allowed or Filtered. Send response immediately.
            ILMessageFilterQueryResponse *response = [[ILMessageFilterQueryResponse alloc] init];
            response.action = offlineAction;
            
            completion(response);
            break;
        }
            
        case ILMessageFilterActionNone: {
            // Based on offline data, we do not know whether this message should be Allowed or Filtered. Defer to network.
            // Note: Deferring requests to network requires the extension target's Info.plist to contain a key with a URL to use. See documentation for details.
            [context deferQueryRequestToNetworkWithCompletion:^(ILNetworkResponse *_Nullable networkResponse, NSError *_Nullable error) {
                ILMessageFilterQueryResponse *response = [[ILMessageFilterQueryResponse alloc] init];
                response.action = ILMessageFilterActionNone;
                
                if (networkResponse) {
                    // If we received a network response, parse it to determine an action to return in our response.
                    response.action = [self actionForNetworkResponse:networkResponse];
                } else {
                    NSLog(@"Error deferring query request to network: %@", error);
                }
                
                completion(response);
            }];
            break;
        }
    }
}

- (ILMessageFilterAction)offlineActionForQueryRequest:(ILMessageFilterQueryRequest *)queryRequest {
    // Replace with logic to perform offline check whether to filter first (if possible).
    // 离线判断号码
    NSString *redgroupBundleIdentifier = [self groupBundleIdentifier];
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:redgroupBundleIdentifier];
    NSString *number = [userDefault stringForKey:NumberKey];
    if (number) {
        NSString *sender = queryRequest.sender;
        NSString *messageBody = queryRequest.messageBody;
        //比较发送者是否是本地存储的号码，如果是则返回过滤
        if (sender && [sender hasSuffix:number]) {
            //sender中会有+86
            NSLog(@"messageBody:%@",messageBody);
            return ILMessageFilterActionFilter;
        }
    }
    return ILMessageFilterActionNone;
}

- (ILMessageFilterAction)actionForNetworkResponse:(ILNetworkResponse *)networkResponse {
    // Replace with logic to parse the HTTP response and data payload of `networkResponse` to return an action.
    // 远程判断号码
    return ILMessageFilterActionNone;
}

- (NSString *)groupBundleIdentifier{
    NSDictionary *dictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier = [dictionary objectForKey:@"CFBundleIdentifier"];
    NSString *bundleName = [dictionary objectForKey:@"CFBundleName"];
    if (bundleIdentifier && bundleName.length > 0) {
        if (bundleName && bundleName.length > 0) {
            NSString *bundleNameRange = [@"." stringByAppendingString:bundleName];
            if ([bundleIdentifier hasSuffix:bundleNameRange]) {
                NSString *hostBundleIdentifier = [bundleIdentifier substringToIndex:(bundleIdentifier.length - bundleNameRange.length)];
                if (hostBundleIdentifier) {
                    NSString *groupBundleIdentifier = [@"group." stringByAppendingString:hostBundleIdentifier];
                    return groupBundleIdentifier;
                }
            }
        }
    }
    
    return @"";
}

@end
