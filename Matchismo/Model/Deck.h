//
//  Deck.h
//  Matchismo
//
//  Created by Umasankar Ramaraju on 1/27/13.
//  Copyright (c) 2013 Umasankar Ramaraju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject
-(void) addCard:(Card*)card atTop:(BOOL)isAtTop;
-(Card*) drawRandomCard;
@end
