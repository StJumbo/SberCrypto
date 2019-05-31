//
//  SBCNewsRouter.h
//  SberCrypto
//
//  Created by Сергей Грызин on 31/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@class SBCNewsViewController;

NS_ASSUME_NONNULL_BEGIN

@interface SBCNewsRouter : NSObject

-(instancetype)initWithRootController: (SBCNewsViewController *)navVC;
-(void)openCurrentURLinSafari: (NSString *)URL readingModeNeeded:(BOOL)readingMode;

@end

NS_ASSUME_NONNULL_END
