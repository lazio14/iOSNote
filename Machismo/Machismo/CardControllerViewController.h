//
//  CardControllerViewController.h
//  Machismo
//
//  Created by lazio14 on 14-8-28.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

// abstract class. Must implement method as describe below

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardControllerViewController : UIViewController
- (IBAction)flipCard:(id)sender;
@property (nonatomic) Deck* deck;

// protected
// for subclass
- (Deck *)createDeck; // abstract
@end
