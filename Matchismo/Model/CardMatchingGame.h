//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Umasankar Ramaraju on 1/29/13.
//  Copyright (c) 2013 Umasankar Ramaraju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"
@interface CardMatchingGame : NSObject

// designated constructor.
-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck*)deck;
-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck*)deck
         matchingCount:(int) matchCount;

-(void) flipCardAtIndex:(NSUInteger)index;
-(Card*) cardAtIndex:(NSUInteger)index;
@property (nonatomic, strong) NSString* statusMessage;
@property (nonatomic,readonly) int score;
@property (nonatomic) int matchingCardCount;
@end
