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
@end

@implementation MainPageViewController

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
    
    NSURL* htmlURL = [NSURL URLWithString:@"http://makesmethink.com"];
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
    NSArray * elements  = [doc searchWithXPathQuery:@"//body//div[@class='post']//p//a"];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.posts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
//    NSDictionary *photo = self.posts[indexPath.row];
//    cell.textLabel.text = [photo valueForKey:@"title"];
//    cell.detailTextLabel.text = [photo valueForKey:@"detail"];
//    cell.textLabel.text = self.posts[indexPath.row];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];

    
    NSLog(self.posts[indexPath.row]);
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[PostTableViewCell class]])
    {
        PostTableViewCell *textCell = (PostTableViewCell *)cell;
        textCell.content.text = self.posts[indexPath.row];
        textCell.content.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    }
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self configureCell:self.prototypeCell forRowAtIndexPath:indexPath];
//    [self.prototypeCell layoutIfNeeded];
//    
//    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    return size.height+1;
//}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
