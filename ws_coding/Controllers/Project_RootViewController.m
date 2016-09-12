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

@interface Project_RootViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) MainSearchBar *mySearchBar;
@property (strong, nonatomic) NSArray *segmentItems;

@property (nonatomic, strong) UIButton *leftNavBtn;
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

- (void)setupNavBtn{
    
    _leftNavBtn = [UIButton new];
    [self addImageBarButtonWithImageName:@"filtertBtn_normal_Nav" button:_leftNavBtn action:@selector(fliterClicked:) isRight:NO];
    
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
    if (!listView) {
        listView = [[ProjectListView alloc] initWithFrame:carousel.bounds projects:pro tabBarHeight:CGRectGetHeight(self.rdv_tabBarController.tabBar.frame)];
    }
    
    
    return listView;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    
    ProjectListView *curView = (ProjectListView *)carousel.currentItemView;
    [curView refreshToQueryData];
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
