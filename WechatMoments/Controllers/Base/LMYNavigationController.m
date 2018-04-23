//
//  LMYNavigationController.m
//  WechatMoments
//
//  Created by lmy on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LMYNavigationController.h"

@interface LMYNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation LMYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //自定义导航
    [self.navigationBar setBackgroundImage:[LMYResource imageNamed:@"aroundfriends_bar_bg"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];

    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(self.viewControllers.count <= 1){
        return NO;
    }
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
