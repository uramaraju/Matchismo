//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Umasankar Ramaraju on 1/29/13.
//  Copyright (c) 2013 Umasankar Ramaraju. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()
@property (nonatomic,readwrite) int score;
@property (nonatomic,strong) NSMutableArray* cards;//Card
@end

@implementation CardMatchingGame


-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck*)deck
{
    self = [super init];
    if (self)
    {
        _cards = [[NSMutableArray alloc]initWithCapacity:count];
        for (int i =0; i<count;i++)
        {
            Card* card = [deck drawRandomCard];
            if (card)
            {
                self.cards[i] = card;
            }
            else
            {
                return nil;
            }
        }
        self.matchingCardCount = 2;
        self.statusMessage =@"Deck initialized";
    }
    return self;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (NSString*)updateScore:(Card *)otherCard card:(Card *)card
{
    int matchScore = [card match:@[otherCard]];
    if (matchScore)
    {
        card.unplayable = YES;
        otherCard.unplayable = YES;
        int increment = matchScore * MATCH_BONUS;
        self.score += increment;
        return [NSString stringWithFormat:@"Cards %@,%@ match for score %d",card.contents,otherCard.contents,increment];
    }
    else
    {
        otherCard.faceUp = NO;
        self.score -= MISMATCH_PENALTY;
        return [NSString stringWithFormat:@"Cards %@,%@ didn't match",card.contents,otherCard.contents];
    }
}

-(void)flipCardAtIndex:(NSUInteger)index
{
    self.statusMessage = @"";
    Card* card = [self cardAtIndex:index];
    if (card && !card.isUnplayable)
    {
        if (!card.isFaceUp)
        {
            for (Card* otherCard in self.cards)
            {
                if (otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    self.statusMessage = [self updateScore:otherCard card:card];
                    //todo: I think this is return.
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        else
        {
            self.statusMessage = [NSString stringWithFormat:@"Flipped up %@",card.contents];
        }
        card.faceUp = !card.isFaceUp;
        
    }
}
-(Card*)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index]:nil;
}
@end
