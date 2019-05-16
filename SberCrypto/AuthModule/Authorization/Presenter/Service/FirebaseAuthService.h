//
//  FirebaseAuthService.h
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;
NS_ASSUME_NONNULL_BEGIN

@interface FirebaseAuthService : NSObject

-(void)signInWithEmail:(NSString *)email andPassword:(NSString *) completion:(void (^)(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
