//
//  SBCNewsNetworkServiceTests.m
//  SberCryptoTests
//
//  Created by Сергей Грызин on 20/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SBCNetworkService.h"
#import "SBCNetworkHelper.h"
#import "SBCNewsModel.h"
#import <OCMock/OCMock.h>

@interface SBCNewsNetworkServiceTests : XCTestCase

@end

@implementation SBCNewsNetworkServiceTests

-(void)testGetNewsArrayErrorBlock
{
    SBCNetworkService *service = [SBCNetworkService new];
    NSString *brokenURLString = @"123";

    __block XCTestExpectation *expectation = [self expectationWithDescription:@"data checked"];

    [service getNewsArray:brokenURLString completion:^(NSArray<SBCNewsModel *> * _Nonnull newsArray) {
        XCTAssertEqualObjects(newsArray, @[]);
        [expectation fulfill];
        expectation = nil;
    }];

    XCTWaiter *waiter = [[XCTWaiter alloc] init];
    [waiter waitForExpectations:@[expectation] timeout:10.0];
}

-(void)testGetImageFromURLNetworkError
{
    SBCNetworkService *service = [SBCNetworkService new];
    NSString *brokenURLString = @"123";
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:@"network error123"];
    
    [service getImageFromURL:brokenURLString completion:^(UIImage * _Nonnull image) {
        XCTAssertNil(image);
        [expectation fulfill];
        expectation = nil;
    }];
    
    XCTWaiter *waiter = [[XCTWaiter alloc] init];
    [waiter waitForExpectations:@[expectation] timeout:10.0];
}

-(void)testGetImageFromURLCantParseDateToImage
{
    SBCNetworkService *service = [SBCNetworkService new];
    NSString *brokenURLString = @"https://yandex.ru/";

    __block XCTestExpectation *expectation = [self expectationWithDescription:@"bad picture url"];

    [service getImageFromURL:brokenURLString completion:^(UIImage * _Nonnull image) {
        XCTAssertNil(image);
        [expectation fulfill];
        expectation = nil;
    }];

    XCTWaiter *waiter = [[XCTWaiter alloc] init];
    [waiter waitForExpectations:@[expectation] timeout:10.0];
}

@end
