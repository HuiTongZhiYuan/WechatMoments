//
//  MBProgressHUD+SAToast.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "MBProgressHUD+SAToast.h"
#import "LMYToastManager.h"


#define SA_duration    2.5
#define TEXTFONT        17
@implementation MBProgressHUD (SAToast)

+ (void)showSAToast:(SAHudType)type msg:(NSString *)msg
{
    BOOL autoDismiss = YES;
    if (type == Type_Loading) {
        autoDismiss = NO;
    }
    [self showSAToast:type msg:msg autoDismiss:autoDismiss];
}

+ (void)showSAToast:(SAHudType)type msg:(NSString *)msg autoDismiss:(BOOL)autoDismiss
{
    [self showSAToast:type msg:msg autoDismiss:autoDismiss position:Position_Center];
}


+ (void)showSAToast:(SAHudType)type
                msg:(NSString *)msg
        autoDismiss:(BOOL)autoDismiss
           position:(SAHudPosition)position
{
    [self showSAToast:type msg:msg autoDismiss:autoDismiss position:position interval:SA_duration];
}

+ (void)showSAToast:(SAHudType)type msg:(NSString *)msg interval:(int)interval
{
    [self showSAToast:type msg:msg autoDismiss:YES position:Position_Center interval:interval];
}

+ (void)showSAToast:(SAHudType)type
                msg:(NSString *)msg
        autoDismiss:(BOOL)autoDismiss
           position:(SAHudPosition)position
           interval:(int)interval

{
    
    [[LMYToastManager manager] addSAToast:type msg:msg autoDismiss:autoDismiss position:position interval:interval];
}


+ (void)dismissSAToast
{
    [self dismissSAToastForView:[UIApplication sharedApplication].keyWindow];
}

+ (void)dismissSAToastForView:(UIView *)view
{
    [self hideHUDForView:view animated:NO];
}


@end
