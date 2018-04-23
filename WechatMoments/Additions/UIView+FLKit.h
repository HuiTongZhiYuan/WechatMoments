//
//  UIView+FLKit.h
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)


@property (nonatomic) CGFloat l_left;
@property (nonatomic) CGFloat l_top;
@property (nonatomic) CGFloat l_right;
@property (nonatomic) CGFloat l_bottom;

@property (nonatomic) CGFloat l_width;
@property (nonatomic) CGFloat l_height;

@property (nonatomic) CGFloat l_centerX;
@property (nonatomic) CGFloat l_centerY;

@property (nonatomic) CGPoint l_origin;
@property (nonatomic) CGSize  l_size;



@property (nonatomic, strong) UIView * topLine;
@property (nonatomic, strong) UIView * bottomLine;
@property (nonatomic, strong) UIView * leftLine;
@property (nonatomic, strong) UIView * rightLine;


@end

