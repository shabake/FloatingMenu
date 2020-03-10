//
//  GHomeExampleCell.m
//  FloatingMenu
//
//  Created by mac on 2020/3/10.
//  Copyright © 2020 GHome. All rights reserved.
//

#import "GHomeExampleCell.h"

@interface GHomeExampleCell()

@end
@implementation GHomeExampleCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont systemFontOfSize:20];
    }
    return _title;
}

@end
