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

@interface SBCNewsPresenterClass ()

@property (nonatomic, strong) SBCNetworkService *networkDelegate;
@property (nonatomic, strong) SBCNewsCoreDataService *coreDataDelegate;

@end

@implementation SBCNewsPresenterClass

-(void)createDelegates
{
    self.networkDelegate = [[SBCNetworkService alloc] init];
    self.coreDataDelegate = [[SBCNewsCoreDataService alloc] init];
    [self.coreDataDelegate createContext];
}

-(void)getNewsArray:(void (^)(NSArray<SBCNewsModel *> * _Nonnull))completion
{
    NSMutableArray<SBCNewsModel *> *array = [NSMutableArray arrayWithArray:[self.coreDataDelegate getNews]];
    
    NSString *urlString = [SBCNetworkHelper getNewsArrayURL];
    [self.networkDelegate getNewsArray:urlString completion:^(NSArray<SBCNewsModel *> * _Nonnull newsArray) {
        NSMutableArray<SBCNewsModel *> *arrayForSaving = [NSMutableArray array];
        for(int i = 0; i < newsArray.count; i++)
        {
            //Находим в скачанных те, которые еще не сохранены на устройстве, сохраняем их и
            //отображаем. Можно было бы искать по Timestamp, но он какой- то не непостоянный
            NSArray *checkingArray = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"ID == %@", newsArray[i].ID]];
            if(checkingArray.count <= 0)
            {
                [arrayForSaving addObject:newsArray[i]];
            }
        }
        NSLog(@"\n\n\n\nNew articles: %lu",(unsigned long)arrayForSaving.count);
        if(arrayForSaving.count > 0)
        {
            __weak typeof(self) weakSelf = self;
            [weakSelf.coreDataDelegate saveNews:arrayForSaving];
        }
        NSMutableArray *arrayToShow = [NSMutableArray arrayWithArray:arrayForSaving];
        [arrayToShow addObjectsFromArray:array];
        completion(arrayToShow);
    }];
}

-(void)saveNews:(NSArray<SBCNewsModel *> *)newsArray
{
    [self.coreDataDelegate saveNews:newsArray];
}

-(void)deleteNewsFromCoreData
{
    [self.coreDataDelegate clearNewsCoreData];
}

-(void)getImageFromURL:(NSString *)picURL completion:(void (^)(UIImage * _Nonnull))completion
{
    [self.networkDelegate getImageFromURL:picURL completion:^(UIImage * _Nonnull picture) {
        completion(picture);
    }];
}


@end
