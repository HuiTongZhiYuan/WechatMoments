//
//  LMYUserLoginModel.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LMYUserLoginModel.h"
#import "sys/utsname.h"

@implementation LMYUserLoginModel


+ (instancetype)shareInstance
{
    static LMYUserLoginModel *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(obj == nil)
        {
            obj = [[LMYUserLoginModel alloc] init];
        }
    });
    return obj;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initInfoDatas];
    }
    return self;
}

- (void)initInfoDatas
{
    NSString * idTemp = FLString([LMYCommon getUserDefaultsForKey:@"SPS_user_uid"], @"");
    self.uid = LMY_DESDecrypt(idTemp);//lmyeerot839e0egiekpee

    NSString * avatarTemp = FLString([LMYCommon getUserDefaultsForKey:@"SPS_user_avatar"], @"");
    self.avatar = LMY_DESDecrypt(avatarTemp);
    
    NSString * nickTemp = FLString([LMYCommon getUserDefaultsForKey:@"SPS_user_nick"], @"");
    self.nick = LMY_DESDecrypt(nickTemp);
    
    NSString * profileTemp = FLString([LMYCommon getUserDefaultsForKey:@"SPS_user_profile"], @"");
    self.profile = LMY_DESDecrypt(profileTemp);
    
    NSString * usernameTemp = FLString([LMYCommon getUserDefaultsForKey:@"SPS_user_username"], @"");
    self.username = LMY_DESDecrypt(usernameTemp);

    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    self.ver = appVersion;
    self.platform = [LMYUserLoginModel getPhoneInfo];
}

+ (NSString*)getPhoneInfo
{
    static NSString *platform = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        struct utsname systemInfo;
        uname(&systemInfo);
        platform = [NSString stringWithFormat:@"%s", systemInfo.machine];
    });
    return platform;
}


//是否登录
+ (BOOL)islogin
{
    if ([LMYUserLoginModel shareInstance].nick.length > 0) {
        return YES;
    }
    return NO;
}

//是否第一次登录
+ (BOOL)isFirstlogin
{
    if ([LMYUserLoginModel shareInstance].nick.length > 0) {
        return NO;
    }
    return YES;
}


//登录 和 注册之后，数据处理
+ (void)changeModelWithDic:(NSDictionary *)dataDic
{
    LMYUserLoginModel * userModel = [LMYUserLoginModel shareInstance];
    userModel.uid = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"id"]];
    userModel.avatar = FLString([dataDic objectForKey:@"avatar"], @"");
    userModel.nick = FLString([dataDic objectForKey:@"nick"], @"");
    userModel.profile = FLString([dataDic objectForKey:@"profile"], @"");
    userModel.username = FLString([dataDic objectForKey:@"username"], @"");
    
    //一般只保存token， 启动app重新获取完整信息，
    //这里只做演示，分别单独保存
    if (userModel.uid.length > 0) {
        [LMYCommon setUserDefaultsWithObj:LMY_DESEncrypt(userModel.uid) forKey:@"SPS_user_uid"];
    }
    if (userModel.avatar.length > 0) {
        [LMYCommon setUserDefaultsWithObj:LMY_DESEncrypt(userModel.avatar) forKey:@"SPS_user_avatar"];
    }
    if (userModel.nick.length > 0) {
        [LMYCommon setUserDefaultsWithObj:LMY_DESEncrypt(userModel.nick) forKey:@"SPS_user_nick"];
    }
    if (userModel.profile.length > 0) {
        [LMYCommon setUserDefaultsWithObj:LMY_DESEncrypt(userModel.profile) forKey:@"SPS_user_profile"];
    }
    if (userModel.username.length > 0) {
        [LMYCommon setUserDefaultsWithObj:LMY_DESEncrypt(userModel.username) forKey:@"SPS_user_username"];
    }
}


@end
