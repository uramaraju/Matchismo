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
#import "CardMatchingGame.h"
@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipCountLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame* game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeControl;
@end

@implementation CardGameViewController


-(CardMatchingGame*) game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[PlayingCardDeck alloc]init]];
        [self setMatchMode:self.matchModeControl];
    }
    return _game;
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

-(void)updateUI
{
    UIImage *uimage = [UIImage imageNamed:@"card-back.png"];
    for (UIButton* cardButton in self.cardButtons)
    {
        int x = [self.cardButtons indexOfObject:cardButton];
        Card* card = [self.game cardAtIndex:x];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
                cardButton.selected = card.isFaceUp;
        UIImage* image = (!card.isFaceUp ? uimage : nil);
        [cardButton setImage:image
                    forState:UIControlStateNormal];
        cardButton.enabled = !card.isUnplayable;
        [cardButton setTitle:card.contents forState:UIControlStateDisabled|UIControlStateSelected];
        cardButton.alpha = (card.isUnplayable)? 0.3:1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    self.statusLabel.text = self.game.statusMessage;
    self.matchModeControl.enabled = self.flipCount == 0;
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipCountLabel.text = [NSString stringWithFormat:@"Flips:%d",flipCount];
}

- (IBAction)dealAgain:(UIButton *)sender
{
    _game = nil;
    self.flipCount = 0;
    [self updateUI];
}

- (IBAction)setMatchMode:(UISegmentedControl *)sender
{
    NSString* titleOfMode = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    int mode = [titleOfMode intValue] == 0 ? 2 : [titleOfMode intValue];
    NSLog(@"matching mode %d", mode);
    self.game.matchingCardCount= mode;
}

@end
