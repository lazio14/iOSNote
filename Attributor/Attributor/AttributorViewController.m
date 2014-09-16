//
//  AttributorViewController.m
//  Attributor
//
//  Created by lazio14 on 14-9-8.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "AttributorViewController.h"

@interface AttributorViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *headLine;
@property (weak, nonatomic) IBOutlet UIButton *outLineButton;


@end

@implementation AttributorViewController

- (IBAction)changeColor:(UIButton *)sender {
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.body.selectedRange];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outLineButton.currentTitle];
    [title setAttributes: @{NSStrokeWidthAttributeName:@3,
                            NSStrokeColorAttributeName:[UIColor blackColor]}
                   range:NSMakeRange(0, [title length])];
    [self.outLineButton setAttributedTitle:title forState:UIControlStateNormal];

}

- (IBAction)outLineBodySelection:(UIButton *)sender {
    [self.body.textStorage addAttributes: @{NSStrokeWidthAttributeName:@-3,
                                            NSStrokeColorAttributeName:[UIColor blackColor]
                                            }
                                   range:self.body.selectedRange];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self usePreferredfonts];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(perferredFontsChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
        name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void) perferredFontsChanged:(NSNotification *) notification
{
    [self usePreferredfonts];
}

- (void) usePreferredfonts
{
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headLine.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

- (IBAction)unoutLineBodySelection:(UIButton *)sender {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.body.selectedRange];
}
@end


