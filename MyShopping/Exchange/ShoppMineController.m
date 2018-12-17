//
//  ShoppMineController.m
//  MyShopping
//
//  Created by 惠上科技 on 2018/3/16.
//  Copyright © 2018年 惠上科技. All rights reserved.
//

#import "ShoppMineController.h"

@interface ShoppMineController ()

@end

@implementation ShoppMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.view.backgroundColor = [UIColor purpleColor];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    // Dispose of any resources that can be recreated.
}

@end
