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
#import "SBCNewsRouter.h"
#import "SBCNewsViewController.h"
@import SafariServices;

@interface NewsPresenterTests : XCTestCase

@property (nonatomic, strong) SBCNewsPresenterClass *presenter;

@end

@implementation NewsPresenterTests

-(void)setUp
{
    [super setUp];
    self.presenter = OCMPartialMock([SBCNewsPresenterClass new]);
}

-(void)tearDown
{
    self.presenter = nil;
    [super tearDown];
}

-(void)testSaveNewsCallMethod
{
    SBCNewsCoreDataService *service = [SBCNewsCoreDataService new];
    
    OCMExpect([service saveNews:@[]]);
    
    [self.presenter saveNews:@[]];
    
    OCMVerify([service saveNews:@[]]);
}

-(void)testDeleteNewsCallMethod
{
    SBCNewsCoreDataService *service = [SBCNewsCoreDataService new];
    
    OCMExpect([service clearNewsCoreData]);
    
    [self.presenter deleteButtonPressed];
    
    OCMVerify([service clearNewsCoreData]);
}

-(void)testOpenInSafariMethod
{
    SBCNewsRouter *router = [SBCNewsRouter new];
    OCMExpect([router openCurrentURLinSafari:@"https://yandex.ru/" readingModeNeeded:NO]);
    
    [self.presenter openURLInSafari:@"https://yandex.ru/" readingModeNeeded:NO];
    
    OCMVerify([router openCurrentURLinSafari:@"https://yandex.ru/" readingModeNeeded:NO]);
}

@end
