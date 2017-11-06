//
//  WTSuspensionBall.m
//  iOS11Demo
//
//  Created by wintel on 2017/10/27.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "WTSuspensionBall.h"
#import "BFPaperButton.h"

static WTSuspensionBall * _instance;

@interface WTSuspensionBall ()
{
    UIButton *_actionButton;
    
    id _actionObject;
    NSString *_actionString;
    id _actionAnArgument;
    
}
@end

@implementation WTSuspensionBall

+ (instancetype)sharedSuspensionBall{
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

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor clearColor];
    [self setFrame:[self frameDefault]];
    
    _actionButton = ({
        BFPaperButton *bt = [BFPaperButton buttonWithType:UIButtonTypeCustom];
        
        [bt.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [bt setTitle:@"" forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [bt setImage:[UIImage imageNamed:@"icon_action_back_light"] forState:UIControlStateNormal];
        [bt setImage:[UIImage imageNamed:@"icon_action_back_dark"] forState:UIControlStateHighlighted];
        
        [bt setBackgroundColor:RGBA(43, 150, 245,0.7)];
        
        [bt setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [bt setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        
        bt.cornerRadius = 20.0f;
        bt.loweredShadowRadius = 20.0f;
        bt.liftedShadowRadius = 20.0f;
        
        
        [bt addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        bt;
    });
    
    [self addSubview:_actionButton];
    
    __weak typeof(self)weakself = self;
    [_actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40.0);
        make.centerX.mas_equalTo(weakself.mas_centerX);
        make.centerY.mas_equalTo(weakself.mas_centerY);
    }];
    
}

- (CGRect)frameDefault{
    return CGRectMake(SCREEN_WIDTH - 44, (SCREEN_WIDTH - 44) / 2.0, 44, 44);
}

- (void)actionButtonPressed:(id) sender{
    if (_actionObject != nil && _actionString != nil) {
        SEL selectAction = NSSelectorFromString(_actionString);
        if ([_actionObject respondsToSelector:selectAction]) {
            [_actionObject performSelector:selectAction withObject:nil afterDelay:0];
        }
    }
}

- (void)clearActionObject{
    _actionObject = nil;
    _actionString = nil;
    _actionAnArgument = nil;
}

- (void)setActionObject:(id)object
        performSelector:(NSString *)selecter
             withObject:(nullable id)anArgument{
    _actionObject = object;
    _actionString = selecter;
    _actionAnArgument = anArgument;
}

- (void)setSuspensionBallHidden:(BOOL)hidden{
    if (hidden) {
        [[WTSuspensionBall sharedSuspensionBall] setHidden:YES];
    }else{
        [[WTSuspensionBall sharedSuspensionBall] setHidden:NO];
        UIView *superview = [[WTSuspensionBall sharedSuspensionBall] superview];
        if (superview) {
            [superview bringSubviewToFront:self];
        }else{
            [[UIApplication sharedApplication].delegate.window addSubview:self];
        }
    }
}

@end
