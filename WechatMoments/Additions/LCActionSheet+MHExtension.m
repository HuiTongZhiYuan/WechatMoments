//
//  LCActionSheet+MHExtension.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LCActionSheet+MHExtension.h"

@implementation LCActionSheet (MHExtension)
+ (void)mh_configureActionSheet
{
    LCActionSheetConfig *config = LCActionSheetConfig.config;
    
    /// 蒙版可点击
    config.darkViewNoTaped = NO;
    config.separatorColor = MH_MAIN_LINE_COLOR_1;
    config.buttonColor = HEX(0x3C3E44);
    config.buttonFont = FL_FONT(16);
    config.unBlur = YES;
    config.darkOpacity = .6f;
    
    /// 设置
    config.titleEdgeInsets = UIEdgeInsetsMake(27, 22, 27, 22);
    config.titleFont = FL_FONT(13);
    
}
@end
