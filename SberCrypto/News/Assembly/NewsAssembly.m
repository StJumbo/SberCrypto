//
//  NewsAssembly.m
//  SberCrypto
//
//  Created by Сергей Грызин on 19/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "NewsAssembly.h"
#import "NewsViewController.h"
#import "NewsPresenterClass.h"

@implementation NewsAssembly

+(NewsViewController *)assemblyNewsModule
{
    NewsViewController *newsVC = [NewsViewController new];
    [newsVC setProperties];
    return newsVC;
}

@end
