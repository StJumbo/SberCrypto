//
//  NewsTableViewCellTests.m
//  SberCryptoTests
//
//  Created by Сергей Грызин on 19/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "SBCNewsTableViewCell.h"

@interface NewsTableViewCellTests : XCTestCase

@property (nonatomic, strong) SBCNewsTableViewCell *cell;

@end

@implementation NewsTableViewCellTests

- (void)setUp
{
    [super setUp];
    _cell = [SBCNewsTableViewCell new];
}

- (void)tearDown
{
    self.cell = nil;
    [super tearDown];
}

- (void)testPrepareForReuse
{
    [self.cell prepareForReuse];
    
    XCTAssertNil(self.cell.coverImageView.image);
    XCTAssertNil(self.cell.dateLabel.text);
    XCTAssertNil(self.cell.titleLabel.text);
}

@end
