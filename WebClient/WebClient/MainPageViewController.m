//
//  MainPageViewController.m
//  WebClient
//
//  Created by lazio14 on 14/11/8.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//
#import "Hpple/TFHpple.h"
#import "MainPageViewController.h"

@interface MainPageViewController ()
@property (strong, nonatomic) NSArray *posts;
@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self startDownloadHTMLFile];
    
    
}

- (NSArray *)posts
{
    if (_posts) {
        _posts = [[NSArray alloc] init];
    }
    return _posts;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
        NSInteger len = [elements count];
        for (NSInteger i = 0; i < len; i++) {
            TFHppleElement * element = [elements objectAtIndex:i];
            NSLog(@"%@\n", [element text]);                       // The text inside the HTML element (the content of the first text node)
    
            [element tagName];                    // "a"
            [element attributes];                 // NSDictionary of href, class, id, etc.
            [element objectForKey:@"href"];       // Easy access to single attribute
            [element firstChildWithTagName:@"b"]; // The first "b" child node
        }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

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
