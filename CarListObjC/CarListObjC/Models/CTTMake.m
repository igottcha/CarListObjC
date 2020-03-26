//
//  CTTMake.m
//  CarListObjC
//
//  Created by Chris Gottfredson on 3/26/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

#import "CTTMake.h"

@implementation CTTMake

- (instancetype)initWithName:(NSString *)name makeID:(NSInteger)makeID
{
    self = [super init];
    if (self)
    {
        _name = name;
        _makeID = makeID;
    }
    return self;
}

@end

@implementation CTTMake (JSONConvertible)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"Make_Name"];
    NSInteger makeID = [dictionary[@"Make_ID"] integerValue];
    
    return [self initWithName:name makeID:makeID];
}

@end
