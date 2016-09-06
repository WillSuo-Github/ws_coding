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

@interface ProjectListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) Projects *myProjects;
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation ProjectListView

- (instancetype)initWithFrame:(CGRect)frame projects:(Projects *)projects{
    if (self = [super initWithFrame:frame]) {
     
        _myProjects = projects;
        
        _myTableView = ({
            UITableView *tableView = [[UITableView alloc] init];
            tableView.backgroundColor = [UIColor clearColor];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [tableView registerClass:[ProjectAboutMeListCell class] forCellReuseIdentifier:@"ProjectAboutMeListCell"];

            [self addSubview:tableView];
            [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            tableView;
        });
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
        NSLog(@"%@,%@",data,error);
    }];
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProjectAboutMeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProjectAboutMeListCell"];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kProjectAboutMeListCellHeight;
}

@end
