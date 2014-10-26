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
@property (nonatomic, strong) UIDynamicAnimator* animator;
@property (nonatomic, weak) UICollisionBehavior* collider;
@property (nonatomic, weak) UIGravityBehavior* gravity;
@property (nonatomic, weak) UIDynamicItemBehavior* elastic;
@end

@implementation ViewController

- (UIDynamicAnimator*)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

- (UICollisionBehavior*) collider
{
    if (!_collider) {
        UICollisionBehavior* collider = [[UICollisionBehavior alloc] init];
        collider.translatesReferenceBoundsIntoBoundary = YES;
        [self.animator addBehavior:collider];
        self.collider = collider;
    }
    return _collider;
}

- (UIGravityBehavior*) gravity
{
    if (!_gravity) {
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
        [self.animator addBehavior:gravity];
        self.gravity = gravity;
    }
    return _gravity;
}

- (UIDynamicItemBehavior*) elastic
{
    if (!_elastic) {
        UIDynamicItemBehavior* elastic = [[UIDynamicItemBehavior alloc] init];
        elastic.elasticity = 1.0;
        [self.animator addBehavior:elastic];
        self.elastic = elastic;
    }
    return _elastic;
}

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
    [self.collider addItem: self.redBlock];
    [self.gravity addItem: self.redBlock];
    [self.elastic addItem: self.redBlock];
}

@end
