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

@end
