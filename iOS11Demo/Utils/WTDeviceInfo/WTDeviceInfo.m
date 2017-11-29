//
//  WTDeviceInfo.m
//  wintel
//
//  Created by wintel on 2017/9/13.
//  Copyright © 2017年 wintelsui. All rights reserved.
//

#import "WTDeviceInfo.h"

#import <sys/utsname.h>

@implementation WTDeviceInfo

+ (NSString *)devicMachineCode
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    return code;
}


+ (NSString *)getLocalDisPlayLanguagesEnOrZh{
    NSArray *languages = [NSLocale preferredLanguages];
    NSLog(@"LANG:%@",languages);
    if (languages != nil && [languages count]) {
        id first = [languages objectAtIndex:0];
        if ([first isKindOfClass:[NSString class]]) {
            if ([first hasPrefix:@"en"]) {
                return @"en";
            }
        }
    }
    return @"zh";
}

+ (BOOL)getLocalIsEnLanguageDisPlay{
    NSString *lang = [WTDeviceInfo getLocalDisPlayLanguagesEnOrZh];
    if ([lang isEqualToString:@"en"]) {
        return YES;
    }
    return NO;
}


+ (NSString *)appCFBundleVersion{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentBuild = [infoDict objectForKey:@"CFBundleVersion"];
    return (currentBuild == nil)?@"":currentBuild;
}

+ (NSString *)appCFBundleShortVersionString{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    return (currentVersion == nil)?@"":currentVersion;
}


@end
