//
//  AuthorizationView.m
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "AuthorizationView.h"

@implementation AuthorizationView

+(UIView *)makeAuthorizationScreen
{
    UIView *screenView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    screenView.backgroundColor = UIColor.greenColor;
    
    CGFloat inset = 20.0f;
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(inset, screenView.center.y - 50.0f, screenView.bounds.size.width - 2 * inset, 60.0f)];
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    descriptionLabel.text = @"Authorization...";
    descriptionLabel.textColor = UIColor.whiteColor;
    [descriptionLabel setFont:[UIFont systemFontOfSize:35.0f]];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator setCenter:CGPointMake(descriptionLabel.center.x, descriptionLabel.frame.origin.y + descriptionLabel.frame.size.height + 20.0f)];
    [activityIndicator startAnimating];
    
    [screenView addSubview:descriptionLabel];
    [screenView addSubview:activityIndicator];
    
    return screenView;
}

@end
