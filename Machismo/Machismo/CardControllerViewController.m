//
//  CardControllerViewController.m
//  Machismo
//
//  Created by lazio14 on 14-8-28.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "CardControllerViewController.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface CardControllerViewController ()
//@property (weak, nonatomic) IBOutlet UILabel *cntLabel;
//@property (nonatomic) int flipCnt;
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation CardControllerViewController

- (CardMatchingGame *)game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    }
    return _game;
}

- (Deck*) deck
{
    if (!_deck)
    {
        _deck = [self createDeck];
    }
    return _deck;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.flipCnt = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void) setFlipCnt:(int)flipCnt
//{
//    _flipCnt = flipCnt;
//    self.cntLabel.text = [NSString stringWithFormat:@"%d", self.flipCnt];
//}

- (IBAction)flipCard:(id)sender {
//    if ([[sender currentTitle] length])
//    {
//        [sender setBackgroundImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
//        [sender setTitle:@"" forState:UIControlStateNormal];
//        self.flipCnt++;
//    }
//    else
//    {
//        Card* card = [self.deck drawRandomCard];
//        if (card)
//        {
//            [sender setTitle:card.contents forState:UIControlStateNormal];
//            [sender setBackgroundImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
//            self.flipCnt++;
//        }
//    }
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}


- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card* card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score:%d", self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage*)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:(card.isChosen ?  @"4" : @"9")];
}


@end
