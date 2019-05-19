//
//  NewsCoreData+CoreDataProperties.m
//  SberCrypto
//
//  Created by Сергей Грызин on 19/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//
//

#import "NewsCoreData+CoreDataProperties.h"

@implementation NewsCoreData (CoreDataProperties)

+ (NSFetchRequest<NewsCoreData *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"NewsCoreData"];
}

@dynamic articleURL;
@dynamic date;
@dynamic identificator;
@dynamic imageURL;
@dynamic title;

@end
