//
//  FirebaseAuthService.m
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "FirebaseAuthService.h"

@implementation FirebaseAuthService

-(void)signInWithEmail:(NSString *)email andPassword:(NSString *) completion:(void (^)(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error))completion
{
    [[FIRAuth auth] signInWithEmail:@"test@test.ru" password:@"qwerty" completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        completion(authResult, error);
    }];
}

@end
