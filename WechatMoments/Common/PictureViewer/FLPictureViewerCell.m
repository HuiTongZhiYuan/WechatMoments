//
//  FLPictureViewerCell.m
//  Common
//
//  Created by lmy on 2017/5/9.
//  Copyright © 2017年 oiio. All rights reserved.
//

#import "FLPictureViewerCell.h"
#import "FLPictureViewerController.h"
#import "UIImageView+FLCommon.h"
#import "FLWaitingView.h"
#import "NSString+md5.h"
#import "UIImageView+FLCommon.h"

@interface FLPictureViewerCell() <UIScrollViewDelegate>

@property (nonatomic,strong) FLWaitingView *waitingView;
@property (nonatomic,strong) UIScrollView *scrollview;
@property (nonatomic,strong) UIImageView *imageview;
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign) BOOL beginLoadingImage;


@property (nonatomic,strong) UITapGestureRecognizer *doubleTap;
@property (nonatomic,strong) UITapGestureRecognizer *singleTap;
@property (nonatomic,strong) UILongPressGestureRecognizer * longPress;

@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, strong) UIButton *reloadButton;
@property (nonatomic, assign) BOOL isLoading;

@property(nonatomic,strong)FLPictureViewerModel * picModel;

@end

@implementation FLPictureViewerCell

- (void)showPictureReader:(FLPictureViewerModel *)model
{
    self.picModel = model;
    
    [self reductionScale:YES];
    
    [self setImageWithURL:model.original placeholderImage:[LMYResource imageNamed:@"fl_pic_cktp_mr"]];
}

- (void)reductionScale:(BOOL)animated
{
    [self.scrollview setZoomScale:1.0 animated:animated];//还原
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollview];
        
        self.isLoading = NO;//图片暂未加载
        
        //添加单双击事件、长按事件
        [self.scrollview addGestureRecognizer:self.doubleTap];
        [self.scrollview addGestureRecognizer:self.singleTap];
//        [self addGestureRecognizer:self.longPress];
        
        //添加进度指示器
        self.waitingView= [[FLWaitingView alloc] init];
        self.waitingView.mode = FLWaitingViewModeLoopDiagram;
        self.waitingView.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5);
        [self addSubview:self.waitingView];
        [self.waitingView setHidden:YES];
    }
    return self;
}

- (UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_scrollview addSubview:self.imageview];
        _scrollview.delegate = self;
        _scrollview.clipsToBounds = YES;
    }
    return _scrollview;
}

- (UIImageView *)imageview
{
    if (!_imageview) {
        _imageview = [[UIImageView alloc] init];
        _imageview.contentMode = UIViewContentModeScaleAspectFit;
//        _imageview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [_imageview setBackgroundColor:[UIColor clearColor]];
        _imageview.userInteractionEnabled = YES;
    }
    return _imageview;
}

- (UITapGestureRecognizer *)doubleTap
{
    if (!_doubleTap) {
        _doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        _doubleTap.numberOfTapsRequired = 2;
        _doubleTap.numberOfTouchesRequired  =1;
    }
    return _doubleTap;
}

- (UITapGestureRecognizer *)singleTap
{
    if (!_singleTap) {
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        _singleTap.numberOfTapsRequired = 1;
        _singleTap.numberOfTouchesRequired = 1;
        _singleTap.delaysTouchesBegan = YES;
        //只能有一个手势存在
        [_singleTap requireGestureRecognizerToFail:self.doubleTap];
    }
    return _singleTap;
}

- (UILongPressGestureRecognizer *)longPress
{
    if (!_longPress) {
        
        _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:_longPress];
        _longPress.minimumPressDuration = 0.2; //需要长按的时间，最小0.5s
    }
    return _longPress;
}

#pragma mark 双击
- (void)handleDoubleTap:(UITapGestureRecognizer *)recognizer
{
    //图片加载完之后才能响应双击放大
    if (!self.isLoading) {
        return;
    }
    CGPoint touchPoint = [recognizer locationInView:self];
    if (self.scrollview.zoomScale <= 1.0) {
        
        CGFloat scaleX = touchPoint.x + self.scrollview.contentOffset.x;//需要放大的图片的X点
        CGFloat sacleY = touchPoint.y + self.scrollview.contentOffset.y;//需要放大的图片的Y点
        [self.scrollview zoomToRect:CGRectMake(scaleX, sacleY, 10, 10) animated:YES];
        
    } else {
        [self.scrollview setZoomScale:1.0 animated:YES]; //还原
    }
    
}
#pragma mark 单击
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(dismissPopupViewController)])
    {
        [self.delegate dismissPopupViewController];
    }
}

// MARK: - 长摁事件
- (void)longPress:(UILongPressGestureRecognizer * )sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {

        if (self.imageview.image) {

            if(self.viewController){
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

                }];

                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    UIImageWriteToSavedPhotosAlbum(self.imageview.image, nil, nil, nil);//如果是相机的话 存起来
                    [MBProgressHUD showSAToast:Type_Msg msg:@"保存成功"];
                }];
                [alertController addAction:cancelAction];
                [alertController addAction:otherAction];
                [self.viewController presentViewController:alertController animated:YES completion:nil];
            }
        }else{
            [MBProgressHUD showSAToast:Type_Msg msg:@"图片未下载完成，无法保存"];
        }
    }
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    _waitingView.progress = progress;
}

- (void)setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder
{
    if (_reloadButton) {
        [_reloadButton removeFromSuperview];
    }
    _imageUrl = [NSURL URLWithString:url];

    
    NSString * md5 = url.md5String;
    if(!md5)
    {
        [self defaultImageWithName:@"fl_pic_cktp_mr"];
        self.isLoading = YES;//图片加载成功
        [self adjustFrame];
        return;
    }
    UIImage * image = [UIImageView getCacheImage:md5];
    if(image)
    {
        [_imageview setImage:image];
        self.isLoading = YES;//图片加载成功
        [self adjustFrame];
        return;
    }
    
    NSString *path = [UIImageView defaultDir];
    path = [path stringByAppendingString:md5];
    image = [[UIImage alloc] initWithContentsOfFile:path];
    if(image)
    {
        [_imageview setImage:image];
        [UIImageView saveImageToCache:md5 image:image];
        self.isLoading = YES;//图片加载成功
        [self adjustFrame];
        return;
    }
    
    //添加进度指示器
    [self.waitingView setHidden:NO];
    
    //下载
    [self defaultImageWithName:@"fl_pic_cktp_mr"];
   
    
    __weak __typeof(self)weakSelf = self;
    
    [_imageview sd_setHighlightedImageWithURL:_imageUrl options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.waitingView.progress = (CGFloat)receivedSize / expectedSize;
        
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        
        [strongSelf.waitingView setHidden:YES];
        
        if (error) {
            //图片加载失败的处理，此处可以自定义各种操作（...）
            [strongSelf defaultImageWithName:@"fl_pic_cktp_shibai"];
            [strongSelf adjustFrame];
            
            //            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            //            [button setBackgroundColor:[UIColor clearColor]];
            //            button.frame = self.bounds;
            //            strongSelf.reloadButton = button;
            //            [button addTarget:strongSelf action:@selector(reloadImage) forControlEvents:UIControlEventTouchUpInside];
            //
            //            [strongSelf addSubview:button];
            
            return;
        }else{
            
            [UIImageView saveImageToCache:md5 image:image];
            [UIImageView fl_saveImage:url image:image];
            
            [self.imageview setImage:image];
            [strongSelf adjustFrame];
        }
        strongSelf.isLoading = YES;//图片加载成功
        
    }];
}


- (void)defaultImageWithName:(NSString *)name
{
    UIImage * image = [LMYResource imageNamed:name];
    if (image) {
        [_imageview setImage:image];
    }
    [self adjustFrame];
}


- (void)reloadImage
{
    [self showPictureReader:self.picModel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self adjustFrame];
}

- (void)adjustFrame
{
    CGRect frame = self.scrollview.frame;
    if (self.imageview.image) {
        CGSize imageSize = self.imageview.image.size;//获得图片的size
        CGRect imageFrame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        if (kIsFullWidthForLandScape) {//图片宽度始终==屏幕宽度(新浪微博就是这种效果)
            CGFloat ratio = frame.size.width/imageFrame.size.width;
            imageFrame.size.height = imageFrame.size.height*ratio;
            imageFrame.size.width = frame.size.width;
        } else{
            if (frame.size.width<=frame.size.height) {
                //竖屏时候
                CGFloat ratio = frame.size.width/imageFrame.size.width;
                imageFrame.size.height = imageFrame.size.height*ratio;
                imageFrame.size.width = frame.size.width;
            }else{ //横屏的时候
                CGFloat ratio = frame.size.height/imageFrame.size.height;
                imageFrame.size.width = imageFrame.size.width*ratio;
                imageFrame.size.height = frame.size.height;
            }
        }
        
        self.imageview.frame = imageFrame;
        
        self.scrollview.contentSize = self.imageview.frame.size;
        self.imageview.center = [self centerOfScrollViewContent:self.scrollview];
        
        //根据图片大小找到最大缩放等级，保证最大缩放时候，不会有黑边
        CGFloat maxScale = frame.size.height/imageFrame.size.height;
        maxScale = frame.size.width/imageFrame.size.width>maxScale?frame.size.width/imageFrame.size.width:maxScale;
        //超过了设置的最大的才算数
        maxScale = maxScale>kMaxZoomScale?maxScale:kMaxZoomScale;
        //初始化
        self.scrollview.minimumZoomScale = kMinZoomScale;
        self.scrollview.maximumZoomScale = maxScale;
        self.scrollview.zoomScale = 1.0f;
    }else{
        frame.origin = CGPointZero;
        self.imageview.frame = frame;
        //重置内容大小
        self.scrollview.contentSize = self.imageview.frame.size;
    }
    self.scrollview.contentOffset = CGPointZero;
    
}

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}

#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageview;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView //这里是缩放进行时调整
{
    self.imageview.center = [self centerOfScrollViewContent:scrollView];
    
}
//
//- (void)downOriginalImage
//{
//    //下载原图
//    [MBProgressHUD showSAToast:Type_Loading msg:nil];
//    
//    [[SDWebImageManager sharedManager]  downloadImageWithURL:[NSURL URLWithString:picModel.original] options:0
//                                                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                                                        
//                                                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                                                        if(finished && image)
//                                                        {
//                                                            imageView.image = image;
//                                                            
//                                                            NSString * md5 = picModel.original.md5String;
//                                                            [UIImageView saveImageToCache:md5 image:image];
//                                                            
//                                                            [self setImageInitFrame];
//                                                        }
//                                                        
//                                                        [MBProgressHUD dismissSAToast];
//                                                    }];
//    
//}
//
//- (void)showPictureReader:(FLPictureViewerModel *)model
//{
//    picModel = model;
//    
//    scrollView.userInteractionEnabled = NO;
//    
//    if([picModel.original isEqualToString:@""] && [picModel.thumbnail isEqualToString:@""])
//    {
//        [imageView setBackgroundColor:[FLColorConfig colorTextLightGray]];
//        imageView.frame = CGRectMake(DP0, DP80, ScreenWidth, ScreenHeight-DP160);
//    }
//    else
//    {
//        //判断原图是否存在
//        BOOL isHaveOriginal = false;
//        NSString * md5 = picModel.original.md5String;
//        if(md5)
//        {
//            UIImage * image = [UIImageView getCacheImage:md5];
//            if(image)
//            {
//                isHaveOriginal = true;
//                imageView.image = image;
//                [self setImageInitFrame];
//                return;
//            }
//        }
//        
//        if(!isHaveOriginal)
//        {
//            //下载缩略图
//            BOOL isHaveThumbnail = false;
//            md5 = picModel.thumbnail.md5String;
//            if(md5)
//            {
//                UIImage * image = [UIImageView getCacheImage:md5];
//                if(image)
//                {
//                    isHaveThumbnail = true;
//                    imageView.image = image;
//                    [self setImageInitFrame];
//                }
//            }
//            
//            if(!isHaveThumbnail)
//            {
//                [imageView setBackgroundColor:[FLColorConfig colorTextLightGray]];
//                imageView.frame = CGRectMake(DP0, DP80, ScreenWidth, ScreenHeight-DP160);
//                
//                //下载缩略图
//                [[SDWebImageManager sharedManager]  downloadImageWithURL:[NSURL URLWithString:picModel.thumbnail] options:0
//                                                                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                 
//                                                                         } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                                                                             if(finished && image)
//                                                                             {
//                                                                                 imageView.image = image;
//                                                                                 [UIImageView saveImageToCache:md5 image:image];
//                                                                                 [self setImageInitFrame];
//                                                                                 
//                                                                                 [self downOriginalImage];
//                                                                             }
//                                                                         }];
//            }
//            else{
//                [self downOriginalImage];
//            }
//            
//        }
//    }
//}

@end
