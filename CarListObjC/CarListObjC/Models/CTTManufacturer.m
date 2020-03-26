//
//  CTTManufacturer.m
//  CarListObjC
//
//  Created by Chris Gottfredson on 3/26/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

#import "CTTManufacturer.h"

@implementation CTTManufacturer

- (instancetype)initWithName:(NSString *)name mfrID:(NSInteger)mfrID country:(nonnull NSString *)country
{
    self = [super init];
    if (self)
    {
        _name = name;
        _mfrID = mfrID;
    }
    return self;
}

@end

@implementation CTTManufacturer (JSONConvertible)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *country = dictionary[@"Country"];
    NSInteger mfrID = [dictionary[@"Mfr_ID"] integerValue];
    NSString *name = dictionary[@"Mfr_Name"];
    
    return [self initWithName:name mfrID:mfrID country:country];
}

@end
