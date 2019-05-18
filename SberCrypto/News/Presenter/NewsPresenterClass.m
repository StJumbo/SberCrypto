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

@interface NewsPresenterClass ()

@property (nonatomic, strong) NetworkService *networkDelegate;

@end

@implementation NewsPresenterClass

-(void)createDelegates
{
    self.networkDelegate = [[NetworkService alloc] init];
}

-(void)getNewsArray:(void (^)(NSArray<NewsModel *> * _Nonnull))completion
{
    [self.networkDelegate getNewsArray:^(NSArray<NewsModel *> * _Nonnull newsArray) {
        completion(newsArray);
    }];
}

-(void)getImageFromURL:(NSString *)picURL completion:(void (^)(UIImage * _Nonnull))completion
{
    [self.networkDelegate getImageFromURL:picURL completion:^(UIImage * _Nonnull picture) {
        completion(picture);
    }];
}


@end
