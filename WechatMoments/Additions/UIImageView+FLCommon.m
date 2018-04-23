//
//  UIImageView+FLCommon.m
//  WechatMoments
//
//  Created by lmy on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "UIImageView+FLCommon.h"
#import "NSString+md5.h"
#import "FLWeakObject.h"
#import <SDWebImageManager.h>

static NSMutableDictionary * sa_image_chache;
@implementation UIImageView (FLCommon)

+ (void)configuration
{
    sa_image_chache = [NSMutableDictionary dictionary];
    [[NSFileManager defaultManager] createDirectoryAtPath:[self defaultDir] withIntermediateDirectories:YES attributes:nil error:nil];
}
+ (NSString *)defaultDir
{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *path = [paths objectAtIndex:0];
    path = [path stringByAppendingString:@"/sa_images_dir/"];
    return path;
}

+ (UIImage*)getCacheImage:(NSString*)key
{
    FLWeakObject * objw = sa_image_chache[key];
    if(objw.obj)
    {
        return objw.obj;
    }
    [sa_image_chache removeObjectForKey:key];
    return nil;
}
+ (void)saveImageToCache:(NSString*)key image:(UIImage*)image
{
    FLWeakObject * obj = [FLWeakObject weakObj:image];
    [sa_image_chache setObject:obj forKey:key];
}


- (void)fl_setImage:(NSString*)url placeHolder:(UIImage*)placeHolder
{
    NSString * md5 = url.md5String;
    if(!md5)
    {
        [self setImage:placeHolder];
        return;
    }
    UIImage * image = [UIImageView getCacheImage:md5];
    if(image)
    {
        [self setImage:image];
        return;
    }
    NSString *path = [UIImageView defaultDir];
    path = [path stringByAppendingString:md5];
    image = [[UIImage alloc] initWithContentsOfFile:path];
    if(image)
    {
        [self setImage:image];
        [UIImageView saveImageToCache:md5 image:image];
        return;
    }
    [self setImage:placeHolder];
    
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:url] options:SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        
        if(finished && image)
        {
            [UIImageView fl_saveImage:url image:image];
            [self setImage:image];
            [UIImageView saveImageToCache:md5 image:image];
        }
           
    }];
}
- (void)fl_setImage:(NSString*)url placeHolder:(UIImage*)placeHolder scale:(int)scale
{
    NSString * md5 = url.md5String;
    if(!md5)
    {
        [self setImage:placeHolder];
        return;
    }
    UIImage * image = [UIImageView getCacheImage:md5];
    if(image)
    {
        [self setImage:[self scaleImage:image scale:scale]];
        return;
    }
    NSString *path = [UIImageView defaultDir];
    path = [path stringByAppendingString:md5];
    image = [[UIImage alloc] initWithContentsOfFile:path];
    if(image)
    {
        [self setImage:[self scaleImage:image scale:scale]];
        [UIImageView saveImageToCache:md5 image:image];
        return;
    }
    [self setImage:placeHolder];
    
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:url] options:SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        
        if(finished && image)
        {
            [UIImageView fl_saveImage:url image:image];
            [self setImage:[self scaleImage:image scale:scale]];
            [UIImageView saveImageToCache:md5 image:image];
        }
        
    }];
}

- (UIImage*)scaleImage:(UIImage*)image scale:(int)scale
{
    if(scale == 1)
    {
        return image;
    }
    //CGFloat s = [UIScreen mainScreen].scale;
    
    if (scale > 1.0 && image) {
        image = [UIImage imageWithCGImage:[image CGImage]
                                    scale:scale
                              orientation:UIImageOrientationUp];
        
    }
    return image;
}

+ (void)fl_saveImage:(NSString*)url image:(UIImage*)image
{
    NSString * md5 = url.md5String;
    if(!md5)
    {
        return;
    }
    NSString *path = [UIImageView defaultDir];
    path = [path stringByAppendingString:md5];
    [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
}

@end
