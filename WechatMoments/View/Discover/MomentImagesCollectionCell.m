//
//  MomentImagesCollectionCell.m
//  WechatMoments
//
//  Created by lmy on 2018/4/24.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "MomentImagesCollectionCell.h"
#import "LMYImageButton.h"


@interface MomentImagesCollectionCell ()<LMYImageButtonDelegate>
@property(nonatomic,strong)LMYImageButton * imageButton;
@property(nonatomic,strong)NSIndexPath * cellIndexPath;
@end



@implementation MomentImagesCollectionCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        [self setBackgroundColor:[UIColor clearColor]];

        _imageButton = [[LMYImageButton alloc] init];
        _imageButton.delegate = self;
        [self addSubview:_imageButton];
        
        [_imageButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(self.mas_height);
        }];
    }
    return self;
}


- (void)showMomentImagesCollectionCell:(NSString *)urlstring indexPath:(NSIndexPath *)indexPath
{
    self.cellIndexPath = indexPath;
    [self.imageButton setImageWithUrl:urlstring tag:indexPath.row];
}



#pragma - LMYImageButtonDelegate <NSObject>
- (void)imageButtonClick:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageButtonClick:)]) {
        [self.delegate imageButtonClick:index];
    }
}
@end
