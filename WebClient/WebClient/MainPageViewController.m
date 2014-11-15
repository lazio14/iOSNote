//
//  MainPageViewController.m
//  WebClient
//
//  Created by lazio14 on 14/11/8.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//
#import "Hpple/TFHpple.h"
#import "PostTableViewCell.h"
#import "MainPageViewController.h"

@interface MainPageViewController ()
@property (nonatomic, strong) PostTableViewCell *prototypeCell; // 往里面填充内容，为了计算占用行数。
@end

@implementation MainPageViewController

static NSString *PostCellIdentifier = @"PostCell";

@synthesize posts = _posts;

- (PostTableViewCell *)prototypeCell
{
    if (!_prototypeCell)
    {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:PostCellIdentifier];
    }
    return _prototypeCell;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSMutableArray *)posts
{
    NSLog(@"222222222");
    if (!_posts) {
        _posts = [[NSMutableArray alloc] init];
    }
    return _posts;
}


- (void)setPosts:(NSMutableArray *)posts
{
        NSLog(@"33333333");
    _posts = posts;
    NSLog(@"444444");
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PostCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[PostTableViewCell class]])
    {
        PostTableViewCell *textCell = (PostTableViewCell *)cell;
                textCell.content.numberOfLines = 0;
        textCell.content.text = self.posts[indexPath.row];
        textCell.content.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self configureCell:self.prototypeCell forRowAtIndexPath:indexPath];
    self.prototypeCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(self.prototypeCell.bounds));
    [self.prototypeCell layoutIfNeeded];
    
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

@end
