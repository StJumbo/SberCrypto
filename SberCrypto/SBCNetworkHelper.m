//
//  SBCNetworkHelper.m
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "SBCNetworkHelper.h"

@implementation SBCNetworkHelper

+(NSString *)getNewsArrayURL
{
    return @"https://min-api.cryptocompare.com/data/v2/news/?lang=EN";
}

@end
