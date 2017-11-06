//
//  WTSuspensionBall.h
//  iOS11Demo
//
//  Created by wintel on 2017/10/27.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTSuspensionBall : UIView

+ (instancetype)sharedSuspensionBall;

- (void)setSuspensionBallHidden:(BOOL)hidden;

- (void)clearActionObject;

- (void)setActionObject:(id)object
        performSelector:(NSString *)selecter
             withObject:(id)anArgument;

@end
