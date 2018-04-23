//
//  NSString+md5.m
//  WechatMoments
//
//  Created by lmy on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "NSString+md5.h"
#import <CommonCrypto/CommonDigest.h>
#import <string.h>

#define MD5_LENGTH 16


@implementation NSString (MD5)

- (NSString *)md5String {
    NSMutableString *cryptedString = [NSMutableString stringWithCapacity:MD5_LENGTH];
    unsigned char result[MD5_LENGTH] = {0};

    const char *string = [self UTF8String];
    CC_MD5(string, (CC_LONG)strlen(string), result);
    int i;
    for (i = 0; i < MD5_LENGTH; ++i) [cryptedString appendFormat:@"%02X", result[i]];

    return [NSString stringWithString:cryptedString];
}

@end
