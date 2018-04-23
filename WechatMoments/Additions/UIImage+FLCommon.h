//
//  UIImage+FLCommon.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void(^FL_ImageCall)(NSMutableArray *imageArray,NSTimeInterval totalDuration);
@interface UIImage (FLCommon)

+ (UIImage*)scaleImage:(UIImage*)image scale:(int)scale;

+ (UIImage*)imageByScalingAndCroppingForWidth:(CGFloat)w withSourceImage:(UIImage *)sourceImage;

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 *
 *  @return 生成的高清的UIImage
 */
+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;


#pragma mark - iPhone拍照图片翻转问题解决方案
+ (UIImage *)fixOrientation:(UIImage *)aImage;


//第二个参数代表：每一帧的时间。默认是1s执行30帧。第三个参数：总共的时间
+ (void)imageArrayAndTotalDurWithGifData:(NSData *)data frameDuration:(NSTimeInterval)frameDuration imagesInfo:(FL_ImageCall)call;
@end

