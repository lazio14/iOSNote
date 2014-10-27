//
//  CameraViewController.m
//  CameraTest
//
//  Created by lazio14 on 14-10-20.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController () <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

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
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"AlertViewTest"
                                                   message:@"message"
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"OtherBtn",nil];
    [alert show];
    
    
    
    


}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"didFinishPickingMediaWithInfo");
    UIImage* editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    self.photoView.image = editedImage;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)Done:(id)sender {
    NSLog(@"Done button click");
    
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"SORRY NO CAMERA IS AVALIBLE");
    }
    else
    {
        NSLog(@"CAMERA IS OK");
    }
    
    
    
    UIImagePickerController *uiipc = [[UIImagePickerController alloc] init];
    uiipc.allowsEditing = YES;
    uiipc.delegate = self;

    uiipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentModalViewController:uiipc animated:YES];
}


@end
