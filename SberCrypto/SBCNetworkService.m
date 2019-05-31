//
//  SBCNetworkService.m
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "SBCNetworkService.h"
#import "SBCNetworkHelper.h"
#import "SBCNewsModel.h"
@import UIKit;

@implementation SBCNetworkService


#pragma mark - Getting news list from API

-(void)getNewsArray:(NSString *)url completion:(void (^)(NSArray<SBCNewsModel *> *))completion
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            NSArray<SBCNewsModel *> *emptyArray = [NSArray array];
            completion(emptyArray);
        }
        else
        {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            completion([self parseNewsJSONFromArray:jsonDict[@"Data"]]);
        }
    }];
    
    [dataTask resume];
}

- (NSArray<SBCNewsModel *> *)parseNewsJSONFromArray:(NSArray *)array
{
    NSMutableArray<SBCNewsModel *> *newsArray = [NSMutableArray new];
    for (int i = 0; i < array.count; i++)
    {
        SBCNewsModel *news = [SBCNewsModel new];
        
        //Вот с датой я хз- с API просто приходит число, и в документации нет описания,
        //откуда его считать. С 1970, очевидно, не работает.
        NSDate *postDate = [NSDate dateWithTimeIntervalSince1970:(int)array[i][@"published_on"]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm dd MMM yyyy";
        NSString *dateString = [dateFormatter stringFromDate:postDate];
        
        news.date = [NSString stringWithFormat:@"Published on: %@", dateString];
        news.ID = array[i][@"id"];
        news.title = [NSString stringWithFormat:@"\t%@", array[i][@"title"]];
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
            UIImage *compressedImage = [[UIImage alloc] initWithData:UIImageJPEGRepresentation(image, 0.7)];
            CIImage *cropImage = [[CIImage alloc] initWithImage:compressedImage options:nil];
            cropImage = [cropImage imageByCroppingToRect:CGRectMake(0.0f, 0.0f + compressedImage.size.height / 3, UIScreen.mainScreen.bounds.size.width, 200.0f)];
            UIImage *croppedImage = [UIImage imageWithCIImage:cropImage];
            completion(croppedImage);
        }
        else
        {
            completion(nil);
        }
        
    }];
    [dataTask resume];
}

@end
