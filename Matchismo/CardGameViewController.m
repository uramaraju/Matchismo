//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Umasankar Ramaraju on 1/27/13.
//  Copyright (c) 2013 Umasankar Ramaraju. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
@interface CardGameViewController ()
@property (strong,nonatomic) PlayingCardDeck* deck;
@property (weak, nonatomic) IBOutlet UILabel *flipCountLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation CardGameViewController

-(PlayingCardDeck*)deck
{
    if (!_deck)
    {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    for (UIButton* button in self.cardButtons)
    {
        Card* card = [self.deck drawRandomCard];
        [button setTitle:card.contents forState:UIControlStateSelected];
    }
}

- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    self.flipCount++;
}

@end
