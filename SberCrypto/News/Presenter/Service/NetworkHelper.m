//
//  NetworkHelper.m
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "NetworkHelper.h"

@implementation NetworkHelper

+(NSString *)getNewsArrayURL
{
//    NSString *APIKey = @"113c2e990b4a2cd147b989e17a116bf63541d103d8596967af7c7c6ce781fd7e";
    return [NSString stringWithFormat:@"https://min-api.cryptocompare.com/data/v2/news/?lang=EN"];
}

@end
