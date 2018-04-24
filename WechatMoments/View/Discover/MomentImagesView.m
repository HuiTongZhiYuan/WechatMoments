//
//  MomentImagesView.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "MomentImagesView.h"
#import "FLPictureViewerController.h"
#import "AppDelegate.h"
#import "UIViewController+MJPopupViewController.h"
#import "MomentImagesCollectionCell.h"

@interface MomentImagesView ()<FLPictureViewerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,MomentImagesCollectionCellDelegate>

@property(nonatomic,strong)UICollectionView * collectionView;

@property(nonatomic,strong)NSArray * imageNSArray;

@end


static NSString *const cellId = @"FLPictureViewerCellId";


@implementation MomentImagesView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self setBackgroundColor:[UIColor clearColor]];

    UICollectionViewFlowLayout * layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical; //设置布局方式


    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layOut];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollEnabled = NO;
    [self addSubview:_collectionView];

    // 注册cell
    [self.collectionView registerClass:[MomentImagesCollectionCell class] forCellWithReuseIdentifier:cellId];

    return self;
}

- (void)showMomentImagesView:(NSArray *)images
{
    self.imageNSArray = images;

    if (self.imageNSArray.count == 1) {

        [_collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(ONE_IMAGES_WIDTH*2+4);
            make.height.mas_equalTo(self.mas_height);
        }];
    }else{
        [_collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(ONE_IMAGES_WIDTH*2+4);
            make.height.mas_equalTo(self.mas_height);
        }];
    }

    [self.collectionView reloadData];
}

//实现代理协议
// MARK: - Navigation
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageNSArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 先要注册
    MomentImagesCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.row<self.imageNSArray.count) {

        NSString * urlString = FLString([[self.imageNSArray objectAtIndex:indexPath.row] objectForKey:@"url"], @"");
        [cell showMomentImagesCollectionCell:urlString indexPath:indexPath];
    }
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.imageNSArray.count == 4) {
        NSLog(@"-=-=-=-=>>>>>>>>>> %f",self.l_width);
        NSLog(@"-=-=-=-=>>>>>>>>>> %f",self.l_height);
        NSLog(@"-=-=-=-=>>>>>>>>>> %f",ONE_IMAGES_WIDTH);
    }
    if (self.imageNSArray.count == 1) {
        return CGSizeMake(ONE_IMAGES_WIDTH*2+4, ONE_IMAGES_WIDTH*2+4);
    }
    return CGSizeMake(ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH);
    
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0); //设置距离上 左 下 右
}

//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 4;
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 4;
}



#pragma mark - MomentImagesCollectionCellDelegate <NSObject>
- (void)imageButtonClick:(NSInteger)index
{
    //图片预览没有支持横屏，暂时注释掉
//    FLPictureViewerController * next = [[FLPictureViewerController alloc] init];
//
//    for (int i = 0; i<self.imageNSArray.count; i++)
//    {
//        NSString * url = FLString([[self.imageNSArray objectAtIndex:0] objectForKey:@"url"], @"");
//
//        FLPictureViewerModel * picModel = [[FLPictureViewerModel alloc] initWiththumbnail:url original:url];
//        [next arrayAddMode:picModel];
//    }
//
//    [next showAllPicWithIndex:index];
//    next.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    next.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    next.delegate = self;
//    UIViewController * ctl = [AppDelegate getRootController];
//    [ctl presentPopupViewController:next animationType:MJPopupViewAnimationFade hideStatusBar:YES];
}


#pragma mark - FLPictureViewerControllerDelegate <NSObject>
- (void)dismissPopupViewController
{
    UIViewController * ctl = [AppDelegate getRootController];
    [ctl dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

- (void)downImageWithUrl:(NSString *)url
{
    
}
@end
