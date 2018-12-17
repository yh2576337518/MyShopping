//
//  BaseNavigateController.m
//  MyShopping
//
//  Created by 惠上科技 on 2018/3/16.
//  Copyright © 2018年 惠上科技. All rights reserved.
//

#import "BaseNavigateController.h"

@interface BaseNavigateController ()

@end

@implementation BaseNavigateController

+(void)initialize{
    //设置uiBarButtonItem主题
    [self setupBarButtonItemTheme];
    //     [self setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:23.0f]}];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar *navBar = [UINavigationBar appearance];
    UIFont *font = [UIFont systemFontOfSize:18.0f];
    NSDictionary *textAttributes = @{NSFontAttributeName: font,NSForegroundColorAttributeName:[UIColor whiteColor]};
    [navBar setTitleTextAttributes:textAttributes];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

+(void)setupBarButtonItemTheme{
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor purpleColor];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:15];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateDisabled];
    
    //    [appearance setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor grayColor]} forState:UIControlStateDisabled];
}

//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (self.viewControllers.count > 0) {
//        
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    
//    [super pushViewController:viewController animated:animated];
//    
//}
//
//-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
//    
//    return [super popViewControllerAnimated:animated];
//}

@end
