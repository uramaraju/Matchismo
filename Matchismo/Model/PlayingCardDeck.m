//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Umasankar Ramaraju on 1/27/13.
//  Copyright (c) 2013 Umasankar Ramaraju. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"
@implementation PlayingCardDeck
-(id)init
{
    self = [super init];
    if (self)
    {
        for (NSString* suit in [PlayingCard validSuits])
        {
            for (NSUInteger rank=1; rank < [PlayingCard maxRank]; rank++)
            {
                PlayingCard* pc = [[PlayingCard alloc]init];
                pc.rank = rank;
                pc.suit = suit;
                [self addCard:pc atTop:NO];
            }
        }
    }
    return self;
}
@end
