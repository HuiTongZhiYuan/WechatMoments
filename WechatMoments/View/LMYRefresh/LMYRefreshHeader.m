//
//  LMYRefreshHeader.m
//  TestUpDownLoading
//
//  Created by lmy on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LMYRefreshHeader.h"


@interface LMYRefreshHeader ()

@property(nonatomic,strong)UILabel * tipLabel;
@property(nonatomic,strong)UIActivityIndicatorView * loadingView;



@end



@implementation LMYRefreshHeader


#pragma mark - 懒加载
- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

#pragma mark - 懒加载
- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        UILabel * tipLabel = [[UILabel alloc] init];
        [tipLabel setFont:[UIFont systemFontOfSize:14]];
        [tipLabel setTextColor:[UIColor lightGrayColor]];
        [self addSubview:_tipLabel = tipLabel];
    }
    return _tipLabel;
}


- (instancetype)initWithFrame:(CGRect)frame target:(id)target refreshingAction:(SEL)action
{
    self = [super initWithFrame:frame];
    if (self) {

        self.refreshingTarget = target;
        self.refreshingAction = action;

        [self setBackgroundColor:[UIColor clearColor]];

        [self setState:LMYRefreshStateNoMoreData];
    }
    return self;
}


- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{

    if (_state != LMYRefreshStateNormal) //正常状态
    {
        return;
    }

    CGFloat offsetY = self.scrollView.contentOffset.y;
    NSLog(@"-=-=-=-=-=-=- >>>>>> %f",offsetY);
    if (offsetY < 100){
//        if (self.beginBlock) {
//            self.beginBlock();
//        }
//
//        if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
//            LMYRefreshMsgSend(LMYRefreshMsgTarget(self.refreshingTarget), self.refreshingAction, self);
//        }
    }
}


- (void)setState:(LMYRefreshState)stateTemp
{
    _state = stateTemp;

    [self.loadingView stopAnimating];
    if (_state == LMYRefreshStateNormal) //正常状态
    {
        [self.tipLabel setHidden:NO];
        [self.loadingView setHidden:YES];
        [self.tipLabel setText:@"上拉加载更多..."];
    }
    else if (_state == LMYRefreshStateRefreshing) //开始刷新
    {
        [self.tipLabel setHidden:NO];
        [self.loadingView setHidden:NO];
        [self.loadingView startAnimating];
        [self.tipLabel setText:@"加载中..."];
    }
    else if (_state == LMYRefreshStateNoMoreData) //没有更多
    {
        [self.tipLabel setHidden:NO];
        [self.loadingView setHidden:YES];
        [self.tipLabel setText:@"___ 我是有底线的 ___"];
    }
    else{
        [self.tipLabel setHidden:YES];
        [self.loadingView setHidden:YES];
    }
    [self.tipLabel sizeToFit];
    [self.tipLabel setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    [self.loadingView setFrame:CGRectMake(self.tipLabel.frame.origin.x - self.loadingView.frame.size.width - 10,0, self.loadingView.frame.size.width, self.loadingView.frame.size.height)];
    CGPoint center = self.loadingView.center;
    center.y = self.tipLabel.center.y;
    self.loadingView.center = center;

    //    LMYRefreshStateNormal = 1,//
    //
    //    LMYRefreshStatePulling,//松开即可刷新
    //
    //    LMYRefreshStateRefreshing,//刷新中
    //
    //    LMYRefreshStateRefreshed,//刷新结束
    //
    //    LMYRefreshStateNoMoreData //没有更多

}

@end
