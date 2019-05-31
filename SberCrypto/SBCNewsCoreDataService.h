//
//  SBCNewsCoreDataService.h
//  SberCrypto
//
//  Created by Сергей Грызин on 19/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SBCNewsModel;


NS_ASSUME_NONNULL_BEGIN

@interface SBCNewsCoreDataService : NSObject

-(NSArray<SBCNewsModel *> *)getNews;
-(void)clearNewsCoreData;
-(void)saveNews:(NSArray<SBCNewsModel *> *)newsArray;

@end

NS_ASSUME_NONNULL_END
