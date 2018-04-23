//
//  MomentImagesView.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <UIKit/UIKit.h>



#define NAME_IMAGES_WIDTH SCREEN_WIDTH-(72-12)*2  //图片区域 宽度

#define ONE_IMAGES_WIDTH (NAME_IMAGES_WIDTH - 8)/3 //一张图片宽度

@interface MomentImagesView : UIView

- (void)showMomentImagesView:(NSArray *)images;
@end
