//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Umasankar Ramaraju on 2/10/13.
//  Copyright (c) 2013 Umasankar Ramaraju. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"
@implementation SetCardDeck
-(id)init
{
    self = [super init];
    if (self)
    {
        for (int rank =[SetCard minRank]; rank <= [SetCard maxRank]; rank++)
        {
            for (NSString* color in [SetCard validColors])
            {
                for (NSString* shade in [SetCard validShades])
                {
                    for (NSString* symbol in [SetCard validSymbols])
                    {
                        SetCard *card = [[SetCard alloc]initWithRank:rank
                                                              symbol:symbol
                                                               color:color
                                                               shade:shade];
                        [self addCard:card atTop:false];
                    }
                }
            
            }
        
        }
    }
    return self;
}
@end
