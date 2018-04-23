//
//  LMYCommon.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMYCommon : NSObject


+ (id)getUserDefaultsForKey:(NSString *)key;

+ (void)setUserDefaultsWithObj:(id)obj forKey:(NSString *)key;

+ (void)removeUserDefaultForKey:(NSString *)key;

/**
 *  计算文字的Size大小
 *
 *  @param text    文字内容
 *  @param font    文字字体
 *  @param maxSize 文字最大尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;

@end
