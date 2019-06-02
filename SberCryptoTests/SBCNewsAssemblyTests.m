//
//  SBCNewsAssemblyTests.m
//  SberCryptoTests
//
//  Created by Сергей Грызин on 02/06/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SBCNewsAssembly.h"
#import "SBCNewsViewController.h"

@interface SBCNewsAssemblyTests : XCTestCase

@end

@implementation SBCNewsAssemblyTests

-(void)testAssembly
{
    SBCNewsViewController *newVC = [SBCNewsAssembly assemblyNewsModule];
    XCTAssertNotNil(newVC);
}

@end
