//
//  SBCNewsRouter.m
//  SberCrypto
//
//  Created by Сергей Грызин on 31/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "SBCNewsRouter.h"
#import "SBCNewsViewController.h"
@import SafariServices;

@interface SBCNewsRouter () <SFSafariViewControllerDelegate>

@property (nonatomic, weak) SBCNewsViewController *parentVC;

@end

@implementation SBCNewsRouter


#pragma mark - Custom init

-(instancetype)initWithParentController: (SBCNewsViewController *)parentVC
{
    //Navigation Controller почему- то равен nil, хотя я его явно задаю в AppDelegate.
    //Поэтому решил таким образом показывать статьи в Safari
    self = [super init];
    if (self) {
        self.parentVC = parentVC;
    }
    return self;
}


#pragma mark - SFSafariServices delegate

-(void)openCurrentURLinSafari: (NSString *)URL readingModeNeeded:(BOOL)readingMode
{
    NSURL *url = [[NSURL alloc] initWithString:URL];
    SFSafariViewControllerConfiguration *config = [SFSafariViewControllerConfiguration new];
    config.entersReaderIfAvailable = readingMode;
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url configuration:config];
    safariVC.delegate = self;
    [self.parentVC presentViewController:safariVC animated:YES completion:nil];
}

-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [self.parentVC dismissViewControllerAnimated:YES completion:nil];
}

@end
