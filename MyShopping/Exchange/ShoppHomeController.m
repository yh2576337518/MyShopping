//
//  ShoppHomeController.m
//  MyShopping
//
//  Created by 惠上科技 on 2018/3/16.
//  Copyright © 2018年 惠上科技. All rights reserved.
//

#import "ShoppHomeController.h"
#define kSTATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height//add by yanghui 2017-10-09 11:02:11
#define kSCREENTOP_HEIGHT kSTATUSBAR_HEIGHT + 44//add by yanghui 2017-10-09 11:02:20
@interface ShoppHomeController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * taleView;
@end

@implementation ShoppHomeController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat topHeight = kSCREENTOP_HEIGHT;
    self.taleView = [[UITableView alloc]initWithFrame:CGRectMake(0, topHeight, self.view.frame.size.width, self.view.frame.size.height - topHeight - self.tabBarController.tabBar.bounds.size.height) style:UITableViewStylePlain];
    self.taleView.delegate = self;
    self.taleView.dataSource = self;
    [self.view addSubview:self.taleView];
    if (@available(iOS 11.0, *)) {
        self.taleView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
