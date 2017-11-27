//
//  TableViewDragAndDropCell.m
//  iOS11Demo
//
//  Created by wintel on 2017/11/13.
//Copyright © 2017年 wintel. All rights reserved.
//

#import "TableViewDragAndDropCell.h"

@interface TableViewDragAndDropCell ()

@end

@implementation TableViewDragAndDropCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        __weak typeof(self)weakself = self;
        _myImageView = ({
            UIImageView *imageview = [[UIImageView alloc] init];
            [imageview setBackgroundColor:[UIColor clearColor]];
            imageview.userInteractionEnabled = NO;
            imageview.contentMode = UIViewContentModeScaleAspectFit;
            
            [weakself.contentView addSubview:imageview];
            
            [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.mas_equalTo(10);
                make.bottom.right.mas_equalTo(-10);
            }];
            
            imageview;
        });
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
