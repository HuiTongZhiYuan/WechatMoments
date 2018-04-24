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

@property(nonatomic,strong)MomentsModel * cellModel;

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

        [self addSubview:self.avatarImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.imagesView];
        [self addSubview:self.addressLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.arrowView];
        [self addSubview:self.controlButton];

        [self.avatarImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(20);
            make.top.mas_equalTo(self.mas_top).mas_offset(16);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
        }];
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(12);
            make.top.mas_equalTo(self.avatarImageView.mas_top);
            make.right.mas_equalTo(self.mas_right).mas_offset(-12);
            make.height.mas_equalTo(40);
        }];

        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(AllInterval);
            make.right.mas_equalTo(self.mas_right).mas_offset(-12);
        }];

        [self.imagesView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(AllInterval);
            make.right.mas_equalTo(self.mas_right).mas_offset(-12);
        }];


        [self.arrowView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left).mas_offset(8);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.width.mas_equalTo(11);
            make.height.mas_equalTo(5);
        }];
        [self.controlButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-20);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(25);
        }];
    }
    return self;
}

#pragma mark - 懒加载
//头像
- (UIImageView *)avatarImageView
{
    if (!_avatarImageView) {
        UIImageView * avatarImageView = [[UIImageView alloc] init];
        _avatarImageView = avatarImageView;
    }
    return _avatarImageView;
}

//用户名
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        UILabel * nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont boldSystemFontOfSize:18];
        nameLabel.textColor = HEX(0xbcc0cd);
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}

//内容
- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        UILabel * contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:16];
        contentLabel.numberOfLines = 0;
        contentLabel.textColor = RGB_51;
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        _contentLabel = contentLabel;
    }
    return _contentLabel;
}

//图片
- (MomentImagesView *)imagesView
{
    if (!_imagesView) {
        MomentImagesView * imagesView = [[MomentImagesView alloc] init];
        _imagesView = imagesView;
    }
    return _imagesView;
}

//地址
- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        UILabel * addressLabel = [[UILabel alloc] init];
        addressLabel.font = [UIFont systemFontOfSize:12];
        addressLabel.textColor = HEX(0xbcc0cd);
        [addressLabel setBackgroundColor:[UIColor clearColor]];
        _addressLabel = addressLabel;
    }
    return _addressLabel;
}

//时间
- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        UILabel * timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:12];
        timeLabel.textColor = RGB_215;
        [timeLabel setBackgroundColor:[UIColor clearColor]];
        _timeLabel = timeLabel;
    }
    return _timeLabel;
}

//评论箭头
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        UIImageView * arrowView = [[UIImageView alloc] init];
        [arrowView setImage:[LMYResource imageNamed:@"ComRectangle"]];
        _arrowView = arrowView;
    }
    return _arrowView;
}

//评论按钮
- (UIButton *)controlButton
{
    if (!_controlButton) {
        UIButton * controlButton = [[UIButton alloc] init];
        [controlButton setImage:[LMYResource imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
        [controlButton setImage:[LMYResource imageNamed:@"AlbumOperateMoreHL"] forState:UIControlStateHighlighted];
        [controlButton addTarget:self action:@selector(controlButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _controlButton = controlButton;
    }
    return _controlButton;
}

#pragma mark - 显示内容
- (void)showMomentsPostView:(MomentsModel *)model
{
    self.cellModel = model;
    [self allViewHide];
//    model.address = @"1123456789";
//    model.timeStamp = 1523596257;

    [self.avatarImageView setHidden:NO];
    [self.avatarImageView fl_setImage:model.sender_avatar placeHolder:[LMYResource imageNamed:@"DefaultHead"]];

    //名字
    [self.nameLabel setHidden:NO];
    self.nameLabel.text = model.sender_nick;
    [self.nameLabel sizeToFit];

    //2 内容
    if (model.content.length > 0) {
        [self.contentLabel setHidden:NO];
        self.contentLabel.text = model.content;
        [self.contentLabel sizeToFit];
    }

    //3 图片
    if (model.images.count > 0) {

        [self.imagesView setHidden:NO];
        CGFloat topY = self.nameLabel.l_bottom;
        if (self.cellModel.content.length > 0) {
            topY = self.contentLabel.l_bottom;
        }
        CGFloat contentH = 10; //图片区域高度
//        CGFloat one = (NAME_IMAGES_WIDTH - 8)/3;

        CGFloat contentW = NAME_IMAGES_WIDTH;//图片区域宽度
        if (self.cellModel.images.count == 4)
        {
            contentW = ONE_IMAGES_WIDTH*2+4;//图片区域宽度
            contentH = ONE_IMAGES_WIDTH*2+4;
        }
        else
        {
            if (self.cellModel.images.count > 0) {
                if (self.cellModel.images.count > 1 && self.cellModel.images.count <=3)
                {
                    contentH = ONE_IMAGES_WIDTH;
                }else if (self.cellModel.images.count > 3 && self.cellModel.images.count <=6){
                    contentH = ONE_IMAGES_WIDTH*2+4;
                }else if (self.cellModel.images.count > 6){
                    contentH = ONE_IMAGES_WIDTH*3+8;
                }else{
                    contentH = ONE_IMAGES_WIDTH*2+4;
                }
            }
        }
        [self.imagesView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left);

            if (self.cellModel.content.length > 0) {
                make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(AllInterval);
            }else{
                make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(AllInterval);
            }
            make.width.mas_equalTo(contentW);
            make.height.mas_equalTo(contentH);
        }];
        [self.imagesView showMomentImagesView:model.images];
    }else{
        [self.imagesView setHidden:YES];
    }

    //4 地址
    if (model.address.length > 0) {
        self.addressLabel.text = model.address;
        [self.addressLabel sizeToFit];
    }

    //5 时间
    if (model.timeStamp > 0) {
        self.timeLabel.text = [LMYDateUtility timestampFormatWithTime:model.timeStamp andFormatter:@"yyyy-MM-dd HH:mm"];
        [self.timeLabel sizeToFit];
    }

    //6 底部
    if (model.comments.count > 0) {
        [self.arrowView setHidden:NO];
    }

    [self.controlButton setHidden:NO];
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
