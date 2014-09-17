//
//  PlayingCardControllerViewController.m
//  Machismo
//
//  Created by lazio14 on 14-9-17.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "PlayingCardControllerViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardControllerViewController ()

@end

@implementation PlayingCardControllerViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end
