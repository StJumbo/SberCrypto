//
//  AuthViewController.m
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "AuthViewController.h"
#import "AuthorizationRouter.h"
#import "NewsViewController.h"
#import "FirebaseAuthService.h"
#import "AuthorizationView.h"
@import Firebase;

@interface AuthViewController ()

@property (nonatomic) AuthorizationRouter *router;
@property (nonatomic) FirebaseAuthService *authService;

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = [AuthorizationView makeAuthorizationScreen];
    self.navigationController.navigationBarHidden = YES;
    
    AuthorizationRouter *router = [AuthorizationRouter new];
    [router setNavVC:self.navigationController];
    self.router = router;
    
    FirebaseAuthService *authService = [FirebaseAuthService new];
    self.authService = authService;
    
    [self.authService signInWithEmail:@"test@test.ru" andPassword:@"qwerty" :^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if (error)
        {
            [self.router signInNeeded];
        }
        else
        {
            [self.router authSucceeded];
        }
    }];
}

@end
