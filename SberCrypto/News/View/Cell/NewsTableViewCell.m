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
        self.coverImageView.backgroundColor = UIColor.lightGrayColor;
        self.titleLabel = [[UILabel alloc] init];
        self.dateLabel = [[UILabel alloc] init];
        
        self.titleLabel.numberOfLines = 0;
        
        [self.contentView addSubview:self.coverImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.dateLabel];
        
        [self makeConstrainst];
        
        self.titleLabel.font = [UIFont systemFontOfSize:23.0f];
        self.dateLabel.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightLight];
    }
    return self;
}


- (void)makeConstrainst
{
    self.coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.coverImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
                                              [self.coverImageView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor],
                                              [self.coverImageView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor],
                                              [self.coverImageView.heightAnchor constraintEqualToConstant:200.0f],
                                              
                                              [self.dateLabel.topAnchor constraintEqualToAnchor:self.coverImageView.bottomAnchor],
                                              [self.dateLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant: -2.0f],
                                              [self.dateLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant: 2.0f],
                                              
                                              [self.titleLabel.topAnchor constraintEqualToAnchor:self.dateLabel.bottomAnchor],
                                              [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.dateLabel.trailingAnchor],
                                              [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.dateLabel.leadingAnchor],
                                              [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant: -8.0f]
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
