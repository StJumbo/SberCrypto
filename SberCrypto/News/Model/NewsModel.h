//
//  NewsModel.h
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface NewsModel : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *imageURL;
@property (nonatomic) NSString *articleURL;
@property (nonatomic) NSString *ID;
@property (nonatomic) NSString *date;
@property (nonatomic) UIImage *image;

@end

NS_ASSUME_NONNULL_END
