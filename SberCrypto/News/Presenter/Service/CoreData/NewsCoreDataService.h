//
//  NewsCoreDataService.h
//  SberCrypto
//
//  Created by Сергей Грызин on 19/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsModel;


NS_ASSUME_NONNULL_BEGIN

@interface NewsCoreDataService : NSObject

-(void)createContext;
-(NSArray<NewsModel *> *)getNews;
-(void)clearNewsCoreData;
-(void)saveNews:(NSArray<NewsModel *> *)newsArray;

@end

NS_ASSUME_NONNULL_END
