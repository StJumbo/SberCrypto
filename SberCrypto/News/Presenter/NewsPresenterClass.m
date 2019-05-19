//
//  NewsPresenterClass.m
//  SberCrypto
//
//  Created by Сергей Грызин on 18/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "NewsPresenterClass.h"
#import "NetworkService.h"
#import "NewsModel.h"
#import "NewsCoreDataService.h"

@interface NewsPresenterClass ()

@property (nonatomic, strong) NetworkService *networkDelegate;
@property (nonatomic, strong) NewsCoreDataService *coreDataDelegate;

@end

@implementation NewsPresenterClass

-(void)createDelegates
{
    self.networkDelegate = [[NetworkService alloc] init];
    self.coreDataDelegate = [[NewsCoreDataService alloc] init];
    [self.coreDataDelegate createContext];
}

-(void)getNewsArray:(void (^)(NSArray<NewsModel *> * _Nonnull))completion
{
    NSMutableArray<NewsModel *> *array = [NSMutableArray arrayWithArray:[self.coreDataDelegate getNews]];
    for(int i = 0; i < array.count; i++)
    {
        NSLog(@"%@", array[i].title);
    }
    
    [self.networkDelegate getNewsArray:^(NSArray<NewsModel *> * _Nonnull newsArray) {
        NSMutableArray<NewsModel *> *arrayForSaving = [NSMutableArray array];
        for(int i = 0; i < newsArray.count; i++)
        {
            //Находим в скачанных те, которые еще не сохранены на устройстве, сохраняем их и
            //отображаем
            NSArray *checkingArray = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"ID == %@", newsArray[i].ID]];
            if(checkingArray.count <= 0)
            {
                [arrayForSaving addObject:newsArray[i]];
                [array addObject:newsArray[i]];
            }
        }
        [self.coreDataDelegate saveNews:arrayForSaving];
        completion(array);
    }];
    
    
}

-(void)saveNews:(NSArray<NewsModel *> *)newsArray
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
