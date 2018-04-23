//
//  FLPictureViewerCell.h
//  Common
//
//  Created by lmy on 2017/5/9.
//  Copyright © 2017年 oiio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLPictureViewerController.h"

@protocol FLPictureViewerCellDelegate <NSObject>

- (void)dismissPopupViewController;

@end



@interface FLPictureViewerCell : UICollectionViewCell

@property(nonatomic,weak)UIViewController * viewController;

@property(nonatomic,weak)id<FLPictureViewerCellDelegate>delegate;

- (void)showPictureReader:(FLPictureViewerModel *)model;

- (void)reductionScale:(BOOL)animated;

@end
