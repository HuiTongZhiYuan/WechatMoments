//
//  MomentsPostView.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "MomentsPostView.h"
#import "MomentsModel.h"
#import "MomentImagesView.h"
#import "LMYDateUtility.h"


@interface MomentsPostView()

@property(nonatomic,strong) UIImageView * avatarImageView;//头像
@property(nonatomic,strong) UILabel * nameLabel;//用户名
@property(nonatomic,strong) UILabel * contentLabel;//内容
@property(nonatomic,strong) MomentImagesView * imagesView; //图片区域
@property(nonatomic,strong) UIImageView * arrowView; //评论箭头

@property(nonatomic,strong) UILabel * addressLabel;//地址
@property(nonatomic,strong) UILabel * timeLabel;//时间

@property(nonatomic,strong) UIButton * controlButton;
@end


@implementation MomentsPostView


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
      
    }
    return self;
}



#pragma mark - 懒加载
//头像
- (UIImageView *)avatarImageView
{
    if (!_avatarImageView) {
        UIImageView * avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 16, 40, 40)];
        [self addSubview:_avatarImageView = avatarImageView];
    }
    return _avatarImageView;
}

//用户名
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.avatarImageView.l_right+12, self.avatarImageView.l_top, NAME_CONTENT_WIDTH, 40)];
        nameLabel.font = [UIFont boldSystemFontOfSize:18];
        nameLabel.textColor = HEX(0xbcc0cd);
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_nameLabel = nameLabel];
    }
    return _nameLabel;
}

//内容
- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        UILabel * contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.l_left, 0, NAME_CONTENT_WIDTH, 40)];
        contentLabel.font = [UIFont systemFontOfSize:16];
        contentLabel.numberOfLines = 0;
        contentLabel.textColor = RGB_51;
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_contentLabel = contentLabel];
    }
    return _contentLabel;
}

//图片
- (MomentImagesView *)imagesView
{
    if (!_imagesView) {
        MomentImagesView * imagesView = [[MomentImagesView alloc] init];
        [self addSubview:_imagesView = imagesView];
    }
    return _imagesView;
}

//评论箭头
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        UIImageView * arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(self.nameLabel.l_left+8, 16, 11, 5)];
        [arrowView setImage:[LMYResource imageNamed:@"ComRectangle"]];
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}


//地址
- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        UILabel * addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.l_left, 0, NAME_CONTENT_WIDTH, 40)];
        addressLabel.font = [UIFont systemFontOfSize:12];
        addressLabel.textColor = HEX(0xbcc0cd);
        [addressLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_addressLabel = addressLabel];
    }
    return _addressLabel;
}

//时间
- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.l_left, 0, NAME_CONTENT_WIDTH, 40)];
        timeLabel.font = [UIFont systemFontOfSize:12];
        timeLabel.textColor = RGB_215;
        [timeLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_timeLabel = timeLabel];
    }
    return _timeLabel;
}

//评论按钮
- (UIButton *)controlButton
{
    if (!_controlButton) {
        UIButton * controlButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-25-20, 0, 25, 25)];
        [controlButton setImage:[LMYResource imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
        [controlButton setImage:[LMYResource imageNamed:@"AlbumOperateMoreHL"] forState:UIControlStateHighlighted];
        [controlButton addTarget:self action:@selector(controlButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_controlButton = controlButton];
    }
    return _controlButton;
}

- (void)showMomentsPostView:(MomentsModel *)model
{
    [self allViewHide];
//    model.address = @"1123456789";
//    model.timeStamp = 1523596257;

    [self.avatarImageView setHidden:NO];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.sender_avatar] placeholderImage:[LMYResource imageNamed:@"DefaultHead"]];


    //名字
    [self.nameLabel setHidden:NO];
    self.nameLabel.text = model.sender_nick;
    [self.nameLabel sizeToFit];
    
    CGFloat topY = self.nameLabel.l_bottom;
    //2 内容
    if (model.content.length > 0) {
        self.contentLabel.l_width = NAME_CONTENT_WIDTH;
        [self.contentLabel setHidden:NO];
        self.contentLabel.text = model.content;
        [self.contentLabel sizeToFit];
        self.contentLabel.l_top = topY+AllInterval;
        
        topY = self.contentLabel.l_bottom;
    }

    //3 图片
    if (model.images.count > 0) {
        [self.imagesView setHidden:NO];
        
        CGFloat one = (NAME_IMAGES_WIDTH - 8)/3;
        CGFloat contentH = one*2+4;
        if (model.images.count > 1 && model.images.count <=3)
        {
            contentH = one;
        }else if (model.images.count > 3 && model.images.count <=6){
            contentH = one*2+4;
        }else if (model.images.count > 6){
            contentH = one*3+8;
        }
        self.imagesView.frame = CGRectMake(self.nameLabel.l_left, topY+AllInterval, one*3+8, contentH);
        [self.imagesView showMomentImagesView:model.images];
        topY = self.imagesView.l_bottom;
    }
    
    //4 地址
    if (model.address.length > 0) {
        self.addressLabel.text = model.address;
        [self.addressLabel sizeToFit];
        
        self.addressLabel.l_top = topY+AllInterval;
        
        topY = self.addressLabel.l_bottom;
    }
    
    //6 控制器
    [self.controlButton setHidden:NO];
    self.controlButton.l_top = topY+AllInterval-5;
    
    //5 时间  和 更多按钮
    if (model.timeStamp > 0) {
        self.timeLabel.text = [LMYDateUtility timestampFormatWithTime:model.timeStamp andFormatter:@"yyyy-MM-dd HH:mm"];
        [self.timeLabel sizeToFit];
        self.timeLabel.l_top = topY+AllInterval;
    }
    topY = self.controlButton.l_bottom;
    
    //6 底部
    if (model.comments.count > 0) {
        [self.arrowView setHidden:NO];
        self.arrowView.frame = CGRectMake(self.nameLabel.l_left+10, topY, 11, 5);
    }
}

- (void)allViewHide
{
    for (UIView * vi in self.subviews) {
        [vi setHidden:YES];
    }
}


//计算高度
+ (CGFloat)heightWithModel:(MomentsModel *)model;
{
//    model.address = @"1123456789";
//    model.timeStamp = 1523596257;
    //0 顶部
    CGFloat he = topHeight;
    
    //1 名字
    CGSize contentSize = [LMYCommon sizeWithText:model.sender_nick font:[UIFont boldSystemFontOfSize:18] maxSize:CGSizeMake(NAME_CONTENT_WIDTH, MAXFLOAT)];
    he+=contentSize.height;
    he+=AllInterval;
    
    //2 内容
    if (model.content.length > 0) {

        CGSize contentSize = [LMYCommon sizeWithText:model.content font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(NAME_CONTENT_WIDTH, MAXFLOAT)];
        he+=contentSize.height;
        he+=AllInterval;
    }

    //3 图片
    if (model.images.count > 0) {

        CGFloat one = (NAME_IMAGES_WIDTH - 8)/3;
        CGFloat contentW = one*2+4;
        if (model.images.count > 1 && model.images.count <=3)
        {
            contentW = one;
        }else if (model.images.count > 3 && model.images.count <=6){
            contentW = one*2;
        }else if (model.images.count > 6){
            contentW = one*3;
        }
        he+=contentW;
        he+=AllInterval;
    }
    
    //4 地址
    if (model.address.length > 0) {
        
        CGSize contentSize = [LMYCommon sizeWithText:model.address font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(NAME_CONTENT_WIDTH, MAXFLOAT)];
        he+=contentSize.height;
        he+=AllInterval;
    }
    
    
    //5 时间 6 更多器
    he=(he - 5);
    he+=25;
    
    //6 底部
    he+=5;
    
    if (he < 72) {
        he = 72;
    }
    
    return he;
}

#pragma mark - 评论按钮
- (void)controlButtonClick:(UIButton *)snder
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(controlButtonClick:but:)]) {
        [self.delegate controlButtonClick:self.section but:snder];
    }
}
@end
