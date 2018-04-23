//
//  LMYLoadingCircleAnimationView.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LMYLoadingCircleAnimationView.h"

#define FLCircleLineStrokeWidth  3
#define FLCircleAnimationDuration 1
#define FLCircleProgressRadius 12

@interface LMYLoadingCircleAnimationView ()<CAAnimationDelegate>

@property(nonatomic, strong) CAShapeLayer *circleLayer;
@property(nonatomic, strong) CAShapeLayer *bgLayer;

@end

@implementation LMYLoadingCircleAnimationView {
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

+ (id)install {
    return [[LMYLoadingCircleAnimationView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat radius = MIN(self.frame.size.width, self.frame.size.height)/2.0;
        _bgLayer = [CAShapeLayer layer];
        _bgLayer.fillColor = [UIColor whiteColor] .CGColor;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:radius startAngle:-M_PI_2 endAngle:M_PI*2-M_PI_2 clockwise:YES];
        _bgLayer.path = path.CGPath;
        _bgLayer.shadowColor = HEX(0x0D3E56).CGColor;
        _bgLayer.shadowOpacity = 0.17;
        _bgLayer.shadowOffset = CGSizeMake(0, 0);
        _bgLayer.shadowRadius = 3;
        [self.layer addSublayer:_bgLayer];
        
        
        
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:FLCircleProgressRadius startAngle:-M_PI_2 endAngle:M_PI*2-M_PI_2 clockwise:YES];
        _circleLayer.path = path.CGPath;
        _circleLayer.strokeColor = Color_CommonGreen.CGColor;
        _circleLayer.lineWidth = FLCircleLineStrokeWidth;
        _circleLayer.strokeStart = 0;
        _circleLayer.strokeEnd = 0;
        _circleLayer.lineCap = @"round";
        
        [self.layer addSublayer:_circleLayer];
        self.backgroundColor = [UIColor clearColor];
        [self startLoadingAnimation];
    }
    
    
    return self;
}

- (void)startLoadingAnimation {
    [_circleLayer removeAllAnimations];
    
    CABasicAnimation *pathEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathEndAnimation.duration = FLCircleAnimationDuration;
    pathEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathEndAnimation.fromValue = @(0);
    pathEndAnimation.toValue = @(1);
    pathEndAnimation.autoreverses = NO;
    pathEndAnimation.removedOnCompletion = NO;
    pathEndAnimation.fillMode = kCAFillModeForwards;
    pathEndAnimation.delegate = self;
    
    [self.circleLayer addAnimation:pathEndAnimation forKey:@"StrokeEndAnimation"];
    
    
    CABasicAnimation *pathStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    pathStartAnimation.duration = FLCircleAnimationDuration/2.0;
    pathStartAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathStartAnimation.fromValue = @(0);
    pathStartAnimation.toValue = @(0.99);
    pathStartAnimation.autoreverses = NO;
    pathStartAnimation.removedOnCompletion = NO;
    pathStartAnimation.fillMode = kCAFillModeForwards;
    pathStartAnimation.delegate = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(FLCircleAnimationDuration/2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.circleLayer addAnimation:pathStartAnimation forKey:@"StrokeStartAnimation"];
    });
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([anim isEqual:[_circleLayer animationForKey:@"StrokeEndAnimation"]]) {
        
    }else if ([anim isEqual:[_circleLayer animationForKey:@"StrokeStartAnimation"]]) {
        [self startLoadingAnimation];
    }
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(40.f, 40.f);
}

@end
