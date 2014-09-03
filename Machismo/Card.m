//
//  Card.m
//  Deck
//
//  Created by lazio14 on 14-9-3.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "Card.h"

@implementation Card


- (int)match:(NSArray*)otherCards
{
    int score = 0;
    for (Card* card in otherCards)
    {
        if ([card.contents isEqualToString:self.contents])
        {
            score = 1;
        }
    }
    return score;
}

@end