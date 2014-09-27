//
//  ImageViewController.m
//  Imaginarium
//
//  Created by lazio14 on 14-9-27.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@property (strong, nonatomic) UIImageView* imageView;
@property (strong, nonatomic) UIImage  *image;

@end

@implementation ImageViewController

- (void) setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
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
    NSLog(@"TAG11");
    self.imageView.image = image;
    [self.imageView sizeToFit];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.imageView];
}

@end
