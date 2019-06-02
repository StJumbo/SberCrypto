//
//  SBCNewsPresenterClass.m
//  SberCrypto
//
//  Created by Сергей Грызин on 18/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "SBCNewsPresenterClass.h"
#import "SBCNetworkService.h"
#import "SBCNetworkHelper.h"
#import "SBCNewsModel.h"
#import "SBCNewsCoreDataService.h"
#import "SBCNewsRouter.h"
#import "SBCNewsViewController.h"

@interface SBCNewsPresenterClass ()

@property (nonatomic, strong) SBCNetworkService *networkService;
@property (nonatomic, strong) SBCNewsCoreDataService *coreDataService;
@property (nonatomic, strong) SBCNewsRouter *router;

@end

@implementation SBCNewsPresenterClass


#pragma mark - Init

-(instancetype)initWithRootController: (SBCNewsViewController *)rootVC
{
    self = [super init];
    if (self)
    {
        _networkService = [[SBCNetworkService alloc] init];
        _coreDataService = [[SBCNewsCoreDataService alloc] init];
        _router = [[SBCNewsRouter alloc] initWithParentController:rootVC];
    }
    return self;
}


#pragma mark - Network Service

-(void)updateNewsDataSource:(void (^)(NSArray<SBCNewsModel *> * _Nonnull))completion
{
    NSMutableArray<SBCNewsModel *> *arrayFromCoreData = [NSMutableArray arrayWithArray:[self.coreDataService getNews]];
    
    NSString *urlString = [SBCNetworkHelper getNewsArrayURL];
    
    [self.networkService getNewsArray:urlString completion:^(NSArray<SBCNewsModel *> * _Nonnull newsArray) {
        NSMutableArray<SBCNewsModel *> *arrayForSaving = [NSMutableArray array];
        for(int i = 0; i < newsArray.count; i++)
        {
            //Находим в скачанных те, которые еще не сохранены на устройстве, сохраняем их и
            //отображаем. Можно было бы искать по Timestamp, но он какой- то не непостоянный
            NSArray *checkingArray = [arrayFromCoreData filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"ID == %@", newsArray[i].ID]];
            if(checkingArray.count <= 0)
            {
                [arrayForSaving addObject:newsArray[i]];
            }
        }
        NSLog(@"\n\n\n\nNew articles: %lu",(unsigned long)arrayForSaving.count);
        if(arrayForSaving.count > 0)
        {
            [self.coreDataService saveNews:arrayForSaving];
        }
        
        NSMutableArray *arrayToShow = [NSMutableArray arrayWithArray:arrayForSaving];
        [arrayToShow addObjectsFromArray:arrayFromCoreData];
        completion([arrayToShow copy]);
    }];
}

-(void)getImageFromURL:(NSString *)picURL completion:(void (^)(UIImage * _Nonnull))completion
{
    [_networkService getImageFromURL:picURL completion:^(UIImage * _Nonnull picture) {
        completion(picture);
    }];
}


#pragma mark - CoreData Service

-(void)saveNews:(NSArray<SBCNewsModel *> *)newsArray
{
    [_coreDataService saveNews:newsArray];
}

-(void)deleteButtonPressed
{
    [_coreDataService clearNewsCoreData];
}

#pragma mark - Router

-(void)openURLInSafari: (NSString *)URL readingModeNeeded:(BOOL)readingMode
{
    [self.router openCurrentURLinSafari:URL readingModeNeeded:readingMode];
}


@end
