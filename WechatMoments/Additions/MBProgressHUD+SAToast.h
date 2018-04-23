//
//  MBProgressHUD+SAToast.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum HudType{
    Type_Msg,
    Type_Loading,
    Type_FeedBackSuccess,
    Type_Success,
    Type_Error,
}SAHudType;

typedef enum HudPosition{
    Position_Center,
    Position_Buttom,
}SAHudPosition;



@interface MBProgressHUD (SAToast)



+ (void)showSAToast:(SAHudType)type msg:(NSString *)msg;

+ (void)showSAToast:(SAHudType)type msg:(NSString *)msg autoDismiss:(BOOL)autoDismiss;

+ (void)showSAToast:(SAHudType)type
                msg:(NSString *)msg
        autoDismiss:(BOOL)autoDismiss
           position:(SAHudPosition)position;

+ (void)showSAToast:(SAHudType)type msg:(NSString *)msg interval:(int)interval;


+ (void)showSAToast:(SAHudType)type
                msg:(NSString *)msg
        autoDismiss:(BOOL)autoDismiss
           position:(SAHudPosition)position
           interval:(int)interval;

+ (void)dismissSAToast;
+ (void)dismissSAToastForView:(UIView *)view;


@end
