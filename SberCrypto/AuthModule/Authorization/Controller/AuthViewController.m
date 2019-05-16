//
//  AuthViewController.m
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "AuthViewController.h"
#import "NewsViewController.h"
@import Firebase;

@interface AuthViewController ()

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.greenColor;
    
    [[FIRAuth auth] signInWithEmail:@"test@test.ru" password:@"qwerty" completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"zhopa");
        }
        else
        {
            NSLog(@"1111111111111111111111111111\n%@", authResult.user.uid);
            self.view.backgroundColor = UIColor.yellowColor;
            
            NewsViewController *nextVC = [NewsViewController new];
            [self presentViewController:nextVC animated:YES completion:nil];
        }
    }];
}

@end
