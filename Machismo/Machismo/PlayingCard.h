//
//  PlayingCard.h
//  Deck
//
//  Created by lazio14 on 14-9-3.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString* suit;
@property (nonatomic) unsigned long rank;

+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;

@end
