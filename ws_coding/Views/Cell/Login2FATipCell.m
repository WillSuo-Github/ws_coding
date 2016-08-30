//
//  Login2FATipCell.m
//  ws_coding
//
//  Created by ws on 16/8/28.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "Login2FATipCell.h"

@implementation Login2FATipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        if (!_tipLabel) {
            _tipLabel = [UILabel new];
            _tipLabel.layer.masksToBounds = YES;
            _tipLabel.layer.cornerRadius = 2.0;
            
            _tipLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
            _tipLabel.font = [UIFont systemFontOfSize:16];
            _tipLabel.minimumScaleFactor = 0.5;
            _tipLabel.adjustsFontSizeToFitWidth = YES;
            
            _tipLabel.textColor = [UIColor whiteColor];
            [self.contentView addSubview:_tipLabel];
            [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, kLoginPaddingLeftWidth, 0, kLoginPaddingLeftWidth));
            }];
        }
    }
    return self;
}

@end