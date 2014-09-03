//
//  CardControllerViewController.h
//  Machismo
//
//  Created by lazio14 on 14-8-28.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardDeck.h"

@interface CardControllerViewController : UIViewController
- (IBAction)flipCard:(id)sender;
@property (nonatomic) PlayingCardDeck* deck;
@end
