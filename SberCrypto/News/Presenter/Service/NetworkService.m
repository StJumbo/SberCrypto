//
//  NetworkService.m
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "NetworkService.h"
#import "NetworkHelper.h"
#import "NewsModel.h"
@import UIKit;

@implementation NetworkService

-(void)getNewsArray: (void (^)(NSArray<NewsModel *> *))completion
{
    NSString *urlString = [NetworkHelper getNewsArrayURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
        }
        else
        {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//            NSLog(@"%@", jsonDict);
            completion([self parseNewsJSONFromArray:jsonDict[@"Data"]]);
        }
    }];
    
    [dataTask resume];
}

- (NSArray<NewsModel *> *)parseNewsJSONFromArray:(NSArray *)array
{
    NSMutableArray<NewsModel *> *newsArray = [NSMutableArray new];
    for (int i = 0; i < array.count; i++)
    {
        NewsModel *news = [NewsModel new];
        news.date = (NSInteger)array[i][@"published_on"];
        news.title = array[i][@"title"];
        news.imageURL = array[i][@"imageurl"];
        news.articleURL = array[i][@"url"];
        news.image = nil;
        
        [newsArray addObject:news];
    }
    
    return newsArray;
}

#pragma mark - Getting image

- (void)getImageFromURL:(NSString *)picURL completion:(void (^)(UIImage *))completion
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:picURL]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            completion(nil);
        }
        
        UIImage *image = [[UIImage alloc] initWithData:data];
        if (image)
        {
            completion(image);
        }
        else
        {
            completion(nil);
        }
        
    }];
    
    [dataTask resume];
}

@end
