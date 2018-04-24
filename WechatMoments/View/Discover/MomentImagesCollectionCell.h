//
//  MomentImagesCollectionCell.h
//  WechatMoments
//
//  Created by lmy on 2018/4/24.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MomentImagesCollectionCellDelegate <NSObject>
- (void)imageButtonClick:(NSInteger)index;
@end



@interface MomentImagesCollectionCell : UICollectionViewCell

@property(nonatomic,weak)id<MomentImagesCollectionCellDelegate>delegate;

- (void)showMomentImagesCollectionCell:(NSString *)urlstring indexPath:(NSIndexPath *)indexPath;

@end
