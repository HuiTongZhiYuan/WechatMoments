//
//  LMYTabBarController.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LMYTabBarController.h"


@interface LMYTabBar : UITabBar
@property (nonatomic,strong) UIImageView * lineView;

@end
@implementation LMYTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    //    _lineView = [[UIImageView alloc] init];
    //    [self addSubview:_lineView];
    //    _lineView.backgroundColor = [FLColorConfig messageDateBgColor];
    
//    self.barStyle = UIBarStyleDefault;
//
//    self.backgroundColor = [UIColor whiteColor];
//    self.backgroundImage = [self imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 1)];
    
//    UIColor * shadowColor = HEX(0xD9D9D9);
//    self.shadowImage     = [self imageWithColor:shadowColor size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)];
    
    return self;
}
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
}
@end





@interface LMYTabBarController ()

@end

@implementation LMYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    [self loadAllTabbarItemWith:selectedIndex];
}

// 刷新所有item
- (void)loadAllTabbarItemWith:(NSInteger)index {
    
    //单利主题model
    LMYThemeConfigModel *model = [LMYThemeConfigModel shareInstance];
    
    NSArray *itemsAry = self.tabBar.items;
    for (NSInteger i = 0; i < itemsAry.count; i++) {
        
        NSString *title = @"";
        NSString *selectedTitle = @"";
        switch (i) {
            case 0:
            {
                title           =  model.tabbar_Home_title;
                selectedTitle   = model.tabbar_Home_titleSelected;
            }
                break;
            case 1:
            {
                title           = model.tabbar_Contacts_title;
                selectedTitle   = model.tabbar_Contacts_titleSelected;
            }
                break;
                
            case 2:
            {
                title           = model.tabbar_Discover_title;
                selectedTitle   = model.tabbar_Discover_titleSelected;
            }
                break;
                
            case 3:
            {
                title           = model.tabbar_Me_title;
                selectedTitle   = model.tabbar_Me_titleSelected;
            }
                break;
                
            default:
                break;
        }
        
        UITabBarItem *item = itemsAry[i];
        if(i == index) {
            item.title = selectedTitle;
        }
        else {
            item.title = title;
            item.titlePositionAdjustment = UIOffsetMake(0, -2);
        }
        UIImage * imageTemp = model.imageNArray[i];
        UIImage * selectedImageTemp = model.imageSAarray[i];
        
        
        imageTemp = [imageTemp imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectedImageTemp = [selectedImageTemp imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        item.image = imageTemp;
        item.selectedImage = selectedImageTemp;
        
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HEX(0x00bb38),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        
//        item.titlePositionAdjustment = UIOffsetMake(0, -2);
//        item.imageInsets = UIEdgeInsetsMake(6, 2, -6, 0);
    }
}

- (void)layoutItem {
    NSArray *itemsAry = self.tabBar.items;
    for (NSInteger i = 0; i < itemsAry.count; i++) {
        UITabBarItem *item = itemsAry[i];
        
      
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

@end
