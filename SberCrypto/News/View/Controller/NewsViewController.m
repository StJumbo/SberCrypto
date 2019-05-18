//
//  NewsViewController.m
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "NewsViewController.h"
#import "NetworkService.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"

@interface NewsViewController ()

@property (nonatomic) NSMutableArray<NewsModel *> *newsArray;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NetworkService *service = [NetworkService new];
    [service getNewsArray:^(NSArray<NewsModel *> *newsArray) {
        self.newsArray = [NSMutableArray arrayWithArray:newsArray];
        [self updateTableView];
    }];
    
    [self.tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NewsTableViewCell class])];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.navigationItem.title = @"News";
}

- (void)updateTableView
{
    dispatch_async( dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewsTableViewCell class]) forIndexPath:indexPath];
    
    NewsModel *articleForCell = self.newsArray[indexPath.row];
    
    if (articleForCell.image != nil)
    {
        cell.coverImageView.image = articleForCell.image;
    }
    else
    {
        NetworkService *service = [NetworkService new];
        [service getImageFromURL:articleForCell.imageURL completion:^(UIImage * _Nonnull picture) {
            dispatch_async(dispatch_get_main_queue(), ^{
                CIImage *cropImage = [[CIImage alloc] initWithImage:picture options:nil];
                cropImage = [cropImage imageByCroppingToRect:CGRectMake(0.0f, 100.0f, cell.coverImageView.bounds.size.width, 200.0f)];
                UIImage *image = [UIImage imageWithCIImage:cropImage];
                cell.coverImageView.image = image;
                cell.coverImageView.contentMode = UIViewContentModeScaleAspectFit;
                self.newsArray[indexPath.item].image = image;
            });
        }];
    }
    
    cell.titleLabel.text = [NSString stringWithFormat:@"\t%@", articleForCell.title];
    NSDate *postDate = [NSDate dateWithTimeIntervalSince1970:articleForCell.date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm dd MMM yyyy";
    NSString *dateString = [dateFormatter stringFromDate:postDate];
    NSString *dateTextLabel = [NSString stringWithFormat:@"Published on: %@", dateString];
    //Вот с датой я хз- с API просто приходит число, и в документации нет описания,
    //откуда его считать. С 1970, очевидно, не очень хорошо работает.
    
    cell.dateLabel.text = dateTextLabel;
    [cell makeConstrainst];
    
    return cell;
}

@end
