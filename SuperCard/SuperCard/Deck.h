//
//  Deck.h
//  Deck
//
//  Created by lazio14 on 14-9-3.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void) addCard:(Card *)card atTop:(BOOL)atTop;
-(void) addCard:(Card *)card;

-(Card *)drawRandomCard;

@end
