//
//  EaseInputTipsView.m
//  ws_coding
//
//  Created by ws on 16/8/29.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "EaseInputTipsView.h"
#import "Login.h"

@interface EaseInputTipsView ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) NSArray *dataList;

@property (strong, nonatomic) NSArray *loginAllList, *emailAllList;
@end

@implementation EaseInputTipsView

+ (instancetype)tipsViewWithType:(EaseInputTipsViewType)type{
    return [[self alloc] initWithTipsType:type];
}

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
    
    [self refresh];
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
    NSString *tipStr = [_valueStr substringFromIndex:rang_AT.location + rang_AT.length];
    NSMutableArray *list = [NSMutableArray new];
    [[self emailAllList] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (tipStr.length <= 0 || [obj rangeOfString:tipStr].location != NSNotFound) {
            [list addObject:[nameStr stringByAppendingFormat:@"@%@",obj]];
        }
    }];
    
    
    return list;
}

#pragma mark tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"EaseInpuTipsViewCell";
    NSInteger labelTag = 99;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kLoginPaddingLeftWidth, 0, kScreen_Width - 2 * kLoginPaddingLeftWidth, 35)];
        label.font = [UIFont systemFontOfSize:14];
        label.tag = labelTag;
        [cell.contentView addSubview:label];
    }
    
    UILabel *label = [(UILabel *)cell.contentView viewWithTag:labelTag];
    label.textColor = [UIColor colorWithHexString:_type == EaseInputTipsViewTypeLogin? @"222222" : @"666666"];
    label.text = [_dataList objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView addLineforPlainCell:cell forRowIndexPath:indexPath withLeftSpace:kLoginPaddingLeftWidth hasSectionLine:NO];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectedStringBlock && self.dataList.count > indexPath.row) {
        self.selectedStringBlock([self.dataList objectAtIndex:indexPath.row]);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 35;
}

#pragma mark 懒加载

- (NSArray *)loginAllList{
    
    if (_loginAllList == nil) {
        _loginAllList = [[Login readLoginDataList] allKeys];
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
