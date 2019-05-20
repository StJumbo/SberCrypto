//
//  SBCNewsCoreData+CoreDataProperties.m
//  SberCrypto
//
//  Created by Сергей Грызин on 19/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//
//

#import "SBCNewsCoreData+CoreDataProperties.h"

@implementation SBCNewsCoreData (CoreDataProperties)

+ (NSFetchRequest<SBCNewsCoreData *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SBCNewsCoreData"];
}

@dynamic articleURL;
@dynamic date;
@dynamic identificator;
@dynamic imageURL;
@dynamic title;

@end
