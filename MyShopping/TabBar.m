//
//  TabBar.m
//  BoluoLive
//
//  Created by 闫文涛 on 16/5/19.
//  Copyright © 2016年 zhangcn. All rights reserved.
//

#import "TabBar.h"
#define kSTATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height//add by yanghui 2017-10-09 11:02:11
#define kSCREENTOP_HEIGHT kSTATUSBAR_HEIGHT + 44//add by yanghui 2017-10-09 11:02:20
/**
 *  tabBar上自带按钮个数，不包含加上去的中间按钮，可根据实际需要修改
 */

@interface TabBar ()

@end

@implementation TabBar{
    UIImageView *_bgImgView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        
    }
    return self;
}

/*change by yanghui 2017-10-09 11:10:54**/
- (void)layoutSubviews
{
    [super layoutSubviews];

    if (CGRectEqualToRect(self.bounds, CGRectZero)) {
        return;
    }
//    int tabScreen = 3;
//    if (kSCREENTOP_HEIGHT == 88) {
//        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 83)];
//        tabScreen = 15;
//    }else{
//        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -11, self.frame.size.width, 60)];
//    }
//    _bgImgView.backgroundColor = [UIColor clearColor];
//    [_bgImgView setImage:[UIImage imageNamed:@"tab_bg"]];
//    [self addSubview:_bgImgView];
    
    for (UIView *subview in self.subviews) {
        NSString *subviewClass = NSStringFromClass([subview class]);
        if (![subviewClass isEqualToString:@"UITabBarButton"]) {
            continue;
        }
        CGRect itemRect = subview.frame;
//        itemRect.origin.y = itemRect.origin.y + tabScreen;
        [subview setFrame:itemRect];
        [self bringSubviewToFront:subview];
    }
}


@end
