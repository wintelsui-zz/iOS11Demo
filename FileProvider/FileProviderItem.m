//
//  FileProviderItem.m
//  FileProvider
//
//  Created by wintelsui on 2017/10/21.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "FileProviderItem.h"

@implementation FileProviderItem

// TODO: implement an initializer to create an item from your extension's backing model
// TODO: implement the accessors to return the values from your extension's backing model

- (NSFileProviderItemIdentifier)itemIdentifier {
    return @"";
}
- (NSFileProviderItemIdentifier)parentItemIdentifier {
    return @"";
}

- (NSFileProviderItemCapabilities)capabilities {
    return NSFileProviderItemCapabilitiesAllowsAll;
}

- (NSString *)filename {
    return @"";
}

- (NSString *)typeIdentifier {
    return @"";
}

@end
