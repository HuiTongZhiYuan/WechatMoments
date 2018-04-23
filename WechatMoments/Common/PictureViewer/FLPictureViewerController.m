//
//  FLPictureViewerController.m
//  Common
//
//  Created by lmy on 2017/5/9.
//  Copyright © 2017年 oiio. All rights reserved.
//

#import "FLPictureViewerController.h"
#import "FLPictureViewerCell.h"
#import <Photos/Photos.h>
#import "NSString+md5.h"
#import "UIImageView+FLCommon.h"


@implementation FLPictureViewerModel

- (instancetype)initWiththumbnail:(NSString *)thumbnailPath
                         original:(NSString *)originalPath
{
    self = [self init];
    if (self) {
        _thumbnail = [thumbnailPath copy];
        _original = [originalPath copy];
    }
    return self;
}

@end


@interface FLPictureViewerController ()<UICollectionViewDelegate,UICollectionViewDataSource,FLPictureViewerCellDelegate>

@property(nonatomic,strong)NSMutableArray * allPicArray;
@property(nonatomic,assign)NSInteger curIndex;


@property(nonatomic,strong)UILabel * countLabel;
@property(nonatomic,strong)UICollectionView * oneCollectionView;


@property(nonatomic,strong)UIButton * downButton;

@end

static NSString *const cellId = @"FLPictureViewerCellId";

@implementation FLPictureViewerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor blackColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)arrayAddMode:(FLPictureViewerModel *)model
{
    if(!self.allPicArray){
        self.allPicArray = [[NSMutableArray alloc] init];
    }
    [self.allPicArray addObject:model];
    return self.allPicArray.count;
}

- (void)showAllPicWithIndex:(NSInteger)index
{
    if(!self.oneCollectionView){
        
        //此处必须要有创见一个UICollectionViewFlowLayout的对象
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        self.oneCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH+20, SCREEN_HEIGHT) collectionViewLayout:layout];
        self.oneCollectionView.backgroundColor=[UIColor clearColor];
        [self.oneCollectionView setShowsVerticalScrollIndicator:NO];
        [self.oneCollectionView setShowsHorizontalScrollIndicator:NO];
        self.oneCollectionView.delegate = self;
        self.oneCollectionView.dataSource = self;
        self.oneCollectionView.pagingEnabled = YES;
        layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;//横向滑动
        [self.view addSubview:self.oneCollectionView];
        
        // 注册cell
        [self.oneCollectionView registerClass:[FLPictureViewerCell class] forCellWithReuseIdentifier:cellId];
    }
    
    if(!self.countLabel){
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
        [self.countLabel setTextAlignment:NSTextAlignmentCenter];
        [self.countLabel setTextColor:[UIColor whiteColor]];
        [self.countLabel setBackgroundColor:RGBA(0, 0, 0, 0.5)];
        self.countLabel.font = [UIFont systemFontOfSize:15];
        self.countLabel.layer.cornerRadius = 2;
        self.countLabel.clipsToBounds = YES;
        [self.view addSubview:self.countLabel];
    }
    
    if(!self.downButton){
        
        
        self.downButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, SCREEN_HEIGHT-60, 40, 40)];
        [self.downButton setBackgroundColor:RGBA(0, 0, 0, 0.5)];
        [self.downButton setImageEdgeInsets:UIEdgeInsetsMake(5.5, 7, 5.5, 7)];
        self.downButton.layer.cornerRadius = 2;
        self.downButton.layer.masksToBounds = YES;
        [self.downButton setImage:[LMYResource imageNamed:@"fx_icon_download"] forState:UIControlStateNormal];
        [self.downButton addTarget:self action:@selector(downButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.downButton];
    }
    
    
    self.curIndex = index;
    
    [self changeCountLabel];
    
    [self.oneCollectionView reloadData];
}

- (void)downButtonClick
{
    if (self.curIndex<self.allPicArray.count) {
        FLPictureViewerModel * model = (FLPictureViewerModel *)[self.allPicArray objectAtIndex:self.curIndex];
        if(self.delegate && [self.delegate respondsToSelector:@selector(downImageWithUrl:)])
        {
            [self.delegate downImageWithUrl:model.original];
        }
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (self.curIndex<self.allPicArray.count) {
            FLPictureViewerModel * model = (FLPictureViewerModel *)[self.allPicArray objectAtIndex:self.curIndex];
//            [cell showPictureReader:model];
            
            UIImage * saveImage = nil;
            NSString * md5 = model.original.md5String;
            if(!md5)
            {
            }
            UIImage * image = [UIImageView getCacheImage:md5];
            if(image)
            {
                saveImage = image;
            }
            
            NSString *path = [UIImageView defaultDir];
            path = [path stringByAppendingString:md5];
            image = [[UIImage alloc] initWithContentsOfFile:path];
            if(image)
            {
                saveImage = image;
            }
            if(saveImage)
            {
                PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];

                if (authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied) //家长控制,不允许访问、拒绝用户
                {
                    [self systemAlertControllerTitle:@"开启照片权限" message:@"您还没有开启照片权限，开启之后即可使用相册图片"];
                }
                else if(PHAuthorizationStatusNotDetermined == authStatus)////已授权本应用数据访问的照片、PHAuthorizationStatusNotDetermined) //用户还没有做出选择
                {
                    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                        if(status == PHAuthorizationStatusAuthorized) {


                            dispatch_async(dispatch_get_main_queue(), ^{

                                UIImageWriteToSavedPhotosAlbum(saveImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);//如果是相机的话 存起来
                                [MBProgressHUD showSAToast:Type_Msg msg:@"保存成功"];
                            });

                        } else {
                        }
                    }];
                }
                else
                {
                    UIImageWriteToSavedPhotosAlbum(saveImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);//如果是相机的话 存起来
                    [MBProgressHUD showSAToast:Type_Msg msg:@"保存成功"];
                }
            }else{
                 [MBProgressHUD showSAToast:Type_Msg msg:@"图片未下载完成，无法保存"];
            }
        }
        
        
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)systemAlertControllerTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    [vc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [vc addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }]];
    [self presentViewController:vc animated:YES completion:^{
    }];
}

//必要实现的协议方法, 不然会崩溃
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {

}


// MARK: - Navigation
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allPicArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 先要注册
    FLPictureViewerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.delegate = self;
    cell.viewController = self;
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row<self.allPicArray.count) {
        FLPictureViewerModel * model = (FLPictureViewerModel *)[self.allPicArray objectAtIndex:indexPath.row];
        [cell showPictureReader:model];
    }
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH+20, SCREEN_HEIGHT);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//将要显示
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
//    FLPictureViewerCell * selectCell  =  (FLPictureViewerCell *)cell;
}

//上一次cell
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [(FLPictureViewerCell *)cell reductionScale:YES];
}


// MARK: - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //滚动结束-- 重新布局
    self.curIndex = (scrollView.contentOffset.x)/(SCREEN_WIDTH+20);
    [self changeCountLabel];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.oneCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.curIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

- (void)changeCountLabel
{
    NSInteger totalPage = self.allPicArray.count;
    if (totalPage > 1)
    {
        self.countLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.curIndex+1,(long)totalPage];
        [self.countLabel setHidden:NO];
        [self.countLabel sizeToFit];
        
        CGRect rect = self.countLabel.frame;
        rect.size.width+=16;
        rect.size.height+=8;
        self.countLabel.frame = rect;
        self.countLabel.center = CGPointMake(self.view.bounds.size.width * 0.5, 20+rect.size.height*0.5);
    }else
    {
        self.countLabel.text = @"";
        [self.countLabel setHidden:YES];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



#pragma mark -  FLPictureViewerCellDelegate <NSObject>
- (void)dismissPopupViewController
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(dismissPopupViewController)])
    {
        [self.delegate dismissPopupViewController];
    }
}

@end
