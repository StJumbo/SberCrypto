//
//  SBCNewsPresenterClass.h
//  SberCrypto
//
//  Created by Сергей Грызин on 18/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@class SBCNewsModel;
@class SBCNewsViewController;

NS_ASSUME_NONNULL_BEGIN

@interface SBCNewsPresenterClass : NSObject

-(instancetype)initWithRootController: (SBCNewsViewController *)rootVC;
-(void)updateNewsDataSource:(void (^)(NSArray<SBCNewsModel *> *))completion;
-(void)deleteButtonPressed;
-(void)saveNews:(NSArray<SBCNewsModel *> *)newsArray;
-(void)getImageFromURL:(NSString *)picURL completion:(void (^)(UIImage *))completion;
-(void)openURLInSafari: (NSString *)URL readingModeNeeded:(BOOL)readingMode;

@end

NS_ASSUME_NONNULL_END
