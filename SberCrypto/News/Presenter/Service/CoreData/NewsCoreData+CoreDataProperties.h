//
//  NewsCoreData+CoreDataProperties.h
//  SberCrypto
//
//  Created by Сергей Грызин on 19/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//
//

#import "NewsCoreData+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NewsCoreData (CoreDataProperties)

+ (NSFetchRequest<NewsCoreData *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *articleURL;
@property (nullable, nonatomic, copy) NSString *date;
@property (nullable, nonatomic, copy) NSString *identificator;
@property (nullable, nonatomic, copy) NSString *imageURL;
@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
