//
//  PhotoTVC.m
//  Shutterbug
//
//  Created by lazio14 on 14-10-3.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "PhotoTVC.h"
#import "ImageViewController.h"

@interface PhotoTVC ()

@end

@implementation PhotoTVC

- (void) setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Photo Cell" forIndexPath:indexPath];
    
    NSDictionary *photo = self.photos[indexPath.row];
    cell.textLabel.text = [photo valueForKey:@"title"];
    cell.detailTextLabel.text = [photo valueForKey:@"detail"];
    
    return cell;
}

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

#pragma mark - UITableViewDelegete
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id detail = self.splitViewController.viewControllers[1];
    if ([detail isKindOfClass:[UINavigationController class]])
    {
        detail = [((UINavigationController*)detail).viewControllers firstObject];
    }
    
    if ([detail isKindOfClass:[ImageViewController class]])
    {
#warning you should refactor
        ImageViewController* ivc = (ImageViewController*)detail;
        ivc.imageURL = [self.photos[indexPath.row] valueForKey:@"url"];
        ivc.title = [self.photos[indexPath.row] valueForKey:@"title"];

    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UITableViewCell class]])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath)
        {
            if ([segue.destinationViewController isKindOfClass:[ImageViewController class]])
            {
                ImageViewController* ivc = (ImageViewController*)segue.destinationViewController;
                ivc.imageURL = [self.photos[indexPath.row] valueForKey:@"url"];
                ivc.title = [self.photos[indexPath.row] valueForKey:@"title"];
            }
        }
    }
}


@end
