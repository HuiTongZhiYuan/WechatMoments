//
//  UIImage+FLCommon.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "UIImage+FLCommon.h"

#import "UIImage+FLCommon.h"

@implementation UIImage (FLCommon)

+ (UIImage*)scaleImage:(UIImage*)image scale:(int)scale
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

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 *
 *  @return 生成的高清的UIImage
 */
+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1. 创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}



/**
 * 图片压缩到指定大小
 * @param targetSize 目标图片的大小
 * @param sourceImage 源图片
 * @return 目标图片
 */
+ (UIImage*)imageByScalingAndCroppingForWidth:(CGFloat)w withSourceImage:(UIImage *)sourceImage
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = w ;
    CGFloat targetHeight = (w  * height)/width;
    
    CGSize targetSize = CGSizeMake(targetWidth, targetHeight);
    
    //    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    //    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    //    {
    //        CGFloat widthFactor = targetWidth / width;
    //        CGFloat heightFactor = targetHeight / height;
    //        if (widthFactor > heightFactor)
    //            scaleFactor = widthFactor; // scale to fit height
    //        else
    //            scaleFactor = heightFactor; // scale to fit width
    //        scaledWidth= width * scaleFactor;
    //        scaledHeight = height * scaleFactor;
    //        // center the image
    //        if (widthFactor > heightFactor)
    //        {
    //            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
    //        }
    //        else if (widthFactor < heightFactor)
    //        {
    //            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
    //        }
    //    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - iPhone拍照图片翻转问题解决方案
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    //判断异常，图片为空不处理
    if (aImage==nil || !aImage) {
        
        return nil;
        
    }
    
    @autoreleasepool{
        
        // No-op if the orientation is already correct
        if (aImage.imageOrientation == UIImageOrientationUp)
            return aImage;
        
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        CGAffineTransform transform = CGAffineTransformIdentity;
        
        switch (aImage.imageOrientation) {
            case UIImageOrientationDown:
            case UIImageOrientationDownMirrored:
                transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
                transform = CGAffineTransformRotate(transform, M_PI);
                break;
                
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
                transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
                transform = CGAffineTransformRotate(transform, M_PI_2);
                break;
                
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
                transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
                transform = CGAffineTransformRotate(transform, -M_PI_2);
                break;
            default:
                break;
        }
        
        switch (aImage.imageOrientation) {
            case UIImageOrientationUpMirrored:
            case UIImageOrientationDownMirrored:
                transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
                transform = CGAffineTransformScale(transform, -1, 1);
                break;
                
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRightMirrored:
                transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
                transform = CGAffineTransformScale(transform, -1, 1);
                break;
            default:
                break;
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        CGColorSpaceRef colorSpace = CGImageGetColorSpace(aImage.CGImage);
        CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(aImage.CGImage);
        CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                                 CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                                 colorSpace,
                                                 bitmapInfo);
        CGContextConcatCTM(ctx, transform);
        switch (aImage.imageOrientation) {
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
                // Grr...
                CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
                break;
                
            default:
                CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
                break;
        }
        
        // And now we just create a new UIImage from the drawing context
        CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
        UIImage *img = [UIImage imageWithCGImage:cgimg];
        CGImageRelease(cgimg);
        cgimg = NULL;
        CGContextRelease(ctx);
        ctx = NULL;
        //判断异常，图片为空不处理
        if (img==nil || !img) {
            
            return aImage;
            
        }
        
        return img;
    }
}

+ (void)imageArrayAndTotalDurWithGifData:(NSData *)data
                           frameDuration:(NSTimeInterval)frameDuration
                              imagesInfo:(FL_ImageCall)call;
{
    if (!data) {
        return;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    //    UIImage *animatedImage;
    NSMutableArray *images = [NSMutableArray array];
    
    if (count <= 1) {
        //        animatedImage = [[UIImage alloc] initWithData:data];
        //        return;
    }
    else {
        
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            if (!image) {
                continue;
            }
            
            duration += [self frameDurationAtIndex:i source:source];
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
            //            duration = (1.0f / 10.0f) * count;
            duration = frameDuration * count;
        }
        if (call)
        {
            call(images,duration);
        }
        //        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    //    return animatedImage;
}

+ (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}
@end
