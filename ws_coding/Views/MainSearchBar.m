//
//  MainSearchBar.m
//  ws_coding
//
//  Created by ws on 16/9/4.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "MainSearchBar.h"

@implementation MainSearchBar

-(void)layoutSubviews
{
    //fix width in ios7
    self.width=kScreen_Width-115;
    self.autoresizesSubviews = YES;
    //找到输入框  右移
    NSPredicate *finalPredicate = [NSPredicate predicateWithBlock:^BOOL(UIView *candidateView, NSDictionary *bindings) {
        return [candidateView isMemberOfClass:NSClassFromString(@"UISearchBarTextField")];
    }];
    UITextField *searchField = [[[[[self subviews] firstObject] subviews] filteredArrayUsingPredicate:finalPredicate] lastObject];
    searchField.textAlignment = NSTextAlignmentLeft;
    [searchField setFrame:CGRectMake(-CGRectGetWidth(self.frame)/2 + 40, 4.8, CGRectGetWidth(self.frame), 22)];
    [(UIImageView*)searchField.leftView setSize:CGSizeMake(13, 13)];
}

- (UIButton *)scanBtn{
    
    if (_scanBtn == nil) {
        _scanBtn = [UIButton new];
        [_scanBtn setImage:[UIImage imageNamed:@"button_scan"] forState:UIControlStateNormal];
        [self addSubview:_scanBtn];
        [_scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 30));
            make.centerY.right.equalTo(self);
        }];
    }
    return _scanBtn;
}

@end
