//
//  LMYRefreshView.m
//  TestUpDownLoading
//
//  Created by lmy on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LMYRefreshView.h"


@interface LMYRefreshView ()

@end


@implementation LMYRefreshView

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];

    //移除kvo
    [self removeObservers];

    if (newSuperview != nil) {

        self.scrollView = (UIScrollView *)newSuperview;
        [self addObservers];
    }

}

#pragma mark - KVO监听
- (void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
}

- (void)removeObservers
{
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {

        [self scrollViewContentOffsetDidChange:change];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}

@end
