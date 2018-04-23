//
//  UIViewController+FLViewController.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (FLViewController)

- (void)changeLeftBarButtonItemWithName:(NSString *)name;
- (UIButton *)changeRightBarButtonItemWithName:(NSString *)name Enabled:(BOOL)enabled;

- (UIButton *)changeLeftBarButtonItemWithImage:(UIImage *)image Enabled:(BOOL)enabled;
- (UIButton *)changeRightBarButtonItemWithImage:(UIImage *)image Enabled:(BOOL)enabled;



//修改NavigationController的push链，实现NavigationController导航控制器返回到指定页面
- (void)changeNavViewControllersWithClass:(Class)ctlClass;
@end
