//
//  NetworkService.h
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsModel;
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface NetworkService : NSObject

-(void)getNewsArray: (void (^)(NSArray<NewsModel *> *))completion;
- (void)getImageFromURL:(NSString *)picURL completion:(void (^)(UIImage *))completion;

@end

NS_ASSUME_NONNULL_END
