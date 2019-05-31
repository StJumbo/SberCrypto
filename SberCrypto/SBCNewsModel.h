//
//  SBCNewsModel.h
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface SBCNewsModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *articleURL;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, nullable) UIImage *image;

@end

NS_ASSUME_NONNULL_END
