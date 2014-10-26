//
//  ViewController.m
//  Bouncer
//
//  Created by lazio14 on 14/10/26.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *redBlock;

@end

@implementation ViewController

static CGSize blockSize = {40, 40};

- (UIView *)addBlockOffsetFromCenterBy:(UIOffset)offset
{
    CGPoint blockCenter = CGPointMake(CGRectGetMaxX(self.view.bounds) + offset.horizontal,
                                      CGRectGetMaxY(self.view.bounds) + offset.vertical);
    CGRect blockFrame = CGRectMake((blockCenter.x - blockSize.width) / 2, (blockCenter.y - blockSize.height) / 2, blockSize.width, blockSize.height);
    UIView *block = [[UIView alloc] initWithFrame:blockFrame];
    [self.view addSubview:block];
    return block;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self startGame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) startGame
{
    self.redBlock = [self addBlockOffsetFromCenterBy:(UIOffsetMake(0, 0))];
    self.redBlock.backgroundColor = [UIColor redColor];
}

@end
