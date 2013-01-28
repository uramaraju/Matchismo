//
//  Deck.m
//  Matchismo
//
//  Created by Umasankar Ramaraju on 1/27/13.
//  Copyright (c) 2013 Umasankar Ramaraju. All rights reserved.
//

#import "Deck.h"
@interface Deck()
@property (strong,nonatomic) NSMutableArray* cards;
@end

@implementation Deck

-(NSMutableArray*) cards
{
    if (!_cards)
    {
        _cards = [[NSMutableArray alloc]init];
    }
    return _cards;
}
-(void)addCard:(Card *)card atTop:(BOOL)isAtTop
{
    if (isAtTop)
    {
        [self.cards insertObject:card atIndex:(self.cards.count)];
    }
    else
    {
        [self.cards addObject:card];
    }
}
-(Card*)drawRandomCard
{
    Card* random = nil;
    if (self.cards.count)
    {
        int index = arc4random() % self.cards.count;
        random = self.cards[index];
        // do we need to remove the random one ?
    }
    return random;
}
@end
