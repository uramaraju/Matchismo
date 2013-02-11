//
//  SetCard.m
//  Matchismo
//
//  Created by Umasankar Ramaraju on 2/10/13.
//  Copyright (c) 2013 Umasankar Ramaraju. All rights reserved.
//

#import "SetCard.h"
@interface SetCard()
@property (nonatomic, readwrite) int rank;
@property (nonatomic, readwrite) NSString* symbol;
@property (nonatomic, readwrite) NSString* color;
@property (nonatomic, readwrite) NSString* shade;
@end

@implementation SetCard
-(NSString*) contents
{
    return [NSString stringWithFormat:@"%d %@ %@ %@", self.rank, self.symbol, self.color, self.shade];
}
-(NSAttributedString*) attributedContents
{
    NSString* contentsSymbol = self.symbol;
    for (int i = 1; i < self.rank; i++)
    {
        contentsSymbol = [NSString stringWithFormat:@"%@%@",self.symbol, contentsSymbol];
    }
    NSDictionary *attributes = @{ NSStrokeColorAttributeName     : [self displayColor],
                                 // NSForegroundColorAttributeName : [self shadeColor],
                                  NSBackgroundColorAttributeName : [self shadeColor],
                                  NSStrokeWidthAttributeName     : @-5 };
    NSMutableAttributedString* attributedContents = [[NSMutableAttributedString alloc]initWithString:contentsSymbol attributes:attributes];
   
    return attributedContents;
}

- (UIColor *)displayColor
{
    return [COLORTOUICOLORS objectForKey:self.color];
}

- (UIColor *)shadeColor
{
    UIColor *shadeColor = nil;
       
    if ([self.shade isEqualToString:@"Solid"]) {
        shadeColor = [self displayColor];
    } else if ([self.shade isEqualToString:@"Shade"]) {
        shadeColor = [SHADEDCOLORMAPPINGS objectForKey:self.color];
    } else if ([self.shade isEqualToString:@"Open"]) {
        shadeColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    }
    return shadeColor;
}

-(id)initWithRank:(int)rank symbol:(NSString *)symbol color:(NSString *)color shade:(NSString *)shade
{
    self = [super init];
    if (self)
    {
        if ((rank >= [SetCard minRank] && rank <= [SetCard maxRank])
            && ([[SetCard validSymbols] containsObject:symbol])
            && ([[SetCard validColors] containsObject:color])
            && ([[SetCard validShades] containsObject:shade]))
        {
            _rank = rank;
            _symbol = symbol;
            _color = color;
            _shade = shade;
        } else
        {
            return nil;
        }
    }
    return self;
}
- (int)matchProperties:(NSCountedSet *)properties
{
    int matchScore = 0;
    for (id prop in properties)
    {
        if ([properties countForObject:prop] == 2)
            return 0;
        else
            matchScore =1;
    }
    return matchScore;
}

// todo : test below.
-(int) match:(NSArray *)others
{
    NSMutableArray* cards = [others mutableCopy];
    [cards addObject:self];
    
    NSCountedSet *properties1 = [[NSCountedSet alloc] init];
    for (SetCard* card in cards)
    {
        [properties1 addObject:card.symbol];
    }
    int matchScore1 = [self matchProperties:properties1];
    
    NSCountedSet * properties2 = [[NSCountedSet alloc] init];
    for (SetCard* card in cards)
    {
        [properties2 addObject:card.color];
    }
    int matchScore2 = [self matchProperties:properties2];
    
    NSCountedSet *properties3 = [[NSCountedSet alloc] init];
    for (SetCard* card in cards)
    {
        [properties3 addObject:card.shade];
    }
    int matchScore3 =  [self matchProperties:properties3];
    
    NSCountedSet *properties4 = [[NSCountedSet alloc] init];
    for (SetCard* card in cards)
    {
        [properties4 addObject:@(card.rank)];
    }
    int matchScore4 = [self matchProperties:properties4];
    
    return (pow(3,matchScore1+matchScore2+matchScore3+matchScore4) -1 );
}

+(int) maxRank
{
    return 3;
}
+(int) minRank
{
    return 1;
}

static NSArray* _VALID_COLORS;
static NSDictionary *COLORTOUICOLORS;
static NSDictionary *SHADEDCOLORMAPPINGS;
+(NSArray*) validColors
{
    if (!_VALID_COLORS)
    {
        _VALID_COLORS = @[@"Red", @"Green",@"Blue"];
         COLORTOUICOLORS = @{ @"Red"   : [UIColor redColor],
                                           @"Green" : [UIColor greenColor],
                                           @"Blue"  : [UIColor blueColor] };
        SHADEDCOLORMAPPINGS = @{ @"Red"   : [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.3],
                                 @"Green" : [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.3],
                                 @"Blue"  : [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.3] };


    }
    return _VALID_COLORS;
    
}

static NSArray* _VALID_SYMBOLS;
+(NSArray*) validSymbols
{
    if (!_VALID_SYMBOLS)
    {
        _VALID_SYMBOLS = @[@"○", @"△",@"☐"];
    }
    return _VALID_SYMBOLS;
    
}


static NSArray* _VALID_SHADES;
+(NSArray*) validShades
{
    if (!_VALID_SHADES)
    {
        _VALID_SHADES = @[@"Solid", @"Shade",@"Open"];
    }
    return _VALID_SHADES;
    
}



@end
