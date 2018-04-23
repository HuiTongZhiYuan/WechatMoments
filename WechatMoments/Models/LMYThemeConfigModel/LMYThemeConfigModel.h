//
//  LMYThemeConfigModel.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//


/*
 tabbar主题model
 */

#import <Foundation/Foundation.h>

@interface LMYThemeConfigModel : NSObject


@property (nonatomic, copy) NSString * tabbar_Home_title;
@property (nonatomic, copy) NSString * tabbar_Home_titleSelected;

@property (nonatomic, copy) NSString * tabbar_Contacts_title;
@property (nonatomic, copy) NSString * tabbar_Contacts_titleSelected;

@property (nonatomic, copy) NSString * tabbar_Discover_title;
@property (nonatomic, copy) NSString * tabbar_Discover_titleSelected;

@property (nonatomic, copy) NSString * tabbar_Me_title;
@property (nonatomic, copy) NSString * tabbar_Me_titleSelected;
@property (nonatomic, strong) NSArray * imageNArray;
@property (nonatomic, strong) NSArray * imageSAarray;

+ (instancetype)shareInstance;

@end
