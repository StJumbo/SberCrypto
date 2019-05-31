//
//  SBCNewsViewController.m
//  SberCrypto
//
//  Created by Сергей Грызин on 16/05/2019.
//  Copyright © 2019 Сергей Грызин. All rights reserved.
//

#import "SBCNewsViewController.h"
#import "SBCNewsPresenterClass.h"
#import "SBCNewsModel.h"
#import "SBCNewsTableViewCell.h"

@interface SBCNewsViewController () 

@property (nonatomic) NSArray<SBCNewsModel *> *newsArray;
@property (nonatomic) SBCNewsPresenterClass *presenter;

@end

@implementation SBCNewsViewController


#pragma mark - ViewController init

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.presenter = [[SBCNewsPresenterClass alloc] initWithRootController:self];
        
        [self.tableView registerClass:[SBCNewsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SBCNewsTableViewCell class])];
        [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteAllNews)];
        
        self.navigationItem.rightBarButtonItem = deleteButton;
        
        self.navigationItem.title = @"News";
        
        self.tableView.refreshControl = [[UIRefreshControl alloc] init];
        [self.tableView.refreshControl addTarget:self action:@selector(pulledToRefresh) forControlEvents:UIControlEventValueChanged];
    }
    
    return self;
}


#pragma mark - ViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateNewsArray];
}


#pragma mark - Touches handling

-(void)deleteAllNews
{
    [self.presenter deleteButtonPressed];
    self.newsArray = nil;
    [self updateTableView];
}

-(void)pulledToRefresh
{
    [self updateNewsArray];
    
    [self.refreshControl endRefreshing];
}


#pragma mark - Updating data source

-(void)updateNewsArray
{
    [self.presenter updateNewsDataSource:^(NSArray<SBCNewsModel *> * _Nonnull newsArray) {
        self.newsArray = newsArray;
        NSLog(@"\n\n\n\nArticles to show: %lu", (unsigned long)self.newsArray.count);
        [self updateTableView];
    }];
}


#pragma mark - Table view UI update

-(void)updateTableView
{
    dispatch_async( dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SBCNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SBCNewsTableViewCell class]) forIndexPath:indexPath];
    
    SBCNewsModel *articleForCell = _newsArray[indexPath.row];
    
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
                cell.coverImageView.image = picture;
                self.newsArray[indexPath.item].image = picture;
            });
        }];
    }
    
    return cell;
}


#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self openArticleWithURL:self.newsArray[indexPath.row].articleURL readingModeNeed:YES];
}

-(void)openArticleWithURL:(NSString *)URL readingModeNeed:(BOOL)readingMode
{
    [self.presenter openURLInSafari:URL readingModeNeeded:readingMode];
}

@end
