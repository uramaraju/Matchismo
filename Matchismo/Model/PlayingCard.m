//
//  PlayingCard.m
//  Matchismo
//
//  Created by Umasankar Ramaraju on 1/27/13.
//  Copyright (c) 2013 Umasankar Ramaraju. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

+(NSArray*)validSuits
{
    return @[@"♠",@"♣",@"♥",@"♦"];
}

+(NSArray *) rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger) maxRank
{
    return ([PlayingCard rankStrings].count - 1);
}

-(void) setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

-(void) setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:(suit)])
    {
        _suit = suit;
    }
}

-(NSString*) suit
{
    return _suit ? _suit : @"?";
}

-(NSString*) contents
{
    NSString* rankString = [PlayingCard rankStrings] [self.rank];
    return [rankString stringByAppendingString:self.suit];
}

- (NSAttributedString *) attributedContents
{
    return [[NSAttributedString alloc] initWithString:self.contents];
}
-(int)match:(NSArray *)others
{
    if (others.count==1)
    {
        PlayingCard* px = others[0];
        NSString* x = px.suit;
        NSString* y = self.suit;
        
        int score = [x isEqualToString:y] ? 1 : 0;
        if (!score)
        {
            score = (px.rank == self.rank) ? 4 : 0;
        }
        return score;
    }
    else if (others.count > 1)
    {
        //it has a bug, subtle.
        NSRange range = NSMakeRange(1,others.count-1);
        NSArray* nextCards = [others subarrayWithRange:range];
        PlayingCard* firstCard = others[0];
        int subScore =  [firstCard match:nextCards];
        if (subScore)
        {
            return MIN(subScore, [self match:@[firstCard]]);
        }
    }
    return 0;
}

@end
