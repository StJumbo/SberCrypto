//
//  NewsTableViewCell.m
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.coverImageView = [[UIImageView alloc] init];
        self.titleLabel = [[UILabel alloc] init];
        self.dateLabel = [[UILabel alloc] init];
        
        self.titleLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_coverImageView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_dateLabel];
        
        [self makeConstrainst];
        
//        [self.coverImageView setBackgroundColor:UIColor.cyanColor];
//        [self.titleLabel setBackgroundColor:UIColor.yellowColor];
//        [self.dateLabel setBackgroundColor:UIColor.greenColor];
        
        self.titleLabel.font = [UIFont systemFontOfSize:23.0f];
    }
    return self;
}


- (void)makeConstrainst
{
    self.coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *coverImageViewHeightConstraint = [[NSLayoutConstraint alloc] init];
    coverImageViewHeightConstraint = [self.coverImageView.heightAnchor constraintLessThanOrEqualToConstant:200.f];
    [coverImageViewHeightConstraint setPriority:UILayoutPriorityDefaultHigh];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.coverImageView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [self.coverImageView.rightAnchor constraintEqualToAnchor:self.rightAnchor],
                                              [self.coverImageView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
                                              [self.coverImageView.heightAnchor constraintEqualToConstant:200.0f],
//                                              coverImageViewHeightConstraint,
                                              
                                              [self.titleLabel.topAnchor constraintEqualToAnchor:self.coverImageView.bottomAnchor],
                                              [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
                                              [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                              
                                              [self.dateLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor],
                                              [self.dateLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
                                              [self.dateLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                              [self.dateLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
                                              ]];
}

- (void)prepareForReuse
{
    self.titleLabel.text = nil;
    self.dateLabel.text = nil;
    self.coverImageView.image = nil;
    [super prepareForReuse];
}


@end
