//
//  PopViewController.m
//  Segue2PopView
//
//  Created by lazio14 on 14-10-6.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "PopViewController.h"

@interface PopViewController ()

@end

@implementation PopViewController

- (void) setViewTitle:(NSString *)viewTitle
{
    _viewTitle = viewTitle;
    [self UIUpdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self UIUpdate];
}

- (void) UIUpdate
{
    self.titleLabel.text = self.viewTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
