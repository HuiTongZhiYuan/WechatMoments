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
    heardImageView.frame = CGRectMake(0, -kHeadHeight-60, SCREEN_WIDTH, SCREEN_WIDTH);
    [heardImageView sd_setImageWithURL:[NSURL URLWithString:[LMYUserLoginModel shareInstance].profile] placeholderImage:[LMYResource imageNamed:@"testBack"]];
    [self addSubview:heardImageView];

    //用户头像
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-68, self.l_height-98, 68, 68)];
    backView.layer.masksToBounds = YES;
    [backView setBackgroundColor:[UIColor whiteColor]];
    backView.layer.borderColor = Color_Line_Background.CGColor;
    backView.layer.borderWidth = 1;
    [self addSubview:backView];
    
    personImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, backView.l_width-4, backView.l_height-4)];
    [personImageView sd_setImageWithURL:[NSURL URLWithString:[LMYUserLoginModel shareInstance].avatar] placeholderImage:[LMYResource imageNamed:@"DefaultHead"]];
    [backView addSubview:personImageView];
    
    
    //用户名
    personNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(backView.l_left-200, heardImageView.l_bottom-40, 180, 40)];
    personNameLabel.font = [UIFont boldSystemFontOfSize:18];
    personNameLabel.textColor = [UIColor whiteColor];
    personNameLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:personNameLabel];
    [personNameLabel setBackgroundColor:[UIColor clearColor]];
    personNameLabel.text = [LMYUserLoginModel shareInstance].nick;
    
    //未读消息
    
    
    return self;
}

@end
