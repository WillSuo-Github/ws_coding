//
//  ProjectListView.m
//  ws_coding
//
//  Created by ws on 16/9/6.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "ProjectListView.h"
#import "ProjectAboutMeListCell.h"
#import "Coding_NetAPIManager.h"

static NSString *const kTitleKey = @"kTitleKey";
static NSString *const kValueKey = @"kValueKey";
@interface ProjectListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) Projects *myProjects;
@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation ProjectListView

- (instancetype)initWithFrame:(CGRect)frame projects:(Projects *)projects tabBarHeight:(CGFloat)tabBarHeight{
    if (self = [super initWithFrame:frame]) {
     
        _myProjects = projects;
        
        _myTableView = ({
            UITableView *tableView = [[UITableView alloc] init];
            tableView.backgroundColor = [UIColor clearColor];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [tableView registerClass:[ProjectAboutMeListCell class] forCellReuseIdentifier:@"ProjectAboutMeListCell"];
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

            [self addSubview:tableView];
            [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            if (tabBarHeight) {
                tableView.contentInset = UIEdgeInsetsMake(0, 0, tabBarHeight, 0);
            }
            
            tableView;
        });
        
        
        
        
        if (_myProjects.list.count > 0) {
            [self.myTableView reloadData];
        }else{
            [self sendRequest];
        }
    }
    return self;
}

- (void)refreshToQueryData{
    [self refreshData];
}

- (void)refreshData{
    [self sendRequest];
}

- (void)setMyProjects:(Projects *)myProjects{
    
    
}

- (void)sendRequest{

    [[Coding_NetAPIManager sharedManager] request_Projects_WithObj:_myProjects andBlock:^(Projects *data, NSError *error) {
    
        self.myProjects = data;
        [self.myProjects configWithProjects:data];
        [self setUpDataList];
        [self.myTableView reloadData];
    }];
}

- (void)setUpDataList{
    
    if (_dataList == nil) {
        _dataList = [NSMutableArray arrayWithCapacity:2];
    }
    [_dataList removeAllObjects];
    if (_myProjects.type < ProjectsTypeToChoose) {
        NSArray *pinList = [_myProjects pinList];
        NSArray *noPinList = [_myProjects noPinList];
        if (pinList.count > 0) {
            [_dataList addObject:@{kTitleKey : @"常用项目",
                                   kValueKey : pinList}];
        }
        if (noPinList.count > 0) {
            [_dataList addObject:@{kTitleKey : @"一般项目",
                                   kValueKey : noPinList}];
        }
    }
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataList.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[self valueForSection:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProjectAboutMeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProjectAboutMeListCell" forIndexPath:indexPath];
    [cell setProject:[[self valueForSection:indexPath.section] objectAtIndex:indexPath.row]];
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpaceAndSectionLine:kPaddingLeftWidth];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kProjectAboutMeListCellHeight;
}

#pragma mark other
- (NSString *)titleForSection:(NSUInteger)section{
    if (section < self.dataList.count) {
        return [[self.dataList objectAtIndex:section] valueForKey:kTitleKey];
    }
    return nil;
}
- (NSArray *)valueForSection:(NSUInteger)section{
    if (section < self.dataList.count) {
        return [[self.dataList objectAtIndex:section] valueForKey:kValueKey];
    }
    return nil;
}

@end
