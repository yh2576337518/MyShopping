//
//  HomeViewController.m
//  MyShopping
//
//  Created by 惠上科技 on 2018/3/16.
//  Copyright © 2018年 惠上科技. All rights reserved.
//

#import "HomeViewController.h"
#import "CustomAnimateTransitionPush.h"
#import "MGAnimationPushVC.h"
@interface HomeViewController ()<UINavigationControllerDelegate>
@end

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"首页";
    _button = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 50, 50)];
    _button.backgroundColor = [UIColor purpleColor];
    _button.layer.masksToBounds = YES;
    _button.layer.cornerRadius = 25;
    [_button addTarget:self action:@selector(pushClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    // 给按钮添加悬浮动画
    [self setBtnAnimation];
}

-(void)pushClick{
    MGAnimationPushVC *pushVC = [[MGAnimationPushVC alloc] init];
    pushVC.myImage = [UIImage imageNamed:@"videoPub_Def"];
    [self.navigationController pushViewController:pushVC animated:YES];
}

//用来自定义转场动画
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if(operation==UINavigationControllerOperationPush){
        CustomAnimateTransitionPush *animateTransitionPush=[CustomAnimateTransitionPush new];
        return animateTransitionPush;
    }else{
        return nil;
    }
}


/**
 *  让按钮悬浮（飘来飘去）
 */
-(void)setBtnAnimation{
        /// pathAnimation
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation.calculationMode = kCAAnimationPaced;
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.repeatCount = MAXFLOAT;
        pathAnimation.autoreverses=YES;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        pathAnimation.duration=6;
    
    
        UIBezierPath *path=[UIBezierPath bezierPathWithOvalInRect:CGRectInset(_button.frame, _button.frame.size.width/2-5, _button.frame.size.width/2-5)];
        pathAnimation.path=path.CGPath;
        [_button.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
        
        
        /// scaleX
        CAKeyframeAnimation *scaleX=[CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
        scaleX.values   = @[@1.0, @1.1, @1.0];
        scaleX.keyTimes = @[@0.0, @0.5, @1.0];
        scaleX.repeatCount = MAXFLOAT;
        scaleX.autoreverses = YES;
        scaleX.duration = 4;
        [_button.layer addAnimation:scaleX forKey:@"scaleX"];
        
        
        /// scaleY
        CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
        scaleY.values   = @[@1.0, @1.1, @1.0];
        scaleY.keyTimes = @[@0.0, @0.5,@1.0];
        scaleY.repeatCount = MAXFLOAT;
        scaleY.autoreverses = YES;
        scaleY.duration=6;
        [_button.layer addAnimation:scaleY forKey:@"scaleY"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
