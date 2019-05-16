//
//  AuthorizationRouter.m
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "AuthorizationRouter.h"
#import "NewsViewController.h"

@interface AuthorizationRouter ()

@property (nonatomic, retain) UINavigationController *navigationController;

@end


@implementation AuthorizationRouter

-(void)setNavVC:(UINavigationController *)navVC
{
    self.navigationController = navVC;
}

-(void)authSucceeded
{
    NewsViewController *newsVC = [NewsViewController new];
    newsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"News" image:nil tag:0];

    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:@[newsVC]];
    
    [self.navigationController pushViewController:tabBarController animated:YES];
    
}

-(void)signInNeeded
{
    NSLog(@"no saved account");
}

@end
