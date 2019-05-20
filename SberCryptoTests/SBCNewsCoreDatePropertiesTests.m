//
//  SBCNewsCoreDatePropertiesTests.m
//  SberCryptoTests
//
//  Created by Сергей Грызин on 20/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "SBCNewsCoreData+CoreDataProperties.h"


@interface SBCNewsCoreDatePropertiesTests : XCTestCase

@end

@implementation SBCNewsCoreDatePropertiesTests

- (void)testFetchRequest {
    id mockSBCNewsProperties = [OCMockObject mockForClass:[SBCNewsCoreData class]];
    
    NSFetchRequest *dummyFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"SBCNewsCoreData"];
    OCMStub([mockSBCNewsProperties fetchRequest]).andReturn(dummyFetchRequest);
    
    NSFetchRequest<SBCNewsCoreData *> *testFetchRequest = [SBCNewsCoreData fetchRequest];
    XCTAssertEqualObjects(testFetchRequest, dummyFetchRequest);
}

@end
