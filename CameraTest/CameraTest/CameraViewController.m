//
//  CameraViewController.m
//  CameraTest
//
//  Created by lazio14 on 14-10-20.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@end

@implementation CameraViewController

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)cancel:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self fatalAlert:@"test"];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"AlertViewTest"
                                                   message:@"message"
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"OtherBtn",nil];
    [alert show];

}


@end
