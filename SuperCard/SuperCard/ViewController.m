//
//  ViewController.m
//  SuperCard
//
//  Created by lazio14 on 14-9-20.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "ViewController.h"
#import "PalyingCardView.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PalyingCardView *playingCardView;
@property (strong, nonatomic) Deck* deck;
@end

@implementation ViewController

- (Deck*)deck
{
    if (!_deck)
    {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}

- (void)drawRandomPlayingCard
{
    Card* card = [self.deck drawRandomCard];
    if ([card isKindOfClass:[Card class]])
    {
        PlayingCard *playingCard = (PlayingCard*)card;
        self.playingCardView.rank = playingCard.rank;
        self.playingCardView.suit = playingCard.suit;
    }
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    self.playingCardView.faceUp = !self.playingCardView.faceUp;
    if (self.playingCardView.faceUp)
    {
        [self drawRandomPlayingCard];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.playingCardView.faceUp = NO;
    [self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView action:@selector(pinch:)]];
}
@end
