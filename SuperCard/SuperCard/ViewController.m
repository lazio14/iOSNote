//
//  ViewController.m
//  SuperCard
//
//  Created by lazio14 on 14-9-20.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "ViewController.h"
#import "PalyingCardView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PalyingCardView *playingCardView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.playingCardView.rank = 13;
    self.playingCardView.suit = @"♣️";
}
@end
