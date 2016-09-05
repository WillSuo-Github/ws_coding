//
//  Project_RootViewController.m
//  ws_coding
//
//  Created by ws on 16/9/3.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "Project_RootViewController.h"

@interface Project_RootViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) MainSearchBar *mySearchBar;

@end

@implementation Project_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mySearchBar = ({
        MainSearchBar *searchBar = [[MainSearchBar alloc] initWithFrame:CGRectMake(60,7, kScreen_Width-115, 31)];
        [searchBar setContentMode:UIViewContentModeLeft];
        [searchBar setPlaceholder:@"搜索"];
        searchBar.delegate = self;
        searchBar.layer.cornerRadius=15;
        searchBar.layer.masksToBounds=TRUE;
        [searchBar.layer setBorderWidth:8];
        [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];//设置边框为白色
        [searchBar sizeToFit];
        [searchBar setTintColor:[UIColor whiteColor]];
        [searchBar insertBGColor:[UIColor colorWithHexString:@"0xffffff"]];
        [searchBar setHeight:30];
        [searchBar.scanBtn addTarget:self action:@selector(scanBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        searchBar;
    });
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_mySearchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark scan QR-Code
- (void)scanBtnClicked{
    
    
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
