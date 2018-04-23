//
//  MomentsViewController.m
//  WechatMoments
//
//  Created by lmy on 2018/4/12.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "MomentsViewController.h"
#import "UIBarButtonItem+MHExtension.h"
#import "LCActionSheet+MHExtension.h"
#import "MomentsHeadView.h"
#import "MomentsModel.h"
#import "CommentModel.h"
#import "MomentsPostView.h"
#import "LMYRefreshFooter.h"
#import "MometsCommentCell.h"
#import "MomentsFooterView.h"

#import <Photos/Photos.h>
#import "FLPHAssetsGroupController.h"
#import "UIImage+FLCommon.h"
#import "FabulousCommentView.h"



static NSString * CellIdentifier = @"discoverListTableViewCellIdentifier";
static NSString * PostViewIdentifier = @"MomentsPostViewIdentifier";
static NSString * FooterViewIdentifier = @"MomentsFooterViewIdentifier";

@interface MomentsViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,FLPHAssetsGroupControllerDelegate,MomentsPostViewDelegate>//

@property(nonatomic,assign) BOOL isLoading;
@property(nonatomic,assign) BOOL allowDropdown;

@property(nonatomic,strong) UIView * topBackView;
@property(nonatomic,strong) UITableView * momentsTableView;
@property(nonatomic,strong)MomentsHeadView * headView;
@property(nonatomic,strong) UIImageView * loadingImageView;


@property(nonatomic,strong)NSMutableArray * mArray;

@property(nonatomic,assign)NSInteger pageCount; //每页显示属性

@property (nonatomic,strong) LMYRefreshFooter * footer;//上拉加载更多

@property(nonatomic,strong)UIButton * markButton;//遮罩
@property(nonatomic,strong)FabulousCommentView * fabulousCommentView;//评论控制器

@end

@implementation MomentsViewController


#pragma mark - 创建上拉加载更多
- (void)creatLMYRefreshFooter
{
    if (_footer == nil)
    {
        _footer = [[LMYRefreshFooter alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60) target:self refreshingAction:@selector(loadMoreData)];
        _footer.isAutoLoading = YES;
        [_footer setState:LMYRefreshStateRefreshed];
    }
}


#pragma mark - 模拟加载更多
- (void)loadMoreData
{
    [_footer setState:LMYRefreshStateRefreshing];
    
     @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
         @strongify(self);
        
        self.pageCount+=5;
        if (self.pageCount > self.mArray.count) {
            self.pageCount = self.mArray.count;
        }
        [self.momentsTableView reloadData];
        
        if (self.pageCount == self.mArray.count) {
            [self.footer setState:LMYRefreshStateNoMoreData];
        }else{
            [self.footer setState:LMYRefreshStateNormal];
        }
    });
}

#pragma mark - 初始化道导航栏
- (void)setupNavigationItem{
//    @weakify(self);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem mh_systemItemWithTitle:nil titleColor:nil imageName:@"barbuttonicon_Camera_30x30" target:nil selector:nil textType:NO];
    self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//        @strongify(self);
        LCActionSheet *sheet = [LCActionSheet sheetWithTitle:nil cancelButtonTitle:@"取消" clicked:^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
            if (buttonIndex == 0) return ;
            else if (buttonIndex == 1)//拍照
            {
//                //判断相机是否能够使用
//                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//                if(status == AVAuthorizationStatusAuthorized ) {
//                    [self triggerCamera];
//                    // authorized
//                } else if(status == AVAuthorizationStatusDenied || status ==  AVAuthorizationStatusRestricted){
//                    // denied
//                    [self showNoCameraAccessPermission];
//                } else if(status == AVAuthorizationStatusNotDetermined){
//                    // not determined
//                    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
//                        if(granted){
//                            [self triggerCamera];
//                        } else {
//                            [self showNoCameraAccessPermission];
//                        }
//                    }];
//                }
            }
            else if (buttonIndex == 2)//相册选择
            {
//                PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
//
//                if (authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied) //家长控制,不允许访问、拒绝用户
//                {
//                    [self showNoPhotoAccessPermission];
//                }
//                else //if (authStatus == PHAuthorizationStatusAuthorized)//已授权本应用数据访问的照片、PHAuthorizationStatusNotDetermined) //用户还没有做出选择
//                {
//                    FLPHAssetsGroupController *vc = [[FLPHAssetsGroupController alloc] init];
//                    vc.isLimitImageSize = NO;
//                    vc.isMultiselect = YES;
//                    vc.maxCount = 9;
//                    vc.delegate = self;
//                    LMYNavigationController * navc = [[LMYNavigationController alloc] initWithRootViewController:vc];
//                    navc.navigationBar.hidden = YES;
//                    navc.navigationBar.translucent = YES;
//                    navc.toolbar.translucent = YES;
//                    [self presentViewController:navc animated:YES completion:nil];
//                }
            }
        } otherButtonTitles:@"拍照",@"相册选择", nil];
        [sheet show];
        return [RACSignal empty];
    }];
}


- (void)showNoCameraAccessPermission
{
    [self systemAlertControllerTitle:@"开启相机权限" message:@"您还没有开启相机权限，开启之后即可使用相机拍照"];
}

- (void)showNoPhotoAccessPermission
{
    [self systemAlertControllerTitle:@"开启照片权限" message:@"您还没有开启照片权限，开启之后即可使用相册图片"];
}

- (void)triggerCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    ipc.allowsEditing = NO;
    [self presentViewController:ipc animated:YES completion:nil];
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

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:info];
    UIImage * orgImage =  [dict objectForKey:UIImagePickerControllerOriginalImage];
    UIImage * aimage = [UIImage fixOrientation:orgImage];
    
   //拍照结束-----
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - FLPHAssetsGroupControllerDelegate自定义相片选择器
- (void)imageFLPHAssets:(FLPHAssetsGroupController *)cropperViewController didFinished:(NSArray *)imageArray
{
    if(imageArray.count>0)
    {
        PHAsset * asset = [imageArray objectAtIndex:0];
        
        PHImageManager *  manager = [PHImageManager defaultManager];
        
        PHImageRequestOptions * option = [[PHImageRequestOptions alloc] init];
        [option setSynchronous:YES];
        [manager requestImageForAsset:asset targetSize:CGSizeMake(960, 960) contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            //选完照片------
            
            
            [cropperViewController dismissViewControllerAnimated:NO completion:nil];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pageCount = 5;
    
    _mArray = [[NSMutableArray alloc] init];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if (@available(iOS 11.0, *)) {
        
        self.momentsTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.title = [LMYResource LMY_Localized:@"Moments"];
    
    [self setupNavigationItem];
    
    [self addTabelView];
    
    Class myClass = [MometsCommentCell class];
    [self.momentsTableView registerClass: myClass forCellReuseIdentifier:CellIdentifier];
      [self.momentsTableView registerClass:[MomentsPostView class] forHeaderFooterViewReuseIdentifier:PostViewIdentifier];
      [self.momentsTableView registerClass:[MomentsFooterView class] forHeaderFooterViewReuseIdentifier:FooterViewIdentifier];
    
    
    //添加loading视图
    [self addLoadingView];
    
    //读取缓存
    [self readCaching];
    
    //获取内容
    self.isLoading = NO;
    [self readMoments];
    
    //添加下拉刷新
    [self creatLMYRefreshFooter];
    self.momentsTableView.tableFooterView = self.footer;
    
    _momentsTableView.estimatedRowHeight = 0;
    _momentsTableView.estimatedSectionHeaderHeight = 0;
    _momentsTableView.estimatedSectionFooterHeight = 0;
}

- (void)addLoadingView
{
    _loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (LMY_NavHeight-30), 30, 30)];
    [_loadingImageView setImage:[LMYResource imageNamed:@"AlbumReflashIcon"]];
    [self.view addSubview:_loadingImageView];
}

#pragma mark - 添加TabelView
- (void)addTabelView
{
    _topBackView = [[UIView alloc] init];
    [_topBackView setBackgroundColor:RGB_51];
    [_topBackView setHidden:YES];
    [self.view addSubview:_topBackView];
    
    _momentsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    _momentsTableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    [_momentsTableView setDelegate:self];
    [_momentsTableView setDataSource:self];
    [self.view addSubview:_momentsTableView];
    
    _momentsTableView.backgroundColor = [UIColor clearColor];
    
    _headView = [[MomentsHeadView alloc] init];
    [self.view addSubview:_headView];
    
    _momentsTableView.tableHeaderView = _headView;
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    

    [_topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(-kHeadHeight);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(self.view.mas_width);
    }];
    
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.view.mas_width).mas_offset(-kHeadHeight-LMY_NavHeight+50);
    }];
    
    //使用Auto Layout约束，禁止将Autoresizing Mask转换为约束
    [_momentsTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *contraint1 = [NSLayoutConstraint constraintWithItem:_momentsTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:LMY_NavHeight];
    NSLayoutConstraint *contraint2 = [NSLayoutConstraint constraintWithItem:_momentsTableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *contraint3 = [NSLayoutConstraint constraintWithItem:_momentsTableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *contraint4 = [NSLayoutConstraint constraintWithItem:_momentsTableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    
    NSArray *array = [NSArray arrayWithObjects:contraint1, contraint2, contraint3, contraint4, nil];
    [self.view addConstraints:array];
    
    [self.momentsTableView reloadData];
}

#pragma mark - 滚动代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset = scrollView.contentOffset.y;
    
    if (yOffset <= 0) {
        [self.topBackView setHidden:NO];
        
        if ( self.allowDropdown)
        {
            //动画下拉刷新
            CGFloat moveY = -yOffset;
            if (moveY > 60) {
                moveY = 60;
            }
            _loadingImageView.frame = CGRectMake(20, (LMY_NavHeight-30) + moveY, 30, 30);
            
            _loadingImageView.transform = CGAffineTransformRotate(_loadingImageView.transform, -M_PI);
        }
    }else{
        [self.topBackView setHidden:YES];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
     self.allowDropdown = YES;
    NSLog(@"-=-=-=-=-=-  11111");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset <= -60) {
        
         self.allowDropdown = NO;
        
        self.pageCount = 5;
        [self readMoments];
    }
}

#pragma mark - 读取缓存
- (void)readCaching
{
    NSString * filePath = [NSString stringWithFormat:@"%@/moment_list_%@.data",CachesDirectoryPath,[LMYUserLoginModel shareInstance].uid];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        NSArray * listArray = [[NSArray alloc] initWithContentsOfFile:filePath];
        
        if (listArray && [listArray isKindOfClass:[NSArray class]]) {
            
            [self addArray:listArray];
        }
    }
}
#pragma mark - 获取数据
- (void)readMoments
{
    self.allowDropdown = NO;
    _loadingImageView.frame = CGRectMake(20, (LMY_NavHeight-30) + 60, 30, 30);
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = GID_MAX;
    [_loadingImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    if ( self.isLoading) {
        return;
    }
    
     self.isLoading = YES;
    
    @weakify(self);
    [[LMYInterface sharedInstance] user_jsmith_tweets_success:^(id result) {
        
         @strongify(self);
        [self hidenToast];
        
        [self.mArray removeAllObjects];
        if ([result isKindOfClass: [NSArray class]])
        {
            
            NSString * filePath = [NSString stringWithFormat:@"%@/moment_list_%@.data",CachesDirectoryPath,[LMYUserLoginModel shareInstance].uid];
            [result writeToFile:filePath atomically:YES];
            
            [self addArray:result];
            return ;
        }
        
        [MBProgressHUD showSAToast:Type_Msg msg:@"获取失败"];
        [self.footer setState:LMYRefreshStateNormal];
         self.isLoading = NO;
        [self endLoadingView];
    } failure:^(NSError *error) {
        [self failureNetworkAnomaly];
         self.isLoading = NO;
        [self endLoadingView];
    }];
}

- (void)addArray:(NSArray *)array
{
     [MomentsModel formatArray:array addArray:self.mArray];
    
    self.pageCount = 5;
    if (self.pageCount > self.mArray.count) {
        self.pageCount = self.mArray.count;
    }
    
    [self.momentsTableView reloadData];
    [self.footer setState:LMYRefreshStateNormal];
    self.isLoading = NO;
    [self endLoadingView];
}

- (void)endLoadingView{
    [_loadingImageView.layer removeAllAnimations];
    [UIView animateWithDuration:0.3 animations:^{
         self.loadingImageView.frame = CGRectMake(20, (LMY_NavHeight-30), 30, 30);
    }];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.pageCount > self.mArray.count) {
        return self.mArray.count;
    }
    return self.pageCount;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MomentsModel * model = [self.mArray objectAtIndex:section];
    return model.comments.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    MomentsModel * model = [self.mArray objectAtIndex:section];
    return model.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 16;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MomentsPostView * momentsView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:PostViewIdentifier];
    momentsView.delegate = self;
    momentsView.section = section;
    
    if (section < self.mArray.count) {
        
        MomentsModel * model = [self.mArray objectAtIndex:section];
        [momentsView showMomentsPostView:model];
    }
    NSLog(@"-=-=-=-=-=-=-=-= <%@>",momentsView);
    return momentsView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    MomentsFooterView * footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FooterViewIdentifier];
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.mArray.count) {
        MomentsModel * mModel = [self.mArray objectAtIndex:indexPath.section];
        
        if (indexPath.row < mModel.comments.count) {
            CommentModel * cModel = [mModel.comments objectAtIndex:indexPath.row];
            return cModel.height;
        }
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MometsCommentCell *cell = [self.momentsTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    
    if (indexPath.section < self.mArray.count) {
        MomentsModel * mModel = [self.mArray objectAtIndex:indexPath.section];
        
        if (indexPath.row < mModel.comments.count) {
            CommentModel * cModel = [mModel.comments objectAtIndex:indexPath.row];
            [cell showMometsCommentCell:cModel];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);
    cell.preservesSuperviewLayoutMargins = NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - MomentsPostViewDelegate <NSObject>
//遮罩
- (UIButton *)markButton
{
    if (!_markButton) {
        UIButton * markButton = [[UIButton alloc] init];
        [markButton addTarget:self action:@selector(markButtonClick) forControlEvents:UIControlEventTouchUpInside];
        markButton.alpha = 0.0;
        
        [markButton setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:_markButton = markButton];
        
        [markButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left);
            make.top.mas_equalTo(self.view.mas_top);
            make.right.mas_equalTo(self.view.mas_right);
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }];
    }
    return _markButton;
}

- (FabulousCommentView *)fabulousCommentView
{
    if (!_fabulousCommentView) {
        FabulousCommentView * fabulousCommentView = [[FabulousCommentView alloc] initWithFrame:CGRectMake(0,0,164,36)];
        fabulousCommentView.alpha = 0.0;
        fabulousCommentView.layer.cornerRadius = 4;
        fabulousCommentView.layer.masksToBounds = YES;
        [fabulousCommentView setBackgroundColor:RGB_51];
        [self.view addSubview:_fabulousCommentView = fabulousCommentView];
    }
    return _fabulousCommentView;
}


- (void)controlButtonClick:(NSInteger)section but:(UIButton *)sender
{
    if (self.fabulousCommentView.alpha == 1.0) {
        [self markButtonClick];
        return;
    }
    [self.markButton setAlpha:1.0];
    
    [self.view bringSubviewToFront:self.fabulousCommentView];
    
    
    CGRect rect=[sender convertRect:sender.bounds toView:self.view];
    
    self.fabulousCommentView.frame = rect;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.fabulousCommentView setAlpha:1.0];
        
        self.fabulousCommentView.frame = CGRectMake(rect.origin.x - 168, rect.origin.y-5, 164, 34);
    }];
}

- (void)markButtonClick
{
    [self.markButton setAlpha:0];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.fabulousCommentView setAlpha:0];
        
        self.fabulousCommentView.frame = CGRectMake(SCREEN_WIDTH-30, self.fabulousCommentView.l_top+17, 0, 0);
    }];
}
@end
