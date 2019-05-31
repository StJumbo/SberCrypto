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
//    SBCNewsCoreDataService *service = [SBCNewsCoreDataService new];
    
    
    //Раньше SBCNewsCoreDataService требовал вызова отдельного метода для получения
    //контекста, поэтому для проверки ошибки получения контекста я просто не вызывал
    //этот метод. Теперь контекст вытаскивается в инициализаторе класса, поэтому в
    //обычной ситуации контекст получается всегда, и я не знаю, как искусственно можно
    //вызвать заход в тот кусок кода, который раньше покрываался этим тестом. Только
    //если ввытаскивать контекст наружу
    
    
//    XCTAssertThrows([service getNews]);
}

-(void)testClearNewsCoreDataDeleteWithoutError
{
    NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:self.request];
    NSError *deleteError = nil;
    [self.context.persistentStoreCoordinator executeRequest:deleteRequest withContext:self.context error:&deleteError];
    XCTAssertNil(deleteError);
}

@end
