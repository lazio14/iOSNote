//
//  CardControllerViewController.m
//  Machismo
//
//  Created by lazio14 on 14-8-28.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "CardControllerViewController.h"

@interface CardControllerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cntLabel;

@property (nonatomic) int flipCnt;
@end

@implementation CardControllerViewController

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
    self.flipCnt = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setFlipCnt:(int)flipCnt
{
    _flipCnt = flipCnt;
    self.cntLabel.text = [NSString stringWithFormat:@"%d", self.flipCnt];
}

- (IBAction)flipCard:(id)sender {
    if ([[sender currentTitle] length])
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
        self.flipCnt++;
    }
    else
    {
        Card* card = [self.deck drawRandomCard];
        if (card)
        {
            [sender setTitle:card.contents forState:UIControlStateNormal];
            [sender setBackgroundImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
        }
        self.flipCnt++;
    }
}



@end
