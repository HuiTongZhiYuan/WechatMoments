//
//  LMYCommon.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LMYCommon.h"

@implementation LMYCommon


+ (id)getUserDefaultsForKey:(NSString *)key{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

+ (void)setUserDefaultsWithObj:(id)obj forKey:(NSString *)key{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if (![obj isKindOfClass:[NSNull class]]) {
        [defaults setValue:obj forKey:key];
    }
    [defaults synchronize];
}

+ (void)removeUserDefaultForKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
}


/**
 *  计算文字的Size大小
 *
 *  @param text    文字内容
 *  @param font    文字字体
 *  @param maxSize 文字最大尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
