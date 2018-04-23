//
//  LMYResource.h
//  WechatMoments
//
//  Created by lmy on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMYResource : NSObject

+ (NSBundle*)bundle;

+ (UIImage *)imageNamed:(NSString *)name;

+ (NSString *)LMY_Localized:(NSString *)key;


@end
