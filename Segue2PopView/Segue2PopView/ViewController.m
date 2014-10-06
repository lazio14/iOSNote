//
//  ViewController.m
//  Segue2PopView
//
//  Created by lazio14 on 14-10-6.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "ViewController.h"
#import "PopViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[PopViewController class]])
    {
        PopViewController* popView = (PopViewController*)segue.destinationViewController;
        popView.viewTitle = @"HELLO";
    }
    else
    {
        NSLog(@"Something may be error");
    }
}

@end
