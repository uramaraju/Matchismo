//
//  Card.m
//  Matchismo
//
//  Created by Umasankar Ramaraju on 1/27/13.
//  Copyright (c) 2013 Umasankar Ramaraju. All rights reserved.
//

#import "Card.h"

@implementation Card
-(int)match:(NSArray *)others
{
    for (Card* card in others) {
        if([card.contents isEqualToString:self.contents])
            return 1;
    }
    return 0;
}
@end
