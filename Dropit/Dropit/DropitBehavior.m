//
//  DropitBehavior.m
//  Dropit
//
//  Created by lazio14 on 14-9-21.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "DropitBehavior.h"

@implementation DropitBehavior

- (void) addItem:(id<UIDynamicItem>)item
{
    [self.gravity addItem:item];
    [self.collider addItem:item];
}

- (void) removeItem:(id<UIDynamicItem>)item
{
    [self.gravity removeItem:item];
    [self.collider removeItem:item];
}



- (UIGravityBehavior*) gravity
{
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.magnitude = 0.9;
    }
    return _gravity;
}

- (UICollisionBehavior*) collider
{
    if (!_collider)
    {
        _collider = [[UICollisionBehavior alloc] init];
        _collider.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collider;
}


- (instancetype) init
{
    self = [super init];
    [self addChildBehavior:self.gravity];
    [self addChildBehavior:self.collider];
    return self;
}

@end
