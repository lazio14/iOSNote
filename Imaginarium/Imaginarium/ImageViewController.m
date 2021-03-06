//
//  ImageViewController.m
//  Imaginarium
//
//  Created by lazio14 on 14-9-27.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>

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
    self.imageView.image = image;
    [self.spinner stopAnimating];
    [self.imageView sizeToFit];
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self.view addSubview:self.imageView];
    [self.scrollView addSubview:self.imageView];
}

@end
