//
//  NewsPresenterClass.h
//  SberCrypto
//
//  Created by Сергей Грызин on 18/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@class NewsModel;

NS_ASSUME_NONNULL_BEGIN

@interface NewsPresenterClass : NSObject

-(void)createDelegates;
-(void)getNewsArray: (void (^)(NSArray<NewsModel *> *))completion;
-(void)saveNews:(NSArray<NewsModel *> *)newsArray;
-(void)deleteNewsFromCoreData;
-(void)getImageFromURL:(NSString *)picURL completion:(void (^)(UIImage *))completion;

@end

NS_ASSUME_NONNULL_END
