//
//  NewsViewController.m
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "NewsViewController.h"
#import "NetworkService.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NetworkService *service = [NetworkService new];
    [service getNewsArray];
}

@end
