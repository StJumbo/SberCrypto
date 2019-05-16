//
//  NewsViewController.m
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "NewsViewController.h"
#import "NetworkService.h"
#import "NewsModel.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.blueColor;
    
    NetworkService *service = [NetworkService new];
    [service getNewsArray:^(NSArray<NewsModel *> * _Nonnull newsArray) {
        for(int i = 0; i < newsArray.count; i++)
        {
            NSLog(@"%@", newsArray[i].title);
        }
    }];
}

@end
