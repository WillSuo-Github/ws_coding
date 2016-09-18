//
//  Tweet_RootViewController.m
//  ws_coding
//
//  Created by ws on 16/9/3.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "Tweet_RootViewController.h"
#import "RDVTabBarController.h"

@interface Tweet_RootViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) Tweet_RootViewControllerType tweetType;

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation Tweet_RootViewController

+ (instancetype)newTweetVCWithType:(Tweet_RootViewControllerType)type{
    
    Tweet_RootViewController *vc = [[Tweet_RootViewController alloc] init];
    vc.tweetType = type;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"hot_topic_Nav"] style:UIBarButtonItemStylePlain target:self action:@selector(hotTopicBtnClicked:)];
    
    [self.parentViewController.navigationItem setLeftBarButtonItem:leftBarItem animated:NO];
    
    _myTableView = ({
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        {
            //原工程中在这个地方添加了刷新
//            __weak typeof(self)weakSelf = self;
//            tableView
        }
        
        {
            UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, CGRectGetHeight(self.rdv_tabBarController.tabBar.frame), 0);
            tableView.contentInset = insets;
        }
        
        tableView;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark button action
- (void)hotTopicBtnClicked:(id)sender{
    
    
}

#pragma mark UITableViewDelegate

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.tweetType == Tweet_RootViewControllerTypeAll) {
        return 14;
    }else if (self.tweetType == Tweet_RootViewControllerTypeFriend){
        
        return 10;
    }else{
        return 5;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
