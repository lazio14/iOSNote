//
//  CardMatchingGame.m
//  Machismo
//
//  Created by lazio14 on 14-9-6.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;

@end

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 1;
static const int COST_TO_CHOOSE = 1;

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards)
    {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self)
    {
        for (int i = 0; i < count; i++) {
            Card* card = [deck drawRandomCard];
            if (card)
            {
                [self.cards addObject:card];
            }
            else
            {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    // 如果匹配了，UI上会禁用该牌的点击。
    // 为了与UI一致，算法不对已经匹配的牌做处理。
    if (!card.isMatched)
    {
        if (card.isChosen) {
            // 牌翻向背面时，只是简单的设置状态。无需其他判断。
            card.chosen = NO;
        }
        else
        {
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched)
                {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore)
                    {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    }
                    else
                    {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    //    if (index < [self.cards count])
    //    {
    //        return self.cards[index];
    //    }
    //    else
    //    {
    //        return nil;
    //    }
    
    return index < [self.cards count] ? self.cards[index] : nil;
}



@end
