//
//  DropitBehavior.h
//  Dropit
//
//  Created by lazio14 on 14-9-21.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropitBehavior : UIDynamicBehavior
- (instancetype) init;
@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UICollisionBehavior *collider;
@property (strong, nonatomic) UIDynamicItemBehavior *animationOptions;
- (void) addItem:(id<UIDynamicItem>)item;
- (void) removeItem:(id<UIDynamicItem>)item;
@end
