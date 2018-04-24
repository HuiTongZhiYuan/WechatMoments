//
//  MomentImagesView.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/13.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "MomentImagesView.h"
#import "LMYImageButton.h"
#import "FLPictureViewerController.h"
#import "AppDelegate.h"
#import "UIViewController+MJPopupViewController.h"


@interface MomentImagesView ()<LMYImageButtonDelegate,FLPictureViewerControllerDelegate>

@property(nonatomic,strong)LMYImageButton * imageButton1;
@property(nonatomic,strong)LMYImageButton * imageButton2;
@property(nonatomic,strong)LMYImageButton * imageButton3;
@property(nonatomic,strong)LMYImageButton * imageButton4;
@property(nonatomic,strong)LMYImageButton * imageButton5;
@property(nonatomic,strong)LMYImageButton * imageButton6;
@property(nonatomic,strong)LMYImageButton * imageButton7;
@property(nonatomic,strong)LMYImageButton * imageButton8;
@property(nonatomic,strong)LMYImageButton * imageButton9;


@property(nonatomic,strong)NSArray * imageNSArray;

@end


@implementation MomentImagesView


//- (LMYImageButton *)imageButton1
//{
//    if (!_imageButton1) {
//        LMYImageButton * imageButton1 = [[LMYImageButton alloc] initWithFrame:CGRectMake(0, 0, ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH)];
//        imageButton1.delegate = self;
//        [self addSubview:_imageButton1 = imageButton1];
//    }
//    return _imageButton1;
//}
//
//- (LMYImageButton *)imageButton2
//{
//    if (!_imageButton2) {
//        LMYImageButton * imageButton2 = [[LMYImageButton alloc] initWithFrame:CGRectMake(0, 0, ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH)];
//        imageButton2.delegate = self;
//        [self addSubview:_imageButton2 = imageButton2];
//    }
//    return _imageButton2;
//}
//
//- (LMYImageButton *)imageButton3
//{
//    if (!_imageButton3) {
//        LMYImageButton * imageButton3 = [[LMYImageButton alloc] initWithFrame:CGRectMake(0, 0, ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH)];
//        imageButton3.delegate = self;
//        [self addSubview:_imageButton3 = imageButton3];
//    }
//    return _imageButton3;
//}
//
//- (LMYImageButton *)imageButton4
//{
//    if (!_imageButton4) {
//        LMYImageButton * imageButton4 = [[LMYImageButton alloc] initWithFrame:CGRectMake(0, 0, ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH)];
//        imageButton4.delegate = self;
//        [self addSubview:_imageButton4 = imageButton4];
//    }
//    return _imageButton4;
//}
//
//- (LMYImageButton *)imageButton5
//{
//    if (!_imageButton5) {
//        LMYImageButton * imageButton5 = [[LMYImageButton alloc] initWithFrame:CGRectMake(0, 0, ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH)];
//        imageButton5.delegate = self;
//        [self addSubview:_imageButton5 = imageButton5];
//    }
//    return _imageButton5;
//}
//
//- (LMYImageButton *)imageButton6
//{
//    if (!_imageButton6) {
//        LMYImageButton * imageButton6 = [[LMYImageButton alloc] initWithFrame:CGRectMake(0, 0, ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH)];
//        imageButton6.delegate = self;
//        [self addSubview:_imageButton6 = imageButton6];
//    }
//    return _imageButton6;
//}
//
//- (LMYImageButton *)imageButton7
//{
//    if (!_imageButton7) {
//        LMYImageButton * imageButton7 = [[LMYImageButton alloc] initWithFrame:CGRectMake(0, 0, ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH)];
//        imageButton7.delegate = self;
//        [self addSubview:_imageButton1 = imageButton7];
//    }
//    return _imageButton7;
//}
//
//- (LMYImageButton *)imageButton8
//{
//    if (!_imageButton8) {
//        LMYImageButton * imageButton8 = [[LMYImageButton alloc] initWithFrame:CGRectMake(0, 0, ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH)];
//        imageButton8.delegate = self;
//        [self addSubview:_imageButton1 = imageButton8];
//    }
//    return _imageButton8;
//}
//
//- (LMYImageButton *)imageButton9
//{
//    if (!_imageButton9) {
//        LMYImageButton * imageButton9 = [[LMYImageButton alloc] initWithFrame:CGRectMake(0, 0, ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH)];
//        imageButton9.delegate = self;
//        [self addSubview:_imageButton1 = imageButton9];
//    }
//    return _imageButton9;
//}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self setBackgroundColor:[UIColor redColor]];

    return self;
}

- (void)showMomentImagesView:(NSArray *)images
{
//    self.imageNSArray = images;
//    for (UIView * vi in self.subviews) {
//        [vi setHidden:YES];
//    }
//    
//    //重新布局
//    if (images.count > 0) {
//        [self.imageButton1 setHidden:NO];
//        [self.imageButton1 setImageWithUrl:FLString([[images objectAtIndex:0] objectForKey:@"url"], @"") tag:0];
//        if (images.count == 1) {
//            self.imageButton1.frame = CGRectMake(0, 0, ONE_IMAGES_WIDTH*2+4, ONE_IMAGES_WIDTH*2+4);
//        }else{
//            self.imageButton1.frame = CGRectMake(0, 0, ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH);
//        }
//        [self.imageButton1 sizeChangeed];
//    }
//    if (images.count > 1) {
//        [self.imageButton2 setHidden:NO];
//        [self.imageButton2 setImageWithUrl:FLString([[images objectAtIndex:1] objectForKey:@"url"], @"") tag:1];
//        self.imageButton2.frame = CGRectMake(ONE_IMAGES_WIDTH+4, 0, ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH);
//        [self.imageButton2 sizeChangeed];
//    }
//    if (images.count > 2) {
//        [self.imageButton3 setHidden:NO];
//        [self.imageButton3 setImageWithUrl:FLString([[images objectAtIndex:2] objectForKey:@"url"], @"") tag:2];
//        if (images.count == 4) {
//            self.imageButton3.frame = CGRectMake(0, (ONE_IMAGES_WIDTH+4), ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH);
//        }else{
//            self.imageButton3.frame = CGRectMake((ONE_IMAGES_WIDTH+4)*2, 0, ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH);
//        }
//        [self.imageButton3 sizeChangeed];
//    }
//    if (images.count > 3) {
//        
//        [self.imageButton4 setHidden:NO];
//        [self.imageButton4 setImageWithUrl:FLString([[images objectAtIndex:3] objectForKey:@"url"], @"") tag:3];
//        if (images.count == 4) {
//            self.imageButton4.frame = CGRectMake((ONE_IMAGES_WIDTH+4), (ONE_IMAGES_WIDTH+4), ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH);
//        }else{
//            self.imageButton4.frame = CGRectMake(0, (ONE_IMAGES_WIDTH+4), ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH);
//        }
//        [self.imageButton4 sizeChangeed];
//    }
//    if (images.count > 4) {
//        [self.imageButton5 setHidden:NO];
//        [self.imageButton5 setImageWithUrl:FLString([[images objectAtIndex:4] objectForKey:@"url"], @"") tag:4];
//        self.imageButton5.frame = CGRectMake((ONE_IMAGES_WIDTH+4), (ONE_IMAGES_WIDTH+4), ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH);
//        [self.imageButton5 sizeChangeed];
//    }
//    if (images.count > 5) {
//        [self.imageButton6 setHidden:NO];
//        [self.imageButton6 setImageWithUrl:FLString([[images objectAtIndex:5] objectForKey:@"url"], @"") tag:5];
//        self.imageButton6.frame = CGRectMake((ONE_IMAGES_WIDTH+4)*2, (ONE_IMAGES_WIDTH+4), ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH);
//        [self.imageButton6 sizeChangeed];
//    }
//    if (images.count > 6) {
//        [self.imageButton7 setHidden:NO];
//        [self.imageButton7 setImageWithUrl:FLString([[images objectAtIndex:6] objectForKey:@"url"], @"") tag:6];
//        self.imageButton7.frame = CGRectMake(0, (ONE_IMAGES_WIDTH+4)*2, ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH);
//        
//        [self.imageButton7 sizeChangeed];
//    }
//    if (images.count > 7) {
//        [self.imageButton8 setHidden:NO];
//        [self.imageButton8 setImageWithUrl:FLString([[images objectAtIndex:7] objectForKey:@"url"], @"") tag:7];
//        self.imageButton8.frame = CGRectMake((ONE_IMAGES_WIDTH+4), (ONE_IMAGES_WIDTH+4)*2, ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH);
//        [self.imageButton8 sizeChangeed];
//    }
//    if (images.count > 8) {
//        [self.imageButton9 setHidden:NO];
//        [self.imageButton9 setImageWithUrl:FLString([[images objectAtIndex:8] objectForKey:@"url"], @"") tag:8];
//        self.imageButton9.frame = CGRectMake((ONE_IMAGES_WIDTH+4)*2, (ONE_IMAGES_WIDTH+4)*2, ONE_IMAGES_WIDTH, ONE_IMAGES_WIDTH);
//        [self.imageButton9 sizeChangeed];
//    }
}

#pragma - LMYImageButtonDelegate <NSObject>
- (void)imageButtonClick:(NSInteger)index
{
    FLPictureViewerController * next = [[FLPictureViewerController alloc] init];

    for (int i = 0; i<self.imageNSArray.count; i++)
    {
        NSString * url = FLString([[self.imageNSArray objectAtIndex:0] objectForKey:@"url"], @"");
        
        FLPictureViewerModel * picModel = [[FLPictureViewerModel alloc] initWiththumbnail:url original:url];
        [next arrayAddMode:picModel];
    }

    [next showAllPicWithIndex:index];
    next.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    next.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    next.delegate = self;
    UIViewController * ctl = [AppDelegate getRootController];
    [ctl presentPopupViewController:next animationType:MJPopupViewAnimationFade hideStatusBar:YES];
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
