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
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:0.0f];

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
    
    cell.titleLabel.text = articleForCell.title;
//    NSString *dateString = [NSString stringWithFormat:@"%d", articleForCell.date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    NSDate *dateFromString = [myDateFormatter date
    cell.dateLabel.text = @"qqqqqqqqq";
    [cell makeConstrainst];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300.0f;
}

@end
