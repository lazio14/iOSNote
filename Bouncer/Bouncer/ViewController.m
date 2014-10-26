//
//  ViewController.m
//  Bouncer
//
//  Created by lazio14 on 14/10/26.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

@property (nonatomic, strong) UIView *redBlock;
@property (nonatomic, strong) UIView *blackBlock;
@property (nonatomic, strong) UIDynamicAnimator* animator;
@property (nonatomic, weak) UICollisionBehavior* collider;
@property (nonatomic, weak) UIGravityBehavior* gravity;
@property (nonatomic, weak) UIDynamicItemBehavior* elastic;
@property (nonatomic, strong) CMMotionManager* motionManager;
@end

@implementation ViewController

- (CMMotionManager*) motionManager
{
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.accelerometerUpdateInterval = 0.1;
    }
    return _motionManager;
}

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
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self resumeGame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pauseGame
{
    NSLog(@"pauseGame");
    [self.motionManager stopAccelerometerUpdates];
    self.gravity.gravityDirection = CGVectorMake(0, 0);
}

- (void) resumeGame
{
    if (!self.redBlock) {
        self.redBlock = [self addBlockOffsetFromCenterBy:(UIOffsetMake(-100, 0))];
    }
    self.redBlock.backgroundColor = [UIColor redColor];
    [self.collider addItem: self.redBlock];
    [self.gravity addItem: self.redBlock];
    [self.elastic addItem: self.redBlock];
    
    if (!self.blackBlock) {
        self.blackBlock = [self addBlockOffsetFromCenterBy:UIOffsetMake(100, 0)];
    }
    self.blackBlock.backgroundColor = [UIColor blackColor];
    [self.collider addItem:self.blackBlock];
    
    if (!self.motionManager.isAccelerometerActive) {
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            CGFloat x = accelerometerData.acceleration.x;
            CGFloat y = accelerometerData.acceleration.y;
            //self.gravity.gravityDirection = CGVectorMake(x, y);
            
            switch (self.interfaceOrientation) {
                case UIInterfaceOrientationLandscapeRight:
                    self.gravity.gravityDirection = CGVectorMake(-y, -x);
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                    self.gravity.gravityDirection = CGVectorMake(y, x);
                    break;
                case UIInterfaceOrientationPortrait:
                    self.gravity.gravityDirection = CGVectorMake(x, -y);
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                    self.gravity.gravityDirection = CGVectorMake(-x, y);
                    break;
        
                default:
                    break;
            }
            
        }];
    }
}

- (BOOL) isPause
{
    return !self.motionManager.accelerometerActive;
}

- (void)tap
{
    NSLog(@"tap");
    if ([self isPause])
    {
        [self resumeGame];
    }
    else
    {
        [self pauseGame];
    }
}

@end
