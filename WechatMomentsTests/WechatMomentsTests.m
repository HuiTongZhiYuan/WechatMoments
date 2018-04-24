//
//  WechatMomentsTests.m
//  WechatMomentsTests
//
//  Created by lmy on 2018/4/23.
//  Copyright © 2018年 lmy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ContactsModel.h"
#import "LMYInterface.h"
#import "Foundation+FLKit.h"


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

- (void)testUserJsmithNetworkRequest
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"获取个人信息 测试"];
    NSLog(@"执行顺序：1");

    [[LMYInterface sharedInstance] user_jsmith_success:^(id result) {

        if ([result isKindOfClass: [NSDictionary class]])
        {
            [expectation fulfill];///调用fulfill后 waitForExpectationsWithTimeout 会结束等待

            XCTAssertNotNil(result, @"json 对象不为空");///result结果为nil，会停在这里

            XCTAssertNotNil([result objectForKey:@"avatar"], @"头像不为空");///result结果为nil，会停在这里

            XCTAssertNotNil([result objectForKey:@"nick"], @"nick不为空");///nick结果为nil，会停在这里

            XCTAssertNotNil([result objectForKey:@"profile-image"], @"profile-image不为空");///profile-image结果为nil，会停在这里

            XCTAssertNotNil([result objectForKey:@"username"], @"username不为空");///username结果为nil，会停在这里

            XCTAssertNotNil([result objectForKey:@"id"], @"id不为空");///id结果为nil，会停在这里
        }
        NSLog(@"执行顺序：2");
    } failure:^(NSError *error) {
        NSLog(@"执行顺序：3");
    }];

    ///设置的是30秒超时
    [self waitForExpectationsWithTimeout:30.f handler:^(NSError * _Nullable error) {
        NSLog(@"执行顺序：4");
    }];
}

- (void)testTweetsNetworkRequest
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"获取朋友圈 测试"];
    NSLog(@"执行顺序：1");

    [[LMYInterface sharedInstance] user_jsmith_tweets_success:^(id result) {

        if ([result isKindOfClass: [NSDictionary class]])
        {
            [expectation fulfill];///调用fulfill后 waitForExpectationsWithTimeout 会结束等待

            NSArray * array = (NSArray *)result;
            XCTAssertNotNil(array, @"json 对象不为空");///result结果为nil，会停在这里

            if (array && [array isKindOfClass:[NSArray class]] && array.count > 0)
            {
                for (int i =0; i<array.count; i++) {
                    NSDictionary * dic = FLDictionary([array objectAtIndex:i], nil);

                    XCTAssertNotNil(dic, @"朋友圈消息不为空");///result结果为nil，会停在这里


                    XCTAssertNotNil([dic objectForKey:@"sender"], @"发送者不为空");///sender结果为nil，会停在这里


                    XCTAssertNotNil([dic objectForKey:@"content"], @"内容不为空");///content结果为nil，会停在这里
                    XCTAssertNotNil([dic objectForKey:@"images"], @"有图片");///images结果为nil，会停在这里
                }
            }
        }
        NSLog(@"执行顺序：2");
    } failure:^(NSError *error) {
        NSLog(@"执行顺序：3");
    }];

    ///设置的是30秒超时
    [self waitForExpectationsWithTimeout:30.f handler:^(NSError * _Nullable error) {
        NSLog(@"执行顺序：4");
    }];
}
@end
