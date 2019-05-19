//
//  NewsAssembly.h
//  SberCrypto
//
//  Created by Сергей Грызин on 19/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsViewController;

NS_ASSUME_NONNULL_BEGIN

@interface NewsAssembly : NSObject

+(NewsViewController *)assemblyNewsModule;

@end

NS_ASSUME_NONNULL_END
