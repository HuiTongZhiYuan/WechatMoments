//
//  FLPictureViewerController.h
//  Common
//
//  Created by lmy on 2017/5/9.
//  Copyright © 2017年 oiio. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface FLPictureViewerModel : NSObject


@property (nonatomic, copy) NSString * original;
@property (nonatomic, copy) NSString * thumbnail;

- (instancetype)initWiththumbnail:(NSString *)thumbnailPath
                         original:(NSString *)originalPath;

@end

@protocol FLPictureViewerControllerDelegate <NSObject>

- (void)dismissPopupViewController;

- (void)downImageWithUrl:(NSString *)url;

@end


@interface FLPictureViewerController : UIViewController

@property(nonatomic,weak)id<FLPictureViewerControllerDelegate>delegate;
//添加对象，返回数组个数
- (NSInteger)arrayAddMode:(FLPictureViewerModel *)model;

- (void)showAllPicWithIndex:(NSInteger)index;

@end
