//
//  NProjectViewController.m
//  ws_coding
//
//  Created by ws on 16/9/16.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "NProjectViewController.h"
#import "ProjectInfoCell.h"
#import "ProjectDescriptionCell.h"

@interface NProjectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation NProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"项目首页";
    
    _myTableView = ({
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.backgroundColor = kColorTableSectionBg;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        [tableView registerClass:[ProjectInfoCell class] forCellReuseIdentifier:kCellIdentifier_ProjectInfoCell];
        [tableView registerClass:[ProjectDescriptionCell class] forCellReuseIdentifier:kCellIdentifier_ProjectDescriptionCell];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tweetsBtn_Nav"] style:UIBarButtonItemStylePlain target:self action:@selector(tweetsBtnClicked)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tweetsBtnClicked{
    
    
}

#pragma mark UITableViewDelegate



#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0 || section == 2) {
        return 2;
    }else{
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ProjectInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_ProjectInfoCell forIndexPath:indexPath];
            cell.curProject = _myProject;
            return cell;
            
        }else{
            ProjectDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_ProjectDescriptionCell forIndexPath:indexPath];
            [cell setDescriptionStr:_myProject.description_mine];
            return cell;
        }
    }else{
       
        ProjectInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_ProjectInfoCell forIndexPath:indexPath];
        cell.curProject = _myProject;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [ProjectInfoCell cellHeight];;
        }else{
            return [ProjectDescriptionCell cellHeightWithObj:_myProject];
        }
    }else{
        
        return [ProjectInfoCell cellHeight];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}

@end
