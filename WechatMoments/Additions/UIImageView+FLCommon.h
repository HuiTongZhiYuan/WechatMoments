//
//  UIImageView+FLCommon.h
//  WechatMoments
//
//  Created by lmy on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImageView (FLCommon)
+ (void)configuration;
- (void)fl_setImage:(NSString*)url placeHolder:(UIImage*)placeHolder;
- (void)fl_setImage:(NSString*)url placeHolder:(UIImage*)placeHolder scale:(int)scale;
+ (void)fl_saveImage:(NSString*)url image:(UIImage*)image;
+ (UIImage*)getCacheImage:(NSString*)key;
+ (void)saveImageToCache:(NSString*)key image:(UIImage*)image;


+ (NSString *)defaultDir;
@end
