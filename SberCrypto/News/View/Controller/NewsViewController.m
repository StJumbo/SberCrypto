//
//  NewsViewController.m
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsPresenterClass.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"
@import SafariServices;

@interface NewsViewController () <SFSafariViewControllerDelegate>

@property (nonatomic) NSMutableArray<NewsModel *> *newsArray;
@property (nonatomic, strong) NewsPresenterClass *presenter;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.presenter = [NewsPresenterClass new];
    [self.presenter createDelegates];
    
    [self.tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NewsTableViewCell class])];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.navigationItem.title = @"News";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.presenter getNewsArray:^(NSArray<NewsModel *> * _Nonnull newsArray) {
        self.newsArray = [NSMutableArray arrayWithArray:newsArray];
        [self updateTableView];
    }];
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
    
    cell.titleLabel.text = articleForCell.title;
    cell.dateLabel.text = articleForCell.date;
    
    if (articleForCell.image != nil)
    {
        cell.coverImageView.image = articleForCell.image;
    }
    else
    {
        [self.presenter getImageFromURL:articleForCell.imageURL completion:^(UIImage * _Nonnull picture) {
            dispatch_async(dispatch_get_main_queue(), ^{
                CIImage *cropImage = [[CIImage alloc] initWithImage:picture options:nil];
                cropImage = [cropImage imageByCroppingToRect:CGRectMake(0.0f, 0.0f + picture.size.height / 3, cell.coverImageView.bounds.size.width, 200.0f)];
                UIImage *image = [UIImage imageWithCIImage:cropImage];
                cell.coverImageView.image = image;
                cell.coverImageView.contentMode = UIViewContentModeScaleAspectFit;
                self.newsArray[indexPath.item].image = image;
            });
        }];
    }
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self openCurrentURLinSafari:self.newsArray[indexPath.row].articleURL readingModeNeeded:YES];
}


#pragma mark - SFSafariServices delegate

-(void)openCurrentURLinSafari: (NSString *)URL readingModeNeeded:(BOOL)readingMode
{
    NSURL *url = [[NSURL alloc] initWithString:URL];
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url entersReaderIfAvailable:readingMode];
    safariVC.delegate = self;
    [self presentViewController:safariVC animated:YES completion:nil];
}

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
