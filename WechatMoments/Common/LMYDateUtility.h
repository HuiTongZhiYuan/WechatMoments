//
//  LMYDateUtility.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMYDateUtility : NSObject

+ (instancetype)shareInterface;

#pragma mark - 将某个时间戳转化成   今天、昨天、星期 、 yyyy-MM-dd HH:mm
+(NSString *)timestampFormatWithTime:(NSTimeInterval)timestamp andFormatter:(NSString *)format;

@end
