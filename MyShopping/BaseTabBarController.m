//
//  BaseTabBarController.m
//  MyShopping
//
//  Created by 惠上科技 on 2018/3/16.
//  Copyright © 2018年 惠上科技. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigateController.h"
#import "HomeViewController.h"
#import "ExchangeTabBarController.h"
#import "ChatViewController.h"
#import "MineViewController.h"
#import "TabBar.h"
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
@interface BaseTabBarController ()<UITabBarDelegate,UITabBarControllerDelegate>
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllChildViewController];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---------设置子类控制器
- (void)setUpAllChildViewController{
    HomeViewController *home=[[HomeViewController alloc]init];
    [self setUpOneChildViewController:home image:nil selectedImage:nil title:@"首页"];
    
    //兑换
    UIViewController *exchangeVc=[[UIViewController alloc]init];
    [self setUpOneChildViewController:exchangeVc image:nil selectedImage:nil title:@"兑换"];
    
    //私信
    ChatViewController* sessionListViewController = [[ChatViewController alloc] init];
    [self setUpOneChildViewController:sessionListViewController image:nil selectedImage:nil title:@"私信"];
    
    MineViewController * user = [[MineViewController alloc] init];
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
    if ([item.title isEqualToString:@"兑换"]) {
        [self pushExchange];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    UITabBarItem *selectItem = [viewController  tabBarItem];
    if (![selectItem.title isEqualToString:@"首页"] &&![selectItem.title isEqualToString:@"私信"] && ![selectItem.title isEqualToString:@"我的"]) {
        return NO;
    }else{
        return YES;
    }
}


#pragma mark -------兑换
-(void)pushExchange{
    ExchangeTabBarController * reco = [[ExchangeTabBarController alloc]init];
    [self.selectedViewController pushViewController:reco animated:NO];
}
@end
