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

- (NSString*)updateScore:(NSArray *)otherCards card:(Card *)card
{
    int matchScore = [card match:otherCards];
    NSString* otherCardText = @"";
    for (Card* oc in otherCards) {
        otherCardText = [NSString stringWithFormat:@"%@ %@", otherCardText, oc.contents];
    }
    if (matchScore)
    {
        card.unplayable = YES;
        for (Card* otherCard in otherCards)
        {
            otherCard.unplayable = YES;
        }
        int increment = matchScore * self.matchingCardCount * (self.matchingCardCount);
        self.score += increment;
        return [NSString stringWithFormat:@"Cards %@,%@ match for score %d",card.contents,otherCardText,increment];
    }
    else
    {
        for (Card* otherCard in otherCards)
        {
            otherCard.faceUp = NO;
        }
        self.score -= self.matchingCardCount;
        return [NSString stringWithFormat:@"Cards %@,%@ didn't match",card.contents,otherCardText];
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
            NSMutableArray* otherCards = [[NSMutableArray alloc]initWithCapacity:self.matchingCardCount];
            for (Card* otherCard in self.cards)
            {
                if (otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    [otherCards addObject:otherCard];
                }
            }
            if (otherCards.count == self.matchingCardCount-1)
            {
                self.statusMessage = [self updateScore:otherCards card:card];
            }
            else
            {
                self.score -= FLIP_COST;
            }
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
