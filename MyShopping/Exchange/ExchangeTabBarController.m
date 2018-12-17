//
//  ExchangeTabBarController.m
//  MyShopping
//
//  Created by 惠上科技 on 2018/3/16.
//  Copyright © 2018年 惠上科技. All rights reserved.
//

#import "ExchangeTabBarController.h"
#import "ShoppHomeController.h"
#import "SearcherController.h"
#import "ClassificationViewController.h"
#import "CartViewController.h"
#import "ShoppMineController.h"
#import "BaseNavigateController.h"
#import "TabBar.h"
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
@interface ExchangeTabBarController ()<UITabBarDelegate,UITabBarControllerDelegate>

@end
@implementation ExchangeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpAllChildViewController];
    self.title = @"商城首页";
    self.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.selectedIndex = 0;
    self.tabBarController.tabBar.hidden = YES;
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_back_normal"] style:UIBarButtonItemStyleDone target:self action:@selector(backItemClick)];
    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)backItemClick{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark ---------设置子类控制器
- (void)setUpAllChildViewController{
    ShoppHomeController *home=[[ShoppHomeController alloc]init];
    [self setUpOneChildViewController:home image:nil selectedImage:nil title:@"搜索"];

    //兑换
    UIViewController *exchangeVc=[[UIViewController alloc]init];
    [self setUpOneChildViewController:exchangeVc image:nil selectedImage:nil title:@"分类"];

    //私信
    UIViewController* sessionListViewController = [[UIViewController alloc] init];
    [self setUpOneChildViewController:sessionListViewController image:nil selectedImage:nil title:@"购物车"];

    UIViewController * user = [[UIViewController alloc] init];
    [self setUpOneChildViewController:user image:nil selectedImage:nil title:@"我的"];
}


- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    BaseNavigateController *nav = [[BaseNavigateController alloc] initWithRootViewController:vc];
    nav.navigationBar.barTintColor = [UIColor purpleColor];
    nav.navigationBar.tintColor = [UIColor whiteColor];
    [self addChildViewController:nav];
}

#pragma mark -- tabbar delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if ([item.title isEqualToString:@"搜索"]) {
        [self pushSearch];
    }else if ([item.title isEqualToString:@"分类"]){
        [self pushClass];
    }else if ([item.title isEqualToString:@"购物车"]){
        [self pushCart];
    }else if ([item.title isEqualToString:@"我的"]){
        [self pushMine];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

#pragma mark -------selectItemPush
-(void)pushSearch{
    SearcherController * reco = [[SearcherController alloc]init];
    [self.navigationController pushViewController:reco animated:NO];
}

-(void)pushClass{
    ClassificationViewController * reco = [[ClassificationViewController alloc]init];
    [self.navigationController pushViewController:reco animated:NO];
}

-(void)pushCart{
    CartViewController * reco = [[CartViewController alloc]init];
    [self.navigationController pushViewController:reco animated:NO];
}

-(void)pushMine{
    ShoppMineController * reco = [[ShoppMineController alloc]init];
    [self.navigationController pushViewController:reco animated:NO];
}
@end
