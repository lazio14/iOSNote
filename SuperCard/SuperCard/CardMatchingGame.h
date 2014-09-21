//
//  CardMatchingGame.h
//  Machismo
//
//  Created by lazio14 on 14-9-6.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

- (instancetype) initWithCardCount:(NSUInteger) count
                         usingDeck:(Deck*)deck;

- (void) chooseCardAtIndex:(NSUInteger) index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@end
