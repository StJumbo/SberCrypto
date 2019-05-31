//
//  SBCNewsCoreDataService.m
//  SberCrypto
//
//  Created by Сергей Грызин on 19/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "SBCNewsCoreDataService.h"
#import "AppDelegate.h"
#import "SBCNewsCoreData+CoreDataClass.h"
#import "SBCNewsModel.h"
@import CoreData;

@interface SBCNewsCoreDataService ()

@property (nonatomic, strong) NSPersistentContainer *persistentContainer;

@end

@implementation SBCNewsCoreDataService

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        UIApplication *application = [UIApplication sharedApplication];
        self.persistentContainer = ((AppDelegate *)(application.delegate)).persistentContainer;
        _persistentContainer.viewContext.shouldDeleteInaccessibleFaults = NO;
    }
    return self;
}

-(NSArray<SBCNewsModel *> *)getNews
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SBCNewsCoreData"];
    request.returnsObjectsAsFaults = NO;
    
    NSError *error = nil;
    NSArray *results = [self.persistentContainer.viewContext executeFetchRequest:request error:&error];
    if (!results)
    {
        NSLog(@"Error fetching News objects: %@\n%@", error.localizedDescription, error.userInfo);
        @throw [NSException exceptionWithName:NSGenericException
                                       reason:@"Can't fetch News Objects"
                                     userInfo:nil];
    }
    
    NSArray<SBCNewsModel *> *array = [self parseCoreDataResultToNewsModel:results];
    return array;
}

-(NSArray<SBCNewsModel *> *)parseCoreDataResultToNewsModel:(NSArray<SBCNewsCoreData *> *)coreDataArray
{
    NSMutableArray<SBCNewsModel *> *mutableNews = [[NSMutableArray alloc] initWithCapacity:coreDataArray.count];
    for(int i = 0; i < coreDataArray.count; i++)
    {
        SBCNewsModel *news = [SBCNewsModel new];
        news.title = coreDataArray[i].title;
        news.imageURL = coreDataArray[i].imageURL;
        news.articleURL = coreDataArray[i].articleURL;
        news.date = coreDataArray[i].date;
        news.ID = coreDataArray[i].identificator;
        news.image = nil;
        
        [mutableNews addObject:news];
    }
    
    return mutableNews;
}

-(void)saveNews:(NSArray<SBCNewsModel *> *)newsArray
{
    [self.persistentContainer performBackgroundTask:^(NSManagedObjectContext *context) {
        for(int i = 0; i < newsArray.count; i++)
        {
            SBCNewsCoreData *object = [NSEntityDescription insertNewObjectForEntityForName:@"SBCNewsCoreData" inManagedObjectContext:self.persistentContainer.viewContext];
            object.title = newsArray[i].title;
            object.identificator = newsArray[i].ID;
            object.imageURL = newsArray[i].imageURL;
            object.articleURL = newsArray[i].articleURL;
            object.date = newsArray[i].date;
        }
        
        NSError *error = nil;
        
        if (![self.persistentContainer.viewContext save:&error])
        {
            NSLog(@"Не удалось сохранить объекты");
            NSLog(@"%@, %@", error, error.localizedDescription);
        }
    }];
}

-(void)clearNewsCoreData
{
    [self.persistentContainer performBackgroundTask:^(NSManagedObjectContext * context) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SBCNewsCoreData"];
        NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
        NSError *deleteError = nil;
        [self.persistentContainer.persistentStoreCoordinator executeRequest:deleteRequest withContext:self.persistentContainer.viewContext error:&deleteError];
    }];
}

@end
