//
//  ImageViewController.m
//  Imaginarium
//
//  Created by lazio14 on 14-9-27.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate, UISplitViewControllerDelegate>

@property (strong, nonatomic) UIImageView* imageView;
@property (strong, nonatomic) UIImage  *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;


@end

@implementation ImageViewController

- (void) setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    
    _scrollView.minimumZoomScale = 0.2;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.delegate = self;
    
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void) setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    //self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
    [self startDownloadingImage];
}

- (void) startDownloadingImage
{
    self.image = nil;
    if (self.imageURL) {
        [self.spinner startAnimating];
        NSURLRequest* request = [NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                      completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                          if (!error)
                                          {
                                              if ([request.URL isEqual:self.imageURL]) {
                                                  UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]]; // 这张图片不会持久保存。
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      self.image = image;
                                                  });
                                              }
                                          }
                                      }];
        [task resume];
    }
}

- (UIImageView*) imageView
{
    if (!_imageView) _imageView = [[UIImageView alloc] init];
    return _imageView;
}

- (UIImage *) image
{
    return self.imageView.image;
}

- (void) setImage:(UIImage *)image
{
    self.scrollView.zoomScale = 1.0;
    self.imageView.image = image;
    
    self.scrollView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [self.imageView sizeToFit];
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
    [self.spinner stopAnimating];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self.view addSubview:self.imageView];
    [self.scrollView addSubview:self.imageView];
}

#pragma mark UISplitViewControllerDelegate
- (void)awakeFromNib
{
    self.splitViewController.delegate = self;
}


- (BOOL) splitViewController:(UISplitViewController *)svc
    shouldHideViewController:(UIViewController *)vc
               inOrientation:(UIInterfaceOrientation)orientation
{
    //return UIInterfaceOrientationIsPortrait(orientation);
    return false;
}
@end
