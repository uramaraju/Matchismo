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
    NSString* x = [PlayingCard rankStrings] [self.rank];
    return [x stringByAppendingString:self.suit];
}

-(int)match:(NSArray *)others
{
    if (others.count==1)
    {
        PlayingCard* playingCard = [others lastObject];
        int score = [(playingCard.suit) isEqualToString:self.suit] ? 1 : 0;
        if (!score)
        {
            score = (playingCard.rank == self.rank) ? 4 : 0;
        }
        return score;
    }
    return 0;
}

@end
