//
//  PalyingCardView.m
//  SuperCard
//
//  Created by lazio14 on 14-9-20.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "PalyingCardView.h"

@implementation PalyingCardView

#pragma mark - Properties
- (void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

- (void) setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat) cornerScaleFactor
{
    return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat) cornerRadius
{
    return CORNER_RADIUS * [self cornerScaleFactor];
}

- (CGFloat) cornerOffset
{
    return [self cornerRadius] / 3.0;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    NSLog(@"radius:%f", [self cornerRadius]);
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blueColor] setStroke];
    [roundedRect stroke];
}


#pragma mark - init
- (void)setUp
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setUp];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
