//
//  LMYBaseViewController.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LMYBaseViewController.h"
#import "MBProgressHUD.h"
@interface LMYBaseViewController ()

@end

@implementation LMYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
}

- (void)showMessage:(NSString *)msg
{
    [MBProgressHUD showSAToast:Type_Msg msg:msg];
}

- (void)showToast
{
    [MBProgressHUD showSAToast:Type_Loading msg:nil];
}

- (void)hidenToast
{
    [MBProgressHUD dismissSAToast];
}

- (void)failureNetworkAnomaly
{
    [MBProgressHUD dismissSAToast];
    [MBProgressHUD showSAToast:Type_Msg msg:@"网络异常"];
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
@end
