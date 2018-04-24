//
//  AppDelegate.m
//  WechatMoments
//
//  Created by lmy on 2018/4/23.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

#import "WeChatViewController.h"
#import "ContactsViewController.h"
#import "DiscoverViewController.h"
#import "MeViewController.h"

#import "LMYNavigationController.h"
#import "MomentsViewController.h"




@interface AppDelegate ()<UITabBarControllerDelegate>

@property(nonatomic,strong)WeChatViewController * wechatCtl;
@property(nonatomic,strong)ContactsViewController * contactCtl;
@property(nonatomic,strong)DiscoverViewController * discoverCtl;
@property(nonatomic,strong)MeViewController * meCtl;

@end

@implementation AppDelegate

+ (AppDelegate *)appDelegate
{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return appDelegate;
}

+ (UIViewController *)getRootController
{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UIViewController * rootVC = appDelegate.window.rootViewController;
    if([rootVC isKindOfClass:[UIViewController class]])
    {
        return (UIViewController*)appDelegate.window.rootViewController;
    }
    return nil;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [UIImageView configuration];
    
     [NSThread sleepForTimeInterval:0.5];//设置启动页面时间
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self setRootVcOfLMYNavitaionVc];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setRootVcOfLMYNavitaionVc
{
    //如果已登录-直接主界面
    if ([LMYUserLoginModel islogin]) {
        
        [self appAddTabbarVC];
        return;
    }
    
    //未登录-显示登录界面
    [self showLoginViewController];
}

- (void)showLoginViewController
{
    LoginViewController * wechatCtl = [[LoginViewController alloc] init];
    wechatCtl.title = [LMYResource LMY_Localized:@"Login"];
    LMYNavigationController * navigationController = [[LMYNavigationController alloc] initWithRootViewController:wechatCtl];
    [navigationController setNavigationBarHidden:YES animated:NO];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
}

- (void)appAddTabbarVC
{
    LMYTabBarController * tabCtl = [[LMYTabBarController alloc] init];
    tabCtl.delegate = self;
    tabCtl.tabBar.userInteractionEnabled = YES;
    
    if(_wechatCtl==nil){
        _wechatCtl = [[WeChatViewController alloc] init];
    }
    if(_contactCtl==nil){
        _contactCtl = [[ContactsViewController alloc] init];
    }
    if(_discoverCtl==nil){
        _discoverCtl = [[DiscoverViewController alloc] init];
    }
    if(_meCtl==nil){
        _meCtl = [[MeViewController alloc] init];
    }
    
    NSArray * controllerArray = @[_wechatCtl, _contactCtl, _discoverCtl, _meCtl];
    tabCtl.viewControllers = controllerArray;
    self.mainTabBarController = tabCtl;
    

    LMYNavigationController * navAll = [[LMYNavigationController alloc] initWithRootViewController:self.mainTabBarController];
    self.window.rootViewController = navAll;

//        MomentsViewController * mCtl = [[MomentsViewController alloc] init];
//         self.window.rootViewController = mCtl;

    [self.window makeKeyAndVisible];
    
    
    [self tabBarController:tabCtl shouldSelectViewController:_discoverCtl];
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    //单利主题model
    LMYThemeConfigModel *model = [LMYThemeConfigModel shareInstance];
    
    if ([viewController isEqual:_wechatCtl]) {
        self.mainTabBarController.title = model.tabbar_Home_title;
        [self.mainTabBarController setSelectedIndex:0];
    }
    else if ([viewController isEqual:_contactCtl]) {
        
        self.mainTabBarController.title = model.tabbar_Contacts_title;
        [self.mainTabBarController setSelectedIndex:1];
    }
    else if ([viewController isEqual:_discoverCtl]) {
        
        self.mainTabBarController.title = model.tabbar_Discover_title;
        [self.mainTabBarController setSelectedIndex:2];
    }
    else if ([viewController isEqual:_meCtl]) {
        
        self.mainTabBarController.title = model.tabbar_Me_title;
        [self.mainTabBarController setSelectedIndex:3];
    }
    return YES;
}
@end
