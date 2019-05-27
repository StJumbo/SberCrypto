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

@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation SBCNewsCoreDataService

-(void)createContext
{
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer *container = ((AppDelegate *)(application.delegate)).persistentContainer;
    self.context = container.viewContext;
    self.context.shouldDeleteInaccessibleFaults = NO;
}

-(NSArray<SBCNewsModel *> *)getNews
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SBCNewsCoreData"];
    request.returnsObjectsAsFaults = NO;
    
    NSError *error = nil;
    NSArray *results = [self.context executeFetchRequest:request error:&error];
    if (!results)
    {
        NSLog(@"Error fetching News objects: %@\n%@", [error localizedDescription], [error userInfo]);
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
    dispatch_barrier_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for(int i = 0; i < newsArray.count; i++)
        {
            SBCNewsCoreData *object = [NSEntityDescription insertNewObjectForEntityForName:@"SBCNewsCoreData" inManagedObjectContext:self.context];
            object.title = newsArray[i].title;
            object.identificator = newsArray[i].ID;
            object.imageURL = newsArray[i].imageURL;
            object.articleURL = newsArray[i].articleURL;
            object.date = newsArray[i].date;
        }
        
        NSError *error = nil;
        
        if (![self.context save:&error])
        {
            NSLog(@"Не удалось сохранить объекты");
            NSLog(@"%@, %@", error, error.localizedDescription);
        }
    });
}

-(void)clearNewsCoreData
{
    dispatch_barrier_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SBCNewsCoreData"];
        NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
        NSError *deleteError = nil;
        [self.context.persistentStoreCoordinator executeRequest:deleteRequest withContext:self.context error:&deleteError];
    });
}

@end
