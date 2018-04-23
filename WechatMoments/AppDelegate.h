//
//  AppDelegate.h
//  WechatMoments
//
//  Created by lmy on 2018/4/23.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LMYTabBarController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) LMYTabBarController * mainTabBarController;

+ (AppDelegate *)appDelegate;

+ (UIViewController *)getRootController;

//显示登录界面
- (void)showLoginViewController;

//设置根视图
- (void)setRootVcOfLMYNavitaionVc;
@end

