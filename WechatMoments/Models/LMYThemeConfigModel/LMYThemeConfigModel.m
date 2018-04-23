//
//  LMYThemeConfigModel.m
//  WechatMoments
//
//  Created by 刘明洋 on 2018/4/11.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import "LMYThemeConfigModel.h"

@implementation LMYThemeConfigModel


+ (instancetype)shareInstance {
    static dispatch_once_t once;
    static LMYThemeConfigModel * obj = nil;
    dispatch_once(&once, ^{
        obj = [[LMYThemeConfigModel alloc] init];
    });
    
    return obj;
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.tabbar_Home_title = [LMYResource LMY_Localized:@"WeChat"];
        self.tabbar_Home_titleSelected = [LMYResource LMY_Localized:@"WeChat_S"];
        
        self.tabbar_Contacts_title = [LMYResource LMY_Localized:@"Contacts"];
        self.tabbar_Contacts_titleSelected = [LMYResource LMY_Localized:@"Contacts_S"];
        
        self.tabbar_Discover_title = [LMYResource LMY_Localized:@"Discover"];
        self.tabbar_Discover_titleSelected = [LMYResource LMY_Localized:@"Discover_S"];
        
        self.tabbar_Me_title = [LMYResource LMY_Localized:@"Me"];
        self.tabbar_Me_titleSelected = [LMYResource LMY_Localized:@"Me_S"];
        
        self.imageNArray = @[[LMYResource imageNamed:@"tabbar_mainframe"],
                             [LMYResource imageNamed:@"tabbar_contacts"],
                             [LMYResource imageNamed:@"tabbar_discover"],
                             [LMYResource imageNamed:@"tabbar_me"]];
        
       self.imageSAarray = @[[LMYResource imageNamed:@"tabbar_mainframeHL"],
                             [LMYResource imageNamed:@"tabbar_contactsHL"],
                             [LMYResource imageNamed:@"tabbar_discoverHL"],
                             [LMYResource imageNamed:@"tabbar_meHL"]];
        
        
    }
    return self;
}


@end
