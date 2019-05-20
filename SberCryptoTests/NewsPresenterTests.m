//
//  NewsPresenterTests.m
//  SberCryptoTests
//
//  Created by Сергей Грызин on 19/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "SBCNewsPresenterClass.h"
#import "SBCNewsCoreDataService.h"
#import "SBCNetworkService.h"

@interface NewsPresenterTests : XCTestCase

@property (nonatomic, strong) SBCNewsPresenterClass *presenter;

@end

@implementation NewsPresenterTests

- (void)setUp
{
    [super setUp];
    self.presenter = OCMPartialMock([SBCNewsPresenterClass new]);
    [self.presenter createDelegates];
}

- (void)tearDown
{
    self.presenter = nil;
    [super tearDown];
}

- (void)testSaveNewsCallMethod
{
    SBCNewsCoreDataService *service = [SBCNewsCoreDataService new];
    [service createContext];
    
    OCMExpect([service saveNews:@[]]);
    
    [self.presenter saveNews:@[]];
    
    OCMVerify([service saveNews:@[]]);
}

- (void)testDeleteNewsCallMethod
{
    SBCNewsCoreDataService *service = [SBCNewsCoreDataService new];
    [service createContext];
    
    OCMExpect([service clearNewsCoreData]);
    
    [self.presenter deleteNewsFromCoreData];
    
    OCMVerify([service clearNewsCoreData]);
}

@end
