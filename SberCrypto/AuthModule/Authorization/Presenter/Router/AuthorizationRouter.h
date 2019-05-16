//
//  AuthorizationRouter.h
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface AuthorizationRouter : NSObject

-(void)setNavVC:(UINavigationController *)navVC;
-(void)authSucceeded;
-(void)signInNeeded;

@end

NS_ASSUME_NONNULL_END
