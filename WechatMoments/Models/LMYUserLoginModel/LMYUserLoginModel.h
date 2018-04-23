//
//  LMYUserLoginModel.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//


/*
 个人model
 */

#import <Foundation/Foundation.h>

@interface LMYUserLoginModel : NSObject


+ (instancetype)shareInstance;

@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * avatar;
@property (nonatomic, copy) NSString * nick;
@property (nonatomic, copy) NSString * profile;
@property (nonatomic, copy) NSString * username;

@property (nonatomic, copy) NSString * ver;     //版本
@property (nonatomic, copy) NSString * platform; //设备


- (void)initInfoDatas;

//是否登录
+ (BOOL)islogin;

//是否第一次登录
+ (BOOL)isFirstlogin;

//登录 和 注册之后，数据处理
+ (void)changeModelWithDic:(NSDictionary *)dataDic;

@end
