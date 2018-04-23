//
//  LMYInterface.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void (^ LMY_RESULT_SUCCESS) (id result);
typedef void (^ LMY_RESULT_FAILURE) (NSError * error);

#define API_USER_JSMITH @"https://thoughtworks-ios.herokuapp.com/user/jsmith"
#define API_USER_JSMITH_TWEETS @"https://thoughtworks-ios.herokuapp.com/user/jsmith/tweets"





@interface LMYInterface : NSObject


+ (instancetype)sharedInstance;


//01 获取个人信息
- (void)user_jsmith_success:(LMY_RESULT_SUCCESS)success
                    failure:(LMY_RESULT_FAILURE)failure;



//02 获取朋友圈
- (void)user_jsmith_tweets_success:(LMY_RESULT_SUCCESS)success
                           failure:(LMY_RESULT_FAILURE)failure;


@end

