//
//  FLPHAssetsGroupController.h
//  superapp
//
//  Created by lmy on 2017/4/10.
//  Copyright © 2017年 jun. All rights reserved.
//


@class FLPHAssetsGroupController;

@protocol FLPHAssetsGroupControllerDelegate <NSObject>

- (void)imageFLPHAssets:(FLPHAssetsGroupController *)cropperViewController didFinished:(NSArray *)imageArray;

@optional
- (void)onBackToAlbuml;

@end


@interface FLPHAssetsGroupController : UIViewController


@property(nonatomic,assign)BOOL isLimitImageSize;//是否限制图片大小

@property (nonatomic, weak) id<FLPHAssetsGroupControllerDelegate> delegate;

@property(nonatomic,assign)BOOL isMultiselect;//是否多选

@property(nonatomic,assign)NSInteger maxCount;//数目
@property(nonatomic,strong)NSMutableArray * selectArray; //当前选项

@end
