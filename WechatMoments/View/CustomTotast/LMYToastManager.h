//
//  LMYToastManager.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMYToastManager : NSObject
+(LMYToastManager *)manager;

- (void)addSAToast:(SAHudType)type
               msg:(NSString *)msg
       autoDismiss:(BOOL)autoDismiss
          position:(SAHudPosition)position
          interval:(int)interval;

@end
