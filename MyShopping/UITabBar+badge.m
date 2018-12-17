//
//  UITabBar+badge.m
//  SweetAngel
//
//  Created by admin on 16/9/19.
//  Copyright © 2016年 GCZ. All rights reserved.
//

#import "UITabBar+badge.h"
@implementation UITabBar (badge)
-(void)showBadgeOnItemIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
    //小红点
    UILabel *badgeView = [[UILabel alloc] init];
    badgeView.tag = 888 + index;
    badgeView.layer.masksToBounds = YES;
    badgeView.layer.cornerRadius = 6;
    badgeView.backgroundColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:48];
    CGRect tabFrame = self.frame;
    float percentx = (index + 0.6) / 4;
    CGFloat x = ceilf(percentx * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 12, 12);
    [self addSubview:badgeView];
}


-(void)hideBadgeOnItemIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
}


-(void)removeBadgeOnItemIndex:(int)index{
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}
@end
