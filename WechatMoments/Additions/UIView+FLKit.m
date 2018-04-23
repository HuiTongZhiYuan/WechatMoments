//
//  UIView+FLKit.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//

/*
Runtime 使用
 */
#import "UIView+FLKit.h"
#import <objc/runtime.h>


@implementation UIView (Utils)

- (CGFloat)l_left
{
    return self.frame.origin.x;
}
- (void)setL_left:(CGFloat)l_left
{
    CGRect rect = self.frame;
    rect.origin.x = l_left;
    self.frame = rect;
}

- (CGFloat)l_top
{
    return self.frame.origin.y;
}
- (void)setL_top:(CGFloat)l_top
{
    CGRect rect = self.frame;
    rect.origin.y = l_top;
    self.frame = rect;
}

- (CGFloat)l_right
{
    return self.frame.origin.x+self.frame.size.width;
}
- (void)setL_right:(CGFloat)l_right
{
    CGRect rect = self.frame;
    rect.origin.x = l_right-rect.size.width;
    self.frame = rect;
}

- (CGFloat)l_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setL_bottom:(CGFloat)l_bottom
{
    CGRect rect = self.frame;
    rect.origin.y = l_bottom - rect.size.height;
    self.frame = rect;
}

- (CGFloat)l_width
{
    return self.frame.size.width;
}
- (void)setL_width:(CGFloat)l_width
{
    CGRect rect = self.frame;
    rect.size.width = l_width;
    self.frame = rect;
}

- (CGFloat)l_height
{
    return self.frame.size.height;
}
- (void)setL_height:(CGFloat)l_height
{
    CGRect rect = self.frame;
    rect.size.height = l_height;
    self.frame = rect;
}

- (CGFloat)l_centerX
{
    return self.center.x;
}
- (void)setL_centerX:(CGFloat)l_centerX
{
    self.center = CGPointMake(l_centerX, self.center.y);
}
- (CGFloat)l_centerY
{
    return self.center.y;
}
- (void)setL_centerY:(CGFloat)l_centerY
{
    self.center = CGPointMake(self.center.x, l_centerY);
}

- (CGPoint)l_origin
{
    return self.frame.origin;
}
- (void)setL_origin:(CGPoint)l_origin
{
    self.frame = (CGRect){l_origin,self.frame.size};
}

- (CGSize)l_size
{
    return self.frame.size;
}
- (void)setL_size:(CGSize)l_size
{
    CGRect rect = (CGRect){self.frame.origin,l_size};
    self.frame = rect;
}


- (UIView *)line
{
    UIView * line = [[UIView alloc] init];
    line.l_height = 0.5;
    line.l_width = 0.5;
    line.backgroundColor = RGB_Line_Color;
    return line;
}


static char kTopLine,kBottomLine,kLeftLine,kRightLine;

- (UIView*)topLine
{
    UIView * rt = objc_getAssociatedObject(self, &kTopLine);
    if(!rt)
    {
        UIView * line = [self line];
        objc_setAssociatedObject(self, &kTopLine, line, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        rt = line;
        [self addSubview:line];
    }
    return rt;
}
- (UIView*)bottomLine
{
    UIView * rt = objc_getAssociatedObject(self, &kBottomLine);
    if(!rt)
    {
        UIView * line = [self line];
        objc_setAssociatedObject(self, &kBottomLine, line, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        rt = line;
        [self addSubview:line];
    }
    return rt;
}
- (UIView*)leftLine
{
    UIView * rt = objc_getAssociatedObject(self, &kLeftLine);
    if(!rt)
    {
        UIView * line = [self line];
        objc_setAssociatedObject(self, &kLeftLine, line, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        rt = line;
        [self addSubview:line];
    }
    return rt;
}
- (UIView*)rightLine
{
    UIView * rt = objc_getAssociatedObject(self, &kRightLine);
    if(!rt)
    {
        UIView * line = [self line];
        objc_setAssociatedObject(self, &kRightLine, line, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        rt = line;
        [self addSubview:line];
    }
    return rt;
}



- (void)layoutSubviews
{
    UIView * line = objc_getAssociatedObject(self, &kTopLine);
    if(line)
    {
        line.l_width = self.l_width;
        line.l_top = 0;
        line.l_left = 0;
        
    }
    line = objc_getAssociatedObject(self, &kBottomLine);
    if(line)
    {
        line.l_width = self.l_width;
        line.l_bottom = self.l_height;
        line.l_left = 0;
        
    }
    line = objc_getAssociatedObject(self, &kLeftLine);
    if(line)
    {
        line.l_height = self.l_height;
        line.l_top = 0;
        line.l_left = 0;
        
    }
    
    line = objc_getAssociatedObject(self, &kRightLine);
    if(line)
    {
        line.l_height = self.l_height;
        line.l_top = 0;
        line.l_right = self.l_width;
        
    }
}

@end
