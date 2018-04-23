//
//  LMYInterface.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LMYInterface.h"

@implementation LMYInterface



+ (instancetype)sharedInstance
{
    static LMYInterface *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LMYInterface alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (AFHTTPSessionManager*)manager
{
    static AFHTTPSessionManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 设置超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 20.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        //需要添加text/plain text/html格式解析，路由器里有接口用到
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    });
    return manager;
}


//01 获取个人信息
- (void)user_jsmith_success:(LMY_RESULT_SUCCESS)success
                    failure:(LMY_RESULT_FAILURE)failure
{
    AFHTTPSessionManager * manager = [self manager];
    [manager GET:API_USER_JSMITH parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success([LMYInterface toArrayOrNSDictionary:responseObject isCheckout:YES]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(error);
        }
    }];
}



//02 获取朋友圈
- (void)user_jsmith_tweets_success:(LMY_RESULT_SUCCESS)success
                           failure:(LMY_RESULT_FAILURE)failure
{
    AFHTTPSessionManager * manager = [self manager];
    [manager GET:API_USER_JSMITH_TWEETS parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success([LMYInterface toArrayOrNSDictionary:responseObject isCheckout:YES]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(error);
        }
    }];
}




// 将JSON串转化为字典或者数组
+ (id)toArrayOrNSDictionary:(NSData *)receiveData isCheckout:(BOOL)isCheckout
{
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:receiveData
                                                    options:NSJSONReadingMutableLeaves
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        NSLog(@"=============jsonObject: %@",jsonObject);
        return jsonObject;
    }else{
        //解析错误
        NSString *receiveStr = [[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
        NSLog(@"receiveStr ========解析错误>>>>> %@",receiveStr);
        return nil;
    }
}
@end
