//
//  TextStatsViewController.m
//  Attributor
//
//  Created by lazio14 on 14-9-20.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorCntLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCntLabel;

@end

@implementation TextStatsViewController

-(void) setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    // 如果显示在界面上
    if (self.view.window)
    {
        [self updateUI];
    }
}

//- (void) viewDidLoad
//{
//    [super viewDidLoad];
//// just for test
//    self.textToAnalyze = [[NSAttributedString alloc] initWithString:@"test" attributes:@{NSForegroundColorAttributeName:[UIColor greenColor],NSStrokeWidthAttributeName:@-3}];
//    [self updateUI];
//}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName
{
    NSMutableAttributedString *character = [[NSMutableAttributedString alloc] init];
    int index = 0;
    while (index < [self.textToAnalyze length])
    {
        NSRange range;
        
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value)
        {
            [character appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index += range.location + range.length;
        }
        else
        {
            index++;
        }
    }
    return character;
}

- (void) updateUI
{
    self.colorCntLabel.text = [NSString stringWithFormat:@"%d colorful characters",     [[self charactersWithAttribute:NSForegroundColorAttributeName] length]];

    self.outlinedCntLabel.text = [NSString stringWithFormat:@"%d outlined characters",     [[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}


@end