//
//  LMYResource.m
//  WechatMoments
//
//  Created by lmy on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LMYResource.h"

@implementation LMYResource

+ (NSBundle*)bundle
{
    static NSBundle * bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundle = [NSBundle bundleForClass:[self class]];
    });
    return bundle;
}

+ (UIImage *)imageNamed:(NSString *)name
{
    //国际化图片
    NSString * localizableName = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@",name,localizableName];

    UIImage * image = [UIImage imageNamed:fileName inBundle:[self bundle] compatibleWithTraitCollection:nil];
    if (image)
    {
        return image;
    }

    return [UIImage imageNamed:name inBundle:[self bundle] compatibleWithTraitCollection:nil];
}


+ (NSString *)LMY_Localized:(NSString *)key
{
    return NSLocalizedString(key, key);
}

@end
