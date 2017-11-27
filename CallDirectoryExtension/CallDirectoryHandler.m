//
//  CallDirectoryHandler.m
//  CallDirectoryExtension
//
//  Created by wintel on 2017/11/27.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "CallDirectoryHandler.h"

@interface CallDirectoryHandler () <CXCallDirectoryExtensionContextDelegate>
@end

@implementation CallDirectoryHandler


/**
    第一个方法。
    这个插件并不限制只能创建一个，我们可以创建多个插件，一个负责陌电识别，一个负责陌电拦截，负责黄页等等等。
    由于插件无法和主程序直接进行数据交换，所以数据必须存放在 group 沙盒中进行数据共享。
    在开关打开时，或者主程序执行刷新代码时候调用，在这里提交号码给系统做拦截或者显示标记信息，
    模板会自动生成下面的四个方法，这些方法需要我们主动去调用；
 
 1:全量添加数据到陌电识别或者来电拦截
 - (void)addAllIdentificationPhoneNumbersToContext:(CXCallDirectoryExtensionContext *)context;
 - (void)addAllBlockingPhoneNumbersToContext:(CXCallDirectoryExtensionContext *)context;
 
2:增量添加或移除数据到陌电识别或者来电拦截（iOS 11 新加入）
 - (void)addOrRemoveIncrementalIdentificationPhoneNumbersToContext:(CXCallDirectoryExtensionContext *)context;
 - (void)addOrRemoveIncrementalBlockingPhoneNumbersToContext:(CXCallDirectoryExtensionContext *)context;
 
 */
- (void)beginRequestWithExtensionContext:(CXCallDirectoryExtensionContext *)context {
    context.delegate = self;

    // Check whether this is an "incremental" data request. If so, only provide the set of phone number blocking
    // and identification entries which have been added or removed since the last time this extension's data was loaded.
    // But the extension must still be prepared to provide the full set of data at any time, so add all blocking
    // and identification phone numbers if the request is not incremental.
    if (context.isIncremental) {
        [self addOrRemoveIncrementalBlockingPhoneNumbersToContext:context];

        [self addOrRemoveIncrementalIdentificationPhoneNumbersToContext:context];
    } else {
        [self addAllBlockingPhoneNumbersToContext:context];

        [self addAllIdentificationPhoneNumbersToContext:context];
    }
    
    [context completeRequestWithCompletionHandler:nil];
}

/**
 全量添加号码到陌电拦截
 因为插件需要考虑内存问题，所以数据添加不要一次全部读取到内存中，号码必须使用升序添加，号码理论上必须包含国际码
 */
- (void)addAllBlockingPhoneNumbersToContext:(CXCallDirectoryExtensionContext *)context {
    // Retrieve phone numbers to block from data store. For optimal performance and memory usage when there are many phone numbers,
    // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
    //
    // Numbers must be provided in numerically ascending order.
    CXCallDirectoryPhoneNumber allPhoneNumbers[] = { 14085555555, 18005555555 };
    NSUInteger count = (sizeof(allPhoneNumbers) / sizeof(CXCallDirectoryPhoneNumber));
    for (NSUInteger index = 0; index < count; index += 1) {
        CXCallDirectoryPhoneNumber phoneNumber = allPhoneNumbers[index];
        [context addBlockingEntryWithNextSequentialPhoneNumber:phoneNumber];
    }
}

/**
 增量添加或移除号码到陌电拦截
 因为插件需要考虑内存问题，所以数据添加不要一次全部读取到内存中，号码理论上必须包含国际码
 */
- (void)addOrRemoveIncrementalBlockingPhoneNumbersToContext:(CXCallDirectoryExtensionContext *)context {
    // Retrieve any changes to the set of phone numbers to block from data store. For optimal performance and memory usage when there are many phone numbers,
    // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
    CXCallDirectoryPhoneNumber phoneNumbersToAdd[] = { 14085551234 };
    NSUInteger countOfPhoneNumbersToAdd = (sizeof(phoneNumbersToAdd) / sizeof(CXCallDirectoryPhoneNumber));

    for (NSUInteger index = 0; index < countOfPhoneNumbersToAdd; index += 1) {
        CXCallDirectoryPhoneNumber phoneNumber = phoneNumbersToAdd[index];
        [context addBlockingEntryWithNextSequentialPhoneNumber:phoneNumber];
    }

    CXCallDirectoryPhoneNumber phoneNumbersToRemove[] = { 18005555555 };
    NSUInteger countOfPhoneNumbersToRemove = (sizeof(phoneNumbersToRemove) / sizeof(CXCallDirectoryPhoneNumber));
    for (NSUInteger index = 0; index < countOfPhoneNumbersToRemove; index += 1) {
        CXCallDirectoryPhoneNumber phoneNumber = phoneNumbersToRemove[index];
        [context removeBlockingEntryWithPhoneNumber:phoneNumber];
    }

    // Record the most-recently loaded set of blocking entries in data store for the next incremental load...
}

/**
 全量添加号码到陌电识别
 因为插件需要考虑内存问题，所以数据添加不要一次全部读取到内存中，号码必须使用升序添加，号码理论上必须包含国际码
 */
- (void)addAllIdentificationPhoneNumbersToContext:(CXCallDirectoryExtensionContext *)context {
    // Retrieve phone numbers to identify and their identification labels from data store. For optimal performance and memory usage when there are many phone numbers,
    // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
    //
    // Numbers must be provided in numerically ascending order.
    CXCallDirectoryPhoneNumber allPhoneNumbers[] = { 18775555555, 18885555555 };
    NSArray<NSString *> *labels = @[ @"Telemarketer", @"Local business" ];
    NSUInteger count = (sizeof(allPhoneNumbers) / sizeof(CXCallDirectoryPhoneNumber));
    for (NSUInteger i = 0; i < count; i += 1) {
        CXCallDirectoryPhoneNumber phoneNumber = allPhoneNumbers[i];
        NSString *label = labels[i];
        [context addIdentificationEntryWithNextSequentialPhoneNumber:phoneNumber label:label];
    }
}

/**
 增量添加或移除号码到陌电识别
 因为插件需要考虑内存问题，所以数据添加不要一次全部读取到内存中，号码理论上必须包含国际码
 */
- (void)addOrRemoveIncrementalIdentificationPhoneNumbersToContext:(CXCallDirectoryExtensionContext *)context {
    // Retrieve any changes to the set of phone numbers to identify (and their identification labels) from data store. For optimal performance and memory usage when there are many phone numbers,
    // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
    CXCallDirectoryPhoneNumber phoneNumbersToAdd[] = { 14085555678 };
    NSArray<NSString *> *labelsToAdd = @[ @"New local business" ];
    NSUInteger countOfPhoneNumbersToAdd = (sizeof(phoneNumbersToAdd) / sizeof(CXCallDirectoryPhoneNumber));

    for (NSUInteger i = 0; i < countOfPhoneNumbersToAdd; i += 1) {
        CXCallDirectoryPhoneNumber phoneNumber = phoneNumbersToAdd[i];
        NSString *label = labelsToAdd[i];
        [context addIdentificationEntryWithNextSequentialPhoneNumber:phoneNumber label:label];
    }

    CXCallDirectoryPhoneNumber phoneNumbersToRemove[] = { 18885555555 };
    NSUInteger countOfPhoneNumbersToRemove = (sizeof(phoneNumbersToRemove) / sizeof(CXCallDirectoryPhoneNumber));

    for (NSUInteger i = 0; i < countOfPhoneNumbersToRemove; i += 1) {
        CXCallDirectoryPhoneNumber phoneNumber = phoneNumbersToRemove[i];
        [context removeIdentificationEntryWithPhoneNumber:phoneNumber];
    }

    // Record the most-recently loaded set of identification entries in data store for the next incremental load...
}

#pragma mark - CXCallDirectoryExtensionContextDelegate

- (void)requestFailedForExtensionContext:(CXCallDirectoryExtensionContext *)extensionContext withError:(NSError *)error {
    // An error occurred while adding blocking or identification entries, check the NSError for details.
    // For Call Directory error codes, see the CXErrorCodeCallDirectoryManagerError enum in <CallKit/CXError.h>.
    //
    // This may be used to store the error details in a location accessible by the extension's containing app, so that the
    // app may be notified about errors which occured while loading data even if the request to load data was initiated by
    // the user in Settings instead of via the app itself.
    
    //添加移除数据时候可能发生错误，在这里建议吧错误信息记录到group 的沙盒中，当主程序启动后，检查是否有错误信息，做之后的处理
}

@end
