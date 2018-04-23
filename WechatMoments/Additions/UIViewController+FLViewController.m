//
//  UIViewController+FLViewController.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "UIViewController+FLViewController.h"
//#import <objc/runtime.h>

@interface UIViewController ()

@end

@implementation UIViewController (FLViewController)

- (void)changeLeftBarButtonItemWithName:(NSString *)name
{
    UIButton * back = [[UIButton alloc] init];
    [back.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [back setTitle:name forState:UIControlStateNormal];
    [back setTitleColor:Color_CommonGreen forState:UIControlStateNormal];
    [back setTitleColor:RGB_153 forState:UIControlStateHighlighted];
    [back setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    //            [back sizeToFit];
    back.l_width = 44;
    back.l_height = 44;
    //    [back setExpand:44];
    [back addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:back]];
}
- (UIButton *)changeRightBarButtonItemWithName:(NSString *)name Enabled:(BOOL)enabled
{
    UIButton * back = [[UIButton alloc] init];
    [back.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [back setTitle:name forState:UIControlStateNormal];
    [back setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back setTitleColor:RGB_153 forState:UIControlStateHighlighted];
    [back setEnabled:enabled];
    if (!enabled) {
        [back setEnabled:NO];
        [back setTitleColor:RGB_153 forState:UIControlStateNormal];
    }
    [back sizeToFit];
    if(back.l_width<44){
        back.l_width = 44;
    }
    back.l_height = 44;
    //    [back setExpand:back.l_width];
    [back addTarget:self action:@selector(rightBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:back]];
    return back;
}

- (UIButton *)changeLeftBarButtonItemWithImage:(UIImage *)image Enabled:(BOOL)enabled
{
    UIButton * back = [[UIButton alloc] init];
    [back setImage:image forState:UIControlStateNormal];
    [back sizeToFit];
    if(back.l_width<44){
        back.l_width = 44;
    }
    back.l_height = 44;
    //    [back setExpand:48];
    [back setEnabled:enabled];
    [back setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
    [back addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:back]];
    return back;
}


- (UIButton *)changeRightBarButtonItemWithImage:(UIImage *)image Enabled:(BOOL)enabled
{
    UIButton * back = [[UIButton alloc] init];
    [back setImage:image forState:UIControlStateNormal];
    [back sizeToFit];
    if(back.l_width<44){
        back.l_width = 44;
    }
    back.l_height = 44;
    //    [back setExpand:48];
    [back setEnabled:enabled];
    [back setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
    [back addTarget:self action:@selector(rightBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:back]];
    return back;
}
- (void)leftBarButtonItemClick{
    
}
- (void)rightBarButtonItemClick{
    
}


//修改NavigationController的push链，实现NavigationController导航控制器返回到指定页面
//该方法主要实现， push链是：1、2、3、4，  左划界面4能直接到1，跳过2、3
- (void)changeNavViewControllersWithClass:(Class)ctlClass
{
    UINavigationController *navigationVC = self.navigationController;
    
    //遍历，从0到倒数第2个，找到对应的index
    NSInteger index = navigationVC.viewControllers.count-2;
    for (int i =0 ; i <=index; i++) {
        UIViewController * ctl = [navigationVC.viewControllers objectAtIndex:i];
        if ([ctl isKindOfClass:ctlClass]) {
            index = i;
            break;
        }
    }
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    //添加0-index的类
    for (int i =0; i<=index; i++) {
        UIViewController * ctl = [navigationVC.viewControllers objectAtIndex:i];
        [viewControllers addObject:ctl];
    }
    //添加最后一个类
    [viewControllers addObject:navigationVC.viewControllers.lastObject];
    
    [navigationVC setViewControllers:viewControllers animated:YES];
}
@end
