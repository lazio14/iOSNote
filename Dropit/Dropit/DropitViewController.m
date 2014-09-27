//
//  DropitViewController.m
//  Dropit
//
//  Created by lazio14 on 14-9-21.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "DropitViewController.h"
#import "DropitBehavior.h"

@interface DropitViewController () <UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UICollisionBehavior *collider;
@property (strong, nonatomic) DropitBehavior *dropBehavior;
@property (strong, nonatomic) UIAttachmentBehavior *attachment;
@property (strong, nonatomic) UIView* droppingView;
@end

static const CGSize DROP_SIZE = {40, 40};

@implementation DropitViewController

- (UIDynamicAnimator *) animator
{
    if (!_animator)
    {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
        _animator.delegate = self;
    }
    return _animator;
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    [self removeCompleteRow];
}

- (BOOL) removeCompleteRow
{
    NSMutableArray *dropsToRemove = [[NSMutableArray alloc] init];
    for (CGFloat y = self.gameView.bounds.size.height - DROP_SIZE.height / 2; y > 0; y -= DROP_SIZE.height) {
        BOOL rowIsComplete = YES;
        NSMutableArray *dropsFound = [[NSMutableArray alloc] init];
        for (CGFloat x = DROP_SIZE.width / 2; x < self.gameView.bounds.size.width; x += DROP_SIZE.width) {
            UIView *hitView = [self.gameView hitTest:CGPointMake(x, y) withEvent:NULL];
            if ([hitView superview] == self.gameView)
            {
                [dropsFound addObject:hitView];
            }
            else
            {
                rowIsComplete = NO;
            }
        }
        
        if (![dropsFound count]) // 这一行时空的，再往上肯定找不到填满一行的情况。
        {
            break;
        }
        
        if (rowIsComplete)
        {
            [dropsToRemove addObjectsFromArray:dropsFound];
        }
    }
    
    if ([dropsToRemove count])
    {
        for (UIView *drop in dropsToRemove) {
            [self.dropBehavior removeItem:drop];
        }
        [self animateRemovingDrops:dropsToRemove];
    }
    return NO;
}

- (void) animateRemovingDrops:(NSArray *)dropsToRemove
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         for (UIView *drop in dropsToRemove) {
                             int x = (arc4random() % (int)(self.gameView.bounds.size.width * 5)) - (int)self.gameView.bounds.size.width * 2;
                             int y = self.gameView.bounds.size.height;
                             drop.center = CGPointMake(x, -y);
                         }
                     }
                     completion:^(BOOL finished){
                         [dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                     }];
}

- (UIGravityBehavior*) gravity
{
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.magnitude = 0.9;
        [self.animator addBehavior:_gravity];
    }
    return _gravity;
}

- (UICollisionBehavior*) collider
{
    if (!_collider)
    {
        _collider = [[UICollisionBehavior alloc] init];
        _collider.translatesReferenceBoundsIntoBoundary = YES;
        [self.animator addBehavior:_collider];
    }
    return _collider;
}

- (DropitBehavior*) dropBehavior
{
    if (!_dropBehavior)
    {
        _dropBehavior = [[DropitBehavior alloc] init];
        [self.animator addBehavior:_dropBehavior];
    }
    return _dropBehavior;
}

- (UIAttachmentBehavior*)attachment
{
    if (!_attachment)
    {
        _attachment = [[UIAttachmentBehavior alloc] init];
    }
    return _attachment;
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    NSLog(@"TAG222");
    [self drop];
}
- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    NSLog(@"TAG1111");
    CGPoint gesturePoint = [sender locationInView:self.gameView];
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        [self attachDroppingViewToPoint:gesturePoint];
    } else if (sender.state == UIGestureRecognizerStateChanged)
    {
        self.attachment.anchorPoint = gesturePoint;
    } else if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self.animator removeBehavior:self.attachment];
    }
}

- (void) attachDroppingViewToPoint:(CGPoint)anchorPoint
{
    if (self.droppingView)
    {
        self.attachment = [[UIAttachmentBehavior alloc] initWithItem:self.droppingView attachedToAnchor:anchorPoint];
        self.droppingView = nil;
        [self.animator addBehavior:self.attachment];
    }
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
    
    self.droppingView = dropView;
    
//    [self.gravity addItem:dropView];
//    [self.collider addItem:dropView];
    
    [self.dropBehavior addItem:dropView];
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
