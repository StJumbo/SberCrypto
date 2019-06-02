//
//  SBCNewsAssembly.m
//  SberCrypto
//
//  Created by Сергей Грызин on 19/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "SBCNewsAssembly.h"
#import "SBCNewsViewController.h"

@implementation SBCNewsAssembly

+(SBCNewsViewController *)assemblyNewsModule
{
    SBCNewsViewController *newsVC = [SBCNewsViewController new];
    return newsVC;
}

@end
