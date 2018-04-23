//
//  FLPHAssetsController.h
//  superapp
//
//  Created by lmy on 2017/4/10.
//  Copyright © 2017年 jun. All rights reserved.
//

#import <Photos/Photos.h>
@class FLPHAssetsGroupController;


@interface FLPHAssetsController : UIViewController
@property(nonatomic,strong)PHAssetCollection * assetsGroup;

@property(nonatomic,weak)FLPHAssetsGroupController * delegate;


@end
