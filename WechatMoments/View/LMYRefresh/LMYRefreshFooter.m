//
//  LMYRefreshFooter.m
//  TestUpDownLoading
//
//  Created by lmy on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LMYRefreshFooter.h"


@interface LMYRefreshFooter ()

@property(nonatomic,strong)UILabel * tipLabel;
@property(nonatomic,strong)UIActivityIndicatorView * loadingView;



@end




@implementation LMYRefreshFooter


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
        [tipLabel setBackgroundColor:[UIColor clearColor]];
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
        [self setState:LMYRefreshStateRefreshed];
    }
    return self;
}


- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{

    if (_state != LMYRefreshStateNormal) //正常状态
    {
        return;
    }

    CGFloat offsetY = self.scrollView.contentOffset.y;
    CGFloat sizeHeight = self.scrollView.frame.size.height;
    CGFloat contentSizeH = self.scrollView.contentSize.height;

    CGFloat selfH = self.frame.size.height;
    if (offsetY > 0 && (offsetY + sizeHeight) > (contentSizeH + (self.isAutoLoading?(0-selfH):selfH))){
        if (self.beginBlock) {
            self.beginBlock();
        }

        if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
            LMYRefreshMsgSend(LMYRefreshMsgTarget(self.refreshingTarget), self.refreshingAction, self);
        }
    }
}


- (void)setState:(LMYRefreshState)stateTemp
{
    _state = stateTemp;
    
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
        [self.tipLabel setText:@"___ END ___"];
    }
    else{
        [self.tipLabel setHidden:YES];
        [self.loadingView setHidden:YES];
    }
    [self.tipLabel sizeToFit];
}

- (void)layoutSubviews
{
    [self.tipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];

    [self.loadingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.tipLabel.mas_left).mas_offset(-10);
        make.centerY.mas_equalTo(self.tipLabel.mas_centerY);
    }];
}
@end
