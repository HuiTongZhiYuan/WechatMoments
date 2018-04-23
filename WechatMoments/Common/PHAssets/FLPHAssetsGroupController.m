//
//  FLPHAssetsGroupController.m
//  superapp
//
//  Created by lmy on 2017/4/10.
//  Copyright © 2017年 jun. All rights reserved.
//

#import "FLPHAssetsGroupController.h"
#import "FLPHAssetsController.h"
#import <Photos/Photos.h>
#import "UIViewController+FLViewController.h"

@interface FLPHAssetsGroupCell:UITableViewCell

@end


@implementation FLPHAssetsGroupCell

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame =CGRectMake(0, 0, 75, 75);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    
    self.textLabel.frame = CGRectMake(91, 0, SCREEN_WIDTH - 91, 75);
}
@end




@interface FLPHAssetsGroupController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * groupTableView;

@property(nonatomic,strong) NSMutableArray * phAlbums;

@property(nonatomic,strong)PHFetchOptions * options;



@end

@implementation FLPHAssetsGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.maxCount < 2){
        self.maxCount = 1;
    }
    // Do any additional setup after loading the view.
    self.selectArray = [[NSMutableArray alloc] init];
    
    self.title = @"相册";
    
    [self changeRightBarButtonItemWithName:@"取消" Enabled:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGFloat top = self.navigationController.navigationBar.l_height;
    _groupTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, SCREEN_HEIGHT-top) style:UITableViewStyleGrouped];
    [_groupTableView setDelegate:self];
//    _groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_groupTableView setDataSource:self];
    _groupTableView.estimatedRowHeight = 0;
    _groupTableView.estimatedSectionHeaderHeight = 0;
    _groupTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_groupTableView];
    
    self.phAlbums = [[NSMutableArray alloc] init];
    
    //只取照片
    self.options = [[PHFetchOptions alloc] init];
    self.options.predicate =[NSPredicate predicateWithFormat:@"mediaType = %d",1];//PHAssetMediaTypeImage
    
    
    //子线程中开始网络请求数据
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if(status == PHAuthorizationStatusAuthorized) {
                
                [self loadAlbums];
                
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 用户点击 不允许访问
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                });
            }
        }];
    }else{
        [self loadAlbums];
    }
}

- (void)loadAlbums
{
    //获取所有照片--并默认打开  本界面刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        [self.phAlbums removeAllObjects];
        
        /*************************  列出所有系统智能相册  **********************************/
        // 所有智能相册
        PHFetchResult * smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        for (NSInteger i = 0; i < smartAlbums.count; i++) {
            PHCollection *collection = smartAlbums[i];
            //遍历获取相册
            if ([collection isKindOfClass:[PHAssetCollection class]]) {
                PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
                
                //查询照片数大于0的
                PHFetchResult * assetsFetchResults = [PHAsset fetchAssetsInAssetCollection:assetCollection options:self.options];
                if(assetsFetchResults.count > 0)
                {
                    if([assetCollection.localizedTitle isEqualToString:@"相机胶卷"] || [assetCollection.localizedTitle isEqualToString:@"所有照片"]){
                        [self.phAlbums insertObject:assetCollection atIndex:0];
                    }
                    else{
                        [self.phAlbums addObject:assetCollection];
                    }
                }
            }
        }
        
        
        /****************************  列出所有用户创建的相册  ******************************/
        PHFetchResult * userAlbums = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:nil];
        for (NSInteger i = 0; i < userAlbums.count; i++) {
            PHCollection *collection = userAlbums[i];
            //遍历获取相册
            if ([collection isKindOfClass:[PHAssetCollection class]]) {
                PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
                
                //查询照片数大于0的
                PHFetchResult * assetsFetchResults = [PHAsset fetchAssetsInAssetCollection:assetCollection options:self.options];
                if(assetsFetchResults.count > 0)
                {
                    [self.phAlbums addObject:assetCollection];
                }
            }
        }
        
        
    
        
        if (self.phAlbums.count>0)
        {
            PHAssetCollection * album = self.phAlbums[0];
            
            FLPHAssetsController * pushCtl = [[FLPHAssetsController alloc] init];
            pushCtl.delegate = self;
            pushCtl.assetsGroup = album;
            [self.navigationController pushViewController:pushCtl animated:NO];
        }
        
        [self.groupTableView reloadData];

    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBarButtonItemClick
{
    
}

- (void)rightBarButtonItemClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
//返回有多少个Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.phAlbums.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * showDisplayListCell = @"ShowDisplayListCell";
    FLPHAssetsGroupCell * cell = [self.groupTableView dequeueReusableCellWithIdentifier:showDisplayListCell];
    
    if (cell == nil)
    {
        cell = [[FLPHAssetsGroupCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:showDisplayListCell];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row < self.phAlbums.count)
    {
        PHAssetCollection * assetCollection = self.phAlbums[indexPath.row];
        
        // 从每一个智能相册中获取到的 PHFetchResult 中包含的才是真正的资源（PHAsset）
        PHFetchResult * assetsFetchResults = [PHAsset fetchAssetsInAssetCollection:assetCollection options:self.options];
        
        //获取第一章图片作为icon
        PHAsset * asset = assetsFetchResults.lastObject;
        
        PHImageManager *  manager = [PHImageManager defaultManager];
        
        PHImageRequestOptions * option = [[PHImageRequestOptions alloc] init];
        [option setSynchronous:YES];
        [manager requestImageForAsset:asset targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            cell.imageView.image = result;
        }];
        
        NSString * name = FLString(assetCollection.localizedTitle, @"");
        NSString * count = [NSString stringWithFormat:@"（%lu）",(unsigned long)assetsFetchResults.count];
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:name];
        [string appendAttributedString:[[NSAttributedString alloc] initWithString:count]];
        [string addAttribute:NSForegroundColorAttributeName value:RGB(0x99, 0x99, 0x99) range:NSMakeRange(0, string.length)];
        [string addAttribute:NSForegroundColorAttributeName value:RGB(0x33, 0x33, 0x33) range:NSMakeRange(0, name.length)];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, string.length)];
        
        cell.textLabel.attributedText = string;
//        nameLabel.attributedText = string;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row < self.phAlbums.count)
    {
        PHAssetCollection * album = self.phAlbums[indexPath.row];
        
        FLPHAssetsController * pushCtl = [[FLPHAssetsController alloc] init];
        pushCtl.delegate = self;
        pushCtl.assetsGroup = album;
        [self.navigationController pushViewController:pushCtl animated:YES];
    }
}

//Setup your cell margins:
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 75, 0, 0)];
    }
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 275, 0, 0)];
    }
}
@end
