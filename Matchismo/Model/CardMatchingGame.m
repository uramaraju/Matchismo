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

- (NSString *)contentsOfCards:(NSArray *)cards
{
    NSString* mathcingCardsContents = @"";
    for (Card* card in cards)
    {
        mathcingCardsContents = [NSString stringWithFormat:@"%@ %@", mathcingCardsContents, card.contents];
    }
    return mathcingCardsContents;
}

- (NSString*)updateScoreAndStatusForCard:(Card *)card matching:(NSArray*)cards
{
    int matchScore = [card match:cards];
    NSString *mathcingCardsContents = [self contentsOfCards:cards];
    if (matchScore > 0 )
    {
        card.unplayable = YES;
        for (Card* otherCard in cards)
        {
            otherCard.unplayable = YES;
        }
        int increment = matchScore * self.matchingCardCount * (self.matchingCardCount);
        self.score += increment;
        return [NSString stringWithFormat:@"Cards %@ %@ match for score %d",card.contents,mathcingCardsContents,increment];
    }
    else
    {
        for (Card* otherCard in cards)
        {
            otherCard.faceUp = NO;
        }
        self.score -= self.matchingCardCount;
        return [NSString stringWithFormat:@"Cards %@ %@ didn't match",card.contents,mathcingCardsContents];
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
            NSMutableArray* faceupPlayableCards = [[NSMutableArray alloc]initWithCapacity:self.matchingCardCount];
            for (Card* otherCard in self.cards)
            {
                if (otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    [faceupPlayableCards addObject:otherCard];
                }
            }
            if (faceupPlayableCards.count == self.matchingCardCount-1)
            {
                self.statusMessage = [self updateScoreAndStatusForCard:card matching:faceupPlayableCards];
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
