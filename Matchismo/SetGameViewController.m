//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Umasankar Ramaraju on 2/10/13.
//  Copyright (c) 2013 Umasankar Ramaraju. All rights reserved.
//

#import "SetGameViewController.h"
#import "CardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"
@interface SetGameViewController ()
@end

@implementation SetGameViewController
@synthesize game = _game;
-(CardMatchingGame*) game
{
    if (!_game)
    {
        SetCardDeck* deck = [[SetCardDeck alloc]init];
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:deck                                                             matchingCount:3] ;
        
    }
    return _game;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
