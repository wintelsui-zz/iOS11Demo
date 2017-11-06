//
//  FileProviderEnumerator.h
//  FileProvider
//
//  Created by wintelsui on 2017/10/21.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import <FileProvider/FileProvider.h>

@interface FileProviderEnumerator : NSObject <NSFileProviderEnumerator>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithEnumeratedItemIdentifier:(NSFileProviderItemIdentifier)enumeratedItemIdentifier;

@property (nonatomic, readonly, strong) NSFileProviderItemIdentifier enumeratedItemIdentifier;

@end
