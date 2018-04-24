//
//  LMYImageButton.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LMYImageButton.h"


@interface LMYImageButton()
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UIButton * markButton;
@end





@implementation LMYImageButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    self.clipsToBounds=YES;
    
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageView setBackgroundColor:RGB_215];
    [self addSubview:_imageView];
    
    _markButton = [[UIButton alloc] init];
    [self addSubview:_markButton];
    
    
    [_markButton addTarget:self action:@selector(markButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_markButton setBackgroundImage:[LMYResource imageNamed:@"ButtonMarkClick"] forState:UIControlStateHighlighted];
    [_markButton setBackgroundColor:[UIColor clearColor]];
    _markButton.alpha = 0.2;
    [self addSubview:_markButton];

    [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(self.mas_height);
    }];


    [_markButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(self.mas_height);
    }];
    
    return self;
}

- (void)setImageWithUrl:(NSString *)urlStr tag:(NSInteger )tag
{
    self.markButton.tag = tag;
    
    UIImage * triangle = [LMYResource imageNamed:@"background_gray"];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:triangle];
}


//- (void)sizeChangeed
//{
//    self.imageView.frame = CGRectMake(0, 0, self.l_width, self.l_height);
//    self.markButton.frame = CGRectMake(0, 0, self.l_width, self.l_height);
//}

- (void)markButtonClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageButtonClick:)]) {
        [self.delegate imageButtonClick:sender.tag];
    }
}
@end
