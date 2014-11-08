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
@property (strong, nonatomic) NSMutableArray *posts;
@property (nonatomic, strong) PostTableViewCell *prototypeCell; // 往里面填充内容，为了计算占用行数。
@end

@implementation MainPageViewController

static NSString *PostCellIdentifier = @"PostCell";
static NSString *HTMLURL = @"http://makesmethink.com";
static NSString* postXPath = @"//body//div[@class='post']//p//a";

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
    [self startDownloadHTMLFile];
}

- (NSArray *)posts
{
    if (!_posts) {
        _posts = [[NSMutableArray alloc] init];
    }
    return _posts;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)startDownloadHTMLFile {
    
    NSURL* htmlURL = [NSURL URLWithString:HTMLURL];
    NSURLRequest* request = [NSURLRequest requestWithURL:htmlURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                    completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                        if (!error)
                                                        {
                                                            [self parseHTMLContent:location];
                                                            [self.tableView reloadData];
                                                            
                                                        }
                                                    }];
    [task resume];
    
}

- (void) parseHTMLContent:(NSString *)htmlPath
{
    NSData  * data      = [NSData dataWithContentsOfFile: htmlPath];
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray * elements  = [doc searchWithXPathQuery:postXPath];
    
    [self.posts removeAllObjects];
    NSInteger len = [elements count];
    for (NSInteger i = 0; i < len; i++) {
        TFHppleElement * element = [elements objectAtIndex:i];
        NSLog(@"%@\n", [element text]);                       // The text inside the HTML element (the content of the first text node)
        //            [element tagName];                    // "a"
        //            [element attributes];                 // NSDictionary of href, class, id, etc.
        //            [element objectForKey:@"href"];       // Easy access to single attribute
        //            [element firstChildWithTagName:@"b"]; // The first "b" child node
        [self.posts addObject:[element text]];
    }
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
