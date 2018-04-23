//
//  DesBase64codeFunc.h
//  WechatMoments
//
//  Created by lmy on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <Foundation/Foundation.h>


/* base64 & DES加密 */
#define LMY_DESEncrypt(text)        [DesBase64codeFunc base64StringFromText:text]

/* base64 & DES解密 */
#define LMY_DESDecrypt( base64 )        [DesBase64codeFunc textFromBase64String:base64]



@interface DesBase64codeFunc : NSObject


/* base64 & DES加密 */
+ (NSString *)base64StringFromText:(NSString *)text;

/* base64 & DES解密 */
+ (NSString *)textFromBase64String:(NSString *)base64;


@end
