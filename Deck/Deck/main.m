//
//  main.m
//  Deck
//
//  Created by lazio14 on 14-9-3.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayingCardDeck.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        Deck* deck = [[PlayingCardDeck alloc] init];
        Card* card = [deck drawRandomCard];
        NSLog(card.contents);
    }
    return 0;
}

