//
//  FLPHAssetsController.m
//  superapp
//
//  Created by lmy on 2017/4/10.
//  Copyright © 2017年 jun. All rights reserved.
//

#import "FLPHAssetsController.h"
#import "FLPHAssetsGroupController.h"
#import "UIViewController+FLViewController.h"

@interface FLPHAssetsController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) NSMutableArray * photoArray;

@property(nonatomic,strong) UICollectionView * oneCollectionView;

@property(nonatomic,strong)UIButton * doneButton;
@property(nonatomic,strong)UILabel * countLabel;

@end


static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";


@implementation FLPHAssetsController

- (UIButton *)doneButton
{
    if (!_doneButton) {
        _doneButton = [[UIButton alloc] init];
        
    }
    _doneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_doneButton setBackgroundColor:[UIColor clearColor]];
    [_doneButton setTitle:@"确定" forState:UIControlStateNormal];
    _doneButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_doneButton addTarget:self action:@selector(doneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    return _doneButton;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        
    }
    [_countLabel setTextAlignment:NSTextAlignmentRight];
    [_countLabel setBackgroundColor:[UIColor clearColor]];
    _countLabel.font = [UIFont systemFontOfSize:14];
    _countLabel.text = [NSString stringWithFormat:@"（%lu/%ld）",(unsigned long)self.delegate.selectArray.count,(long)self.delegate.maxCount];
    _countLabel.textColor =HEX(0X999999);
    return _countLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.photoArray = [[NSMutableArray alloc] init];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc ]init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 4; //上下的间距
    
    CGFloat top = self.navigationController.navigationBar.l_height;
    self.oneCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, SCREEN_HEIGHT-top) collectionViewLayout:flowLayout];
    [self.oneCollectionView setBackgroundColor:RGBA(0xf3, 0xf3, 0xf3, 1.0)];
    [self.oneCollectionView setDelegate:self];
    [self.oneCollectionView setDataSource:self];
    [self.view addSubview:self.oneCollectionView];
    
    // 注册cell、sectionHeader、sectionFooter
    // 注册cell、sectionHeader、sectionFooter
    [self.oneCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
    
    
    if(self.delegate.isMultiselect)
    {
        self.oneCollectionView.l_height = SCREEN_HEIGHT-top - 48;
        
        UIView * bottomView =[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-48, SCREEN_WIDTH, 48)];
        [bottomView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:bottomView];
        
        self.doneButton.frame = CGRectMake(SCREEN_WIDTH-45-16, 0, 45, CGRectGetHeight(bottomView.frame));
        [bottomView addSubview:self.doneButton];
        
        self.countLabel.frame = CGRectMake(SCREEN_WIDTH-45-60, 0, 60, CGRectGetHeight(bottomView.frame));
        [bottomView addSubview:self.countLabel];
        
        if (self.delegate.selectArray.count == 0) {
            self.doneButton.enabled = NO;
            [self.doneButton setTitleColor:HEX(0X999999) forState:UIControlStateNormal];
        }else{
            [self.doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.doneButton.enabled = YES;
        }
    }
    
    NSString * title = @"相机胶卷";
    if (self.assetsGroup != nil) {
        
        title = self.assetsGroup.localizedTitle;
        
        PHFetchOptions * options = [[PHFetchOptions alloc] init];
        options.predicate =[NSPredicate predicateWithFormat:@"mediaType = %d",1];//PHAssetMediaTypeImage
        
        //获取所有资源的集合，并按资源的创建时间排序
        PHFetchResult * assetsFetchResults = [PHAsset fetchAssetsInAssetCollection:self.assetsGroup options:options];
        
        for (PHAsset *  asset in assetsFetchResults)
        {
            [self.photoArray insertObject:asset atIndex:0];
        }
    }
    
    self.navigationController.navigationBar.hidden = NO;
    self.title = title;

    [self changeLeftBarButtonItemWithImage:[LMYResource imageNamed:@"back_button_icon"] Enabled:YES];
    [self changeRightBarButtonItemWithName:@"取消" Enabled:YES];
    
    
    //刷新界面
    [self.oneCollectionView reloadData];
}

//返回按钮时间
- (void)leftBarButtonItemClick{
    [self onDefaultBack];
}
- (void)onDefaultBack
{
    if(self.delegate && self.delegate.delegate && [self.delegate.delegate respondsToSelector:@selector(onBackToAlbuml)])
    {
        [self.delegate.delegate onBackToAlbuml];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarButtonItemClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark ---- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.oneCollectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    UIImageView * iconView = [cell viewWithTag:11];
    UIImageView * selectView = [cell viewWithTag:12];
    
    if(iconView == nil){
        iconView = [[UIImageView alloc] initWithFrame:cell.bounds];
        iconView.tag = 11;
        iconView.contentMode = UIViewContentModeScaleAspectFill;
        iconView.clipsToBounds = YES;
        [cell addSubview:iconView];
    }
    
    if(selectView == nil){
        selectView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(cell.frame)-22, 2, 20, 20)];
        [selectView setBackgroundColor:[UIColor clearColor]];
        selectView.tag = 12;
        [cell addSubview:selectView];
    }
    
    
    if(indexPath.row < self.photoArray.count)
    {
        PHAsset * asset = [self.photoArray objectAtIndex:indexPath.row];
        
        PHImageManager *  manager = [PHImageManager defaultManager];
        
        PHImageRequestOptions * option = [[PHImageRequestOptions alloc] init];
        [option setSynchronous:YES];
        [manager requestImageForAsset:asset targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            iconView.image = result;
        }];
        
        
        if(!self.delegate.isMultiselect)
        {
            [selectView setHidden:YES];
        }else{
            [selectView setHidden:NO];
            if([self.delegate.selectArray containsObject:asset]){
                [selectView setImage:[LMYResource imageNamed:@"FL_Album_Selected"]];
            }else{
                [selectView setImage:[LMYResource imageNamed:@"FL_Album_Unchecked"]];
            }
        }
    }
    
    return cell;
}

// cell点击变色
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//设置每个 UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - 20)/4, (SCREEN_WIDTH - 20)/4);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(4, 4, 46,4);
}

//定义每个UICollectionView 的纵向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 4;
}

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.photoArray.count)
    {
        PHAsset * asset = [self.photoArray objectAtIndex:indexPath.row];

        CGFloat w = asset.pixelWidth;
        CGFloat h = asset.pixelHeight;
        if (w<1) {
            w=1;
        }
        if (h<1) {
            h=1;
        }

        if(self.delegate.isLimitImageSize && (w*h>4096*4096 || w>4096*4 || h>4096*4)){
            [MBProgressHUD showSAToast:Type_Msg msg:@"图片过大，不能使用"];
            return;
        }
        if([self.delegate.selectArray containsObject:asset]){
            [self.delegate.selectArray removeObject:asset];
        }else{
            
            if(self.delegate.selectArray.count < self.delegate.maxCount){
                
                [self.delegate.selectArray addObject:asset];
            }else{
                [MBProgressHUD showSAToast:Type_Msg msg:[NSString stringWithFormat:@"最多只能选%ld张",(long)self.delegate.maxCount]];
                return;
            }
        }
        
        [self.oneCollectionView reloadData];
        
        if(!self.delegate.isMultiselect){
            [self doneButtonClick];
            [self.delegate.selectArray removeAllObjects];
        }else{
            [self reloadSelectCount];
        }
    }
}


- (void)reloadSelectCount
{
    if(self.countLabel){
        self.countLabel.text = [NSString stringWithFormat:@"（%lu/%ld）",(unsigned long)self.delegate.selectArray.count,(long)self.delegate.maxCount];
    }
    if (self.delegate.selectArray.count == 0) {
        self.doneButton.enabled = NO;
        [self.doneButton setTitleColor:HEX(0X999999) forState:UIControlStateNormal];
    }else{
        self.doneButton.enabled = YES;
        [self.doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

//- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//// cell点击变色
//- (void)collectionView:(UICollectionView *)colView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = [colView cellForItemAtIndexPath:indexPath];
//    [cell setBackgroundColor:UIColorFromRGB(0xE6E6E6)];
//}


- (void)doneButtonClick{
    
    if(self.delegate && self.delegate.delegate && [self.delegate.delegate respondsToSelector:@selector(imageFLPHAssets:didFinished:)])
    {
        [self.delegate.delegate imageFLPHAssets:self.delegate didFinished:self.delegate.selectArray];
    }
}
@end
