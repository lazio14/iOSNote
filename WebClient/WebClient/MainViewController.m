//
//  MainViewController.m
//  WebClient
//
//  Created by lazio14 on 14/11/9.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "Hpple/TFHpple.h"
#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) NSMutableArray *posts;
@end

@implementation MainViewController

static NSString *HTMLURL = @"http://www.qiushibaike.com";
static NSString* postXPath = @"//body//div[@class='content']";

//static NSString *HTMLURL = @"http://makesmethink.com";
//static NSString* postXPath = @"//body//div[@class='post']//p//a";

- (NSMutableArray *) posts
{
    if (!_posts) {
        _posts = [[NSMutableArray alloc] init];
    }
    return _posts;
}

- (UIActivityIndicatorView*) spinner
{
    return _spinner;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self startDownloadHTMLFile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startDownloadHTMLFile {
    [self.spinner startAnimating];
    NSURL* htmlURL = [NSURL URLWithString:HTMLURL];
    NSURLRequest* request = [NSURLRequest requestWithURL:htmlURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                    completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                        if (!error)
                                                        {
                                                            [self parseHTMLContent:location];
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
        // NSLog(@"%@\n", [element text]);                       // The text inside the HTML element (the content of the first text node)
        //            [element tagName];                    // "a"
        //            [element attributes];                 // NSDictionary of href, class, id, etc.
        //            [element objectForKey:@"href"];       // Easy access to single attribute
        //            [element firstChildWithTagName:@"b"]; // The first "b" child node
        [self.posts addObject:[element text]];
        //NSLog(self.posts[i]);
    }
    
    [self.spinner stopAnimating];
    [self showTable:self.posts];
}

- (void) showTable:(NSMutableArray *)posts
{
    NSLog(@"DDDDDDDD");
    MainViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
    NSLog(@"aaaaaa");
    controller.posts = self.posts;
    NSLog(@"BBBB");
    [self.navigationController pushViewController:controller animated:YES];
    NSLog(@"ddddd");
    NSLog(self.posts[1]);
    NSLog(@"EEEEE");

    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
