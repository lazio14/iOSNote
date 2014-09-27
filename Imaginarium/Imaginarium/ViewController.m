//
//  ViewController.m
//  Imaginarium
//
//  Created by lazio14 on 14-9-27.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]])
    {
        ImageViewController* ivc = (ImageViewController*) segue.destinationViewController;
        ivc.imageURL = [NSURL URLWithString:@"http://g-ecx.images-amazon.com/images/G/01/kindle/dp/2014/KB/kb-slate-01-lg._V325449022_.jpg"];
        ivc.title = segue.identifier;
    }
}

@end
