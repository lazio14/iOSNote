//
//  TextStatsViewController.m
//  Attributor
//
//  Created by lazio14 on 14-9-20.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()

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

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self updateUI];
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName
{
    return nil;
}

- (void) updateUI
{
    
}


@end