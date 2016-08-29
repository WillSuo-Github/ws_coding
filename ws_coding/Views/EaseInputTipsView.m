//
//  EaseInputTipsView.m
//  ws_coding
//
//  Created by ws on 16/8/29.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "EaseInputTipsView.h"
#import "Login.h"

@interface EaseInputTipsView ()
@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) NSArray *dataList;

@property (strong, nonatomic) NSArray *loginAllList, *emailAllList;
@end

@implementation EaseInputTipsView

- (instancetype)initWithTipsType:(EaseInputTipsViewType)type{
    
    CGFloat padingWidth = type == EaseInputTipsViewTypeLogin ? kLoginPaddingLeftWidth : 0.0;
    self = [super initWithFrame:CGRectMake(padingWidth, 0, kScreen_Width - 2 * padingWidth, 120)];
    if (self) {
        
        //添加一个指定边角的圆角
        [self addRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(2, 2)];
        [self setClipsToBounds:YES];
        _myTableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds];
            tableView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.95];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self addSubview:tableView];
            [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            tableView.tableFooterView = [UIView new];
            tableView;
        });
        _type = type;
        _active = YES;
    }
    return self;
}

- (void)refresh{
    
    [self.myTableView reloadData];
    self.hidden = self.dataList.count <= 0 || !_active;
    
}

- (void)setActive:(BOOL)active{
    
    _active = active;
    self.hidden = self.dataList.count <= 0 || !_active;
}

- (void)setValueStr:(NSString *)valueStr{
    
    _valueStr = valueStr;
    if (_valueStr.length <= 0) {
        self.dataList = nil;
    }else if ([valueStr rangeOfString:@"@"].location == NSNotFound){
        
        self.dataList = _type == EaseInputTipsViewTypeLogin? [self loginList] : nil;
    }else{
        self.dataList = [self emailList];
    }
}

- (NSArray *)loginList{
    if (_valueStr.length <= 0) {
        return nil;
    }
    NSString *tipStr = [_valueStr copy];
    NSMutableArray *list = [NSMutableArray new];
    [[self loginAllList] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj rangeOfString:tipStr].location != NSNotFound) {
            [list addObject:obj];
        }
    }];
    
    return list;
}

- (NSArray *)emailList{
    
    if (_valueStr.length <= 0) {
        return nil;
    }
    NSRange rang_AT = [_valueStr rangeOfString:@"@"];
    if (rang_AT.location == NSNotFound) {
        return nil;
    }
    
    NSString *nameStr = [_valueStr substringToIndex:rang_AT.location];
    NSString *tipStr = [_valueStr substringFromIndex:rang_AT.location];
    NSMutableArray *list = [NSMutableArray new];
    
    
    return nil;
}

- (NSArray *)loginAllList{
    
    if (_loginAllList == nil) {
        _loginAllList = [[Login readLogonDataList] allKeys];
    }
    return _loginAllList;
}

- (NSArray *)emailAllList{
    
    if (!_emailAllList) {
        NSString *emailListStr = @"qq.com, 163.com, gmail.com, 126.com, sina.com, sohu.com, hotmail.com, tom.com, sina.cn, foxmail.com, yeah.net, vip.qq.com, 139.com, live.cn, outlook.com, aliyun.com, yahoo.com, live.com, icloud.com, msn.com, 21cn.com, 189.cn, me.com, vip.sina.com, msn.cn, sina.com.cn";
        
        _emailAllList = [emailListStr componentsSeparatedByString:@", "];
    }
    return _emailAllList;
}

@end
