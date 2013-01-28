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
- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (sender.selected)
    {
        Card* card = [self.deck drawRandomCard];
        if (card)
        {
            NSString* cardContents = card.contents;
            [sender setTitle:cardContents forState:UIControlStateSelected];
            self.flipCount++;
            self.flipCountLabel.Text = [NSString stringWithFormat:@"flips: %d",_flipCount];
        }
        
    }
    
}

@end
