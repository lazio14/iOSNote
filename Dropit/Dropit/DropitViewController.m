//
//  DropitViewController.m
//  Dropit
//
//  Created by lazio14 on 14-9-21.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "DropitViewController.h"

@interface DropitViewController ()
@property (weak, nonatomic) IBOutlet UIView *gameView;

@end

static const CGSize DROP_SIZE = {40, 40};

@implementation DropitViewController
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    [self drop];
}

- (void) drop
{
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROP_SIZE;
    int x = (arc4random() % (int)self.gameView.bounds.size.width) / DROP_SIZE.width;
    frame.origin.x = x * DROP_SIZE.width;
    
    UIView *dropView = [[UIView alloc] initWithFrame:frame];
    dropView.backgroundColor = [self randomColor];
    [self.gameView addSubview:dropView];
}

- (UIColor*)randomColor
{
    switch (arc4random() % 5) {
        case 0: return [UIColor blueColor];
        case 1: return [UIColor yellowColor];
        case 2: return [UIColor greenColor];
        case 3: return [UIColor grayColor];
        case 4: return [UIColor orangeColor];
        default: return [UIColor blackColor];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
