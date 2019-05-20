//
//  SBCNewsCoreDataServiceTests.m
//  SberCryptoTests
//
//  Created by Сергей Грызин on 20/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "AppDelegate.h"
#import "SBCNewsCoreDataService.h"
@import CoreData;

@interface SBCNewsCoreDataServiceTests : XCTestCase

@property (nonatomic, strong) NSFetchRequest *request;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSError *error;

@end

@implementation SBCNewsCoreDataServiceTests

-(void)setUp
{
    [super setUp];
    self.request = [NSFetchRequest fetchRequestWithEntityName:@"SBCNewsCoreData"];
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer *container = ((AppDelegate *)(application.delegate)).persistentContainer;
    self.context = container.viewContext;
    self.context.shouldDeleteInaccessibleFaults = NO;
}

-(void)tearDown
{
    self.request = nil;
    self.context = nil;
    [super tearDown];
}

-(void)testGetNewsError
{
    SBCNewsCoreDataService *service = [SBCNewsCoreDataService new];
    //Поскольку не вызывается метод создания контекста, то он ниловый, в результате
    //вернется нил и выбросится исключение
    
    XCTAssertThrows([service getNews]);
}

-(void)testClearNewsCoreDataDeleteWithoutError
{
    NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:self.request];
    NSError *deleteError = nil;
    [self.context.persistentStoreCoordinator executeRequest:deleteRequest withContext:self.context error:&deleteError];
    XCTAssertNil(deleteError);
}

@end
