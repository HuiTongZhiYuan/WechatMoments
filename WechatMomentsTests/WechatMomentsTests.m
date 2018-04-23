//
//  WechatMomentsTests.m
//  WechatMomentsTests
//
//  Created by lmy on 2018/4/23.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ContactsModel.h"

@interface WechatMomentsTests : XCTestCase

@property (nonatomic,strong) ContactsModel * model;
@end

@implementation WechatMomentsTests

//初始化的代码，在测试方法调用之前调用
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _model = [[ContactsModel alloc] init];
}

// 释放测试用例的资源代码，这个方法会每个测试用例执行后调用
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    self.model = nil;
    
    [super tearDown];
}

// 测试用例的例子，注意测试用例一定要test开头
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    // 调用需要测试的方法，
    NSString * result = [self.model getName];
    // 如果不相等则会提示@“测试不通过”
    XCTAssertEqual(result, @"123",@"测试不通过");
}

// 测试性能例子
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    
    
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        // 需要测试性能的代码
        for (int i = 0; i<100; i++) {
            
            NSLog(@"WechatMomentsTests- %d",i);
        }
    }];
}


@end
