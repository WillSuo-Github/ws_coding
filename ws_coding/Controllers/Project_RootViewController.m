//
//  Project_RootViewController.m
//  ws_coding
//
//  Created by ws on 16/9/3.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "Project_RootViewController.h"
#import "SearchViewController.h"
#import "ProjectListView.h"
#import "RDVTabBarController.h"
#import "FRDLivelyButton.h"
#import "PopMenu.h"
#import "NProjectViewController.h"

@interface Project_RootViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) MainSearchBar *mySearchBar;
@property (strong, nonatomic) NSArray *segmentItems;
@property (nonatomic, strong) PopMenu *myPopMenu;
@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) FRDLivelyButton *rightNavBtn;

@end

@implementation Project_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self configSegmentItems];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _myCarousel = ({
        
        iCarousel *icarousel = [[iCarousel alloc] init];
        icarousel.delegate = self;
        icarousel.dataSource = self;
        icarousel.decelerationRate = 1.0;
        icarousel.scrollSpeed = 1.0;
        icarousel.type = iCarouselTypeLinear;
        icarousel.pagingEnabled = YES;
        icarousel.clipsToBounds = YES;
        icarousel.bounceDistance = 0.2;
        [self.view addSubview:icarousel];
        [icarousel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        icarousel;
    });
    
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
    
    //初始化弹出菜单
    NSArray *menuItems = @[[MenuItem itemWithTitle:@"项目" iconName:@"pop_Project" index:0],
                           [MenuItem itemWithTitle:@"任务" iconName:@"pop_Task" index:1],
                           [MenuItem itemWithTitle:@"冒泡" iconName:@"pop_Tweet" index:2],
                           [MenuItem itemWithTitle:@"添加好友" iconName:@"pop_User" index:3],
                           [MenuItem itemWithTitle:@"私信" iconName:@"pop_Message" index:4],
                           [MenuItem itemWithTitle:@"两步验证" iconName:@"pop_2FA" index:5],
                           ];
    if (!_myPopMenu) {
        _myPopMenu = [[PopMenu alloc] initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height-64) items:menuItems];
        _myPopMenu.perRowItemCount = 3;
        _myPopMenu.menuAnimationType = kPopMenuAnimationTypeSina;
    }
    @weakify(self);
    _myPopMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem){
        @strongify(self);
        
        if (self.rightNavBtn.buttonStyle != kFRDLivelyButtonStyleHamburger) {
            [self.rightNavBtn setStyle:kFRDLivelyButtonStyleHamburger animated:YES];
        }
        switch (selectedItem.index) {
                case 0:
                [self goToNewProjectVC];
                break;
                case 1:
                [self goToNewTaskVC];
                break;
                case 2:
                [self goToNewTweetVC];
                break;
                case 3:
                [self goToAddUserVC];
                break;
                case 4:
                [self goToMessageVC];
                break;
                case 5:
                [self goTo2FA];
                break;
            default:
                NSLog(@"%@",selectedItem.title);
                break;
        }
    };
    

    [self setupNavBtn];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_mySearchBar];
    
    if (_myCarousel) {
        ProjectListView *listView = (ProjectListView *)_myCarousel.currentItemView;
        if (listView) {
            [listView refreshToQueryData];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [_mySearchBar removeFromSuperview];
}

- (void)setupNavBtn{
    
    _leftNavBtn = [UIButton new];
    [self addImageBarButtonWithImageName:@"filtertBtn_normal_Nav" button:_leftNavBtn action:@selector(fliterClicked:) isRight:NO];
    
    _rightNavBtn = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(0, 0, 18.5, 18.5)];
    [_rightNavBtn setOptions:@{kFRDLivelyButtonLineWidth : @(1.0f),
                               kFRDLivelyButtonColor : [UIColor whiteColor]}];
    [_rightNavBtn setStyle:kFRDLivelyButtonStyleHamburger animated:NO];
    [_rightNavBtn addTarget:self action:@selector(addItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:_rightNavBtn];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
}

- (void)configSegmentItems{
    _segmentItems = @[@"全部项目",@"我创建的", @"我参与的",@"我关注的",@"我收藏的"];
}

- (void)goToSearchVC{
    
    SearchViewController *searchVC = [SearchViewController new];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:searchVC];
    [self.navigationController presentViewController:nav animated:NO completion:nil];
}


-(void)addImageBarButtonWithImageName:(NSString*)imageName button:(UIButton*)aBtn action:(SEL)action isRight:(BOOL)isR{
    
    UIImage *image = [UIImage imageNamed:imageName];
    CGRect frame = CGRectMake(0,0, image.size.width, image.size.height);
    
    aBtn.frame=frame;
    [aBtn setImage:image forState:UIControlStateNormal];
    [aBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aBtn];
    
    if (isR)
    {
        [self.navigationItem setRightBarButtonItem:barButtonItem];
    }else
    {
        [self.navigationItem setLeftBarButtonItem:barButtonItem];
    }
}

#pragma mark button action
- (void)addItemClicked:(FRDLivelyButton *)button{
    if (button.buttonStyle == kFRDLivelyButtonStyleHamburger) {
        
        [button setStyle:kFRDLivelyButtonStyleClose animated:YES];
         [_myPopMenu showMenuAtView:kKeyWindow startPoint:CGPointMake(0, -100) endPoint:CGPointMake(0, -100)];
    }else{
        
        [button setStyle:kFRDLivelyButtonStyleHamburger animated:YES];
        [_myPopMenu dismissMenu];
    }
    
}

- (void)fliterClicked:(UIButton *)button{
    
    
}


#pragma mark UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    [self goToSearchVC];
    return NO;
}

#pragma mark scan QR-Code
- (void)scanBtnClicked{
    
    
}

#pragma mark ICarousel
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    
    return _segmentItems.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view{
    
    Projects *pro = [Projects projectsWithType:ProjectsTypeAll User:nil];
    
    ProjectListView *listView = (ProjectListView *)view;
    @weakify(self);
    if (!listView) {
        listView = [[ProjectListView alloc] initWithFrame:carousel.bounds projects:pro block:^(Project *project) {
            @strongify(self);
            [self goToProject:project];
            
        } tabBarHeight:CGRectGetHeight(self.rdv_tabBarController.tabBar.frame)];
    }
    
    
    return listView;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    
    ProjectListView *curView = (ProjectListView *)carousel.currentItemView;
    [curView refreshToQueryData];
}

#pragma mark - jump
//项目详情
- (void)goToProject:(Project *)project{
    
    NProjectViewController *vc = [[NProjectViewController alloc] init];
    vc.myProject = project;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goToNewProjectVC{
    
    
}

- (void)goToNewTaskVC{
    
}

- (void)goToNewTweetVC{
    
    
}
- (void)goToAddUserVC{
    
    
}
- (void)goToMessageVC{
    
    
}

- (void)goTo2FA{
    
    
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
