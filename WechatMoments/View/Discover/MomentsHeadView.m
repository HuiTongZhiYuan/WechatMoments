//
//  MomentsHeadView.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "MomentsHeadView.h"


@interface MomentsHeadView()
{
    UIImageView * heardImageView;
    UIImageView * personImageView;
    UILabel * personNameLabel;
}
@end



@implementation MomentsHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    //背景视图
    heardImageView = [[UIImageView alloc] init];
    [heardImageView setBackgroundColor:[UIColor clearColor]];
    [heardImageView sd_setImageWithURL:[NSURL URLWithString:[LMYUserLoginModel shareInstance].profile] placeholderImage:[LMYResource imageNamed:@"testBack"]];
    [self addSubview:heardImageView];
    [heardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(self.mas_top).mas_offset(-kHeadHeight-60);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_width);
    }];
    
    //用户头像
    UIView * backView = [[UIView alloc] init];
    backView.layer.masksToBounds = YES;
    [backView setBackgroundColor:[UIColor whiteColor]];
    backView.layer.borderColor = Color_Line_Background.CGColor;
    backView.layer.borderWidth = 1;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_bottom).mas_offset(-98);
        make.right.mas_equalTo(self.mas_right).mas_offset(-10);
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(68);
    }];
    
    
    personImageView = [[UIImageView alloc] init];
    [backView addSubview:personImageView];
    [personImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backView.mas_left).mas_offset(-2);
        make.right.mas_equalTo(backView.mas_right).mas_offset(-2);
        make.top.mas_equalTo(backView.mas_top).mas_offset(-2);
        make.bottom.mas_equalTo(backView.mas_bottom).mas_offset(-2);
    }];
    [personImageView sd_setImageWithURL:[NSURL URLWithString:@"http://info.thoughtworks.com/rs/thoughtworks2/images/glyph_badge.png"] placeholderImage:[LMYResource imageNamed:@"DefaultHead"]];
    
    
    //用户名
    personNameLabel = [[UILabel alloc] init];
    personNameLabel.font = [UIFont boldSystemFontOfSize:18];
    personNameLabel.textColor = [UIColor whiteColor];
    personNameLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:personNameLabel];
    [personNameLabel setBackgroundColor:[UIColor clearColor]];
    personNameLabel.text = [LMYUserLoginModel shareInstance].nick;
    
    [personNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(backView.mas_left).mas_offset(-20);
        make.top.mas_equalTo(self->heardImageView.mas_bottom).mas_offset(-40);
        make.height.mas_equalTo(40);
    }];
    
    //未读消息
    
    
    return self;
}

@end
