//
//  LoginViewController.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self installUIs];
}

- (void)installUIs {
    UIButton * loginButton = [[UIButton alloc] init];
    [loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    [loginButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [loginButton setTitleColor:RGB(255,255,255) forState:UIControlStateNormal];
    [loginButton setTitleColor:RGB(153,153,153) forState:UIControlStateHighlighted];
    [loginButton setBackgroundColor:Color_CommonGreen];
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(16);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-16);
        make.height.mas_equalTo(49);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-80);
    }];
}

- (void)loginButtonClick
{
    [self showToast];
    [[LMYInterface sharedInstance] user_jsmith_success:^(id result) {
        
        [self hidenToast];
        
        if ([result isKindOfClass: [NSDictionary class]])
        {
            NSString * avatar =FLString([result objectForKey:@"avatar"], @"");
            NSString * nick =FLString([result objectForKey:@"nick"], @"");
            NSString * profile =FLString([result objectForKey:@"profile-image"], @"");
            NSString * username =FLString([result objectForKey:@"username"], @"");
            
            NSDictionary * userDic = @{@"id":@"1",
                                       @"avatar":avatar,
                                       @"nick":nick,
                                       @"profile":profile,
                                       @"username":username};
            [LMYUserLoginModel changeModelWithDic:userDic];
            
            [[AppDelegate appDelegate] setRootVcOfLMYNavitaionVc];
        }
    } failure:^(NSError *error) {
        [self failureNetworkAnomaly];
    }];
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
