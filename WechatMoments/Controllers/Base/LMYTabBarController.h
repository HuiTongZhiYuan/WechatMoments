//
//  LMYTabBarController.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMYTabBarController : UITabBarController

// 改变对应item title 的位置
- (void)loadAllTabbarItemWith:(NSInteger)index;

 // 改变所有item title 的位置
- (void)layoutItem;


@end
