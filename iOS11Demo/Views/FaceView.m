//
//  FaceView.m
//  iOS11Demo
//
//  Created by 隋文涛 on 2017/11/7.
//Copyright © 2017年 wintel. All rights reserved.
//

#import "FaceView.h"

@interface FaceView ()
{
    BOOL _isSleep;
    CGFloat _angle;
    
    UIView *_viewFace;
    
    UIView *_sleepView;
    UIView *_sleepEyeLeft;
    UIView *_sleepEyeRight;
}
@end

@implementation FaceView

- (instancetype)initWithFrame:(CGRect)frame{
     self = [super initWithFrame:frame];
        if (self) {
            _angle = 0.0;
            [self setup];
            [self sleepMode:YES];
        }
        return self;
}

- (void)setup{
    __weak typeof(self)weakself = self;
    self.backgroundColor = [UIColor colorWithRed:0.97 green:0.54 blue:0.88 alpha:0.50];
//    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0f;
    self.layer.borderWidth = 2.0f;
    self.layer.borderColor = [UIColor colorWithRed:0.36 green:0.79 blue:0.96 alpha:1.00].CGColor;
    
    CGFloat widthFrame = CGRectGetWidth(self.bounds);
    CGFloat heightFrame = CGRectGetHeight(self.bounds);
    
    CGFloat widthFace = (widthFrame > heightFrame ? heightFrame : widthFrame) - 30;
    if (widthFace < 0) {
        widthFace = 0;
    }
    
    _viewFace = ({
        CGFloat radius = widthFace / 2.0f;
        UIView *view = [[UIView alloc] init];
        [view setBackgroundColor:[UIColor yellowColor]];
        view.layer.cornerRadius = radius;
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = [UIColor blackColor].CGColor;
        view;
    });
    [self addSubview:_viewFace];
    [_viewFace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(widthFace);
        make.center.equalTo(weakself);
    }];
    
    
    _sleepView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake((widthFrame - widthFace)/2.0f, (heightFrame - widthFace)/2.0f, widthFace - 30, 10)];
        [view setBackgroundColor:[UIColor blackColor]];
        view;
    });
    [self addSubview:_sleepView];
    [_sleepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_viewFace.mas_width).mas_offset(-30);
        make.height.mas_equalTo(10);
        make.centerX.equalTo(_viewFace);
        make.centerY.equalTo(_viewFace).mas_offset(10);
    }];
    
}

- (void)sleepMode:(BOOL)sleep{
    _isSleep = sleep;
    
}

- (void)faceEyeAngle:(CGFloat)angle{
    _angle = angle;
    
}

- (void)refreshEye{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
