//
//  PalyingCardView.h
//  SuperCard
//
//  Created by lazio14 on 14-9-20.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PalyingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (nonatomic, strong) NSString *suit;
@property (nonatomic) BOOL faceUp;

@end
