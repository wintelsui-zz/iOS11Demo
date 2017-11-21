//
//  CollectionViewDragAndDropCell.m
//  iOS11Demo
//
//  Created by wintel on 2017/11/21.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "CollectionViewDragAndDropCell.h"

@implementation CollectionViewDragAndDropCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        __weak typeof(self)weakself = self;
        _imageView = ({
            UIImageView *iv = [[UIImageView alloc] init];
            iv.contentMode = UIViewContentModeScaleAspectFill;
            iv.clipsToBounds = YES;
            [weakself.contentView addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(weakself.contentView);
            }];
            iv;
        });
        self.backgroundColor = [UIColor randomColor];
    }
    return self;
}


// Override this method to modify the visual appearance for a particular
// dragState.
//
// Call super if you want to add to the existing default implementation.
//
/**
    该方法在拖拽状态变化时回调，可以在这里做一些事情
 */
- (void)dragStateDidChange:(UICollectionViewCellDragState)dragState {
    [super dragStateDidChange:dragState];
    
    switch (dragState) {
        case UICollectionViewCellDragStateNone:
            NSLog(@"UICollectionViewCellDragStateNone");
            break;
            
        case UICollectionViewCellDragStateLifting:
            NSLog(@"UICollectionViewCellDragStateLifting");
            break;
            
        case UICollectionViewCellDragStateDragging:
            NSLog(@"UICollectionViewCellDragStateDragging");
            break;
            
        default:
            break;
    }
    
}

@end
