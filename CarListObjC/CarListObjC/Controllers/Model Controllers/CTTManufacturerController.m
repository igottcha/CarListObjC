//
//  CTTManufacturerController.m
//  CarListObjC
//
//  Created by Chris Gottfredson on 3/26/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

#import "CTTManufacturerController.h"
#import "CTTManufacturer.h"

static NSString *const baseURLString = @"https://vpic.nhtsa.dot.gov/api/vehicles";
static NSString *const getManufacturerComponent = @"getallmanufacturers";
static NSString *const queryFormatName = @"format";
static NSString *const queryFormatKey = @"json";

@implementation CTTManufacturerController

+(void)fetchManufacturers: (void(^) (NSArray<CTTManufacturer *> *))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *searchURL = [baseURL URLByAppendingPathComponent:getManufacturerComponent];
    NSURLComponents *components = [NSURLComponents componentsWithURL:searchURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *formatQuery = [NSURLQueryItem queryItemWithName:queryFormatName value:queryFormatKey];
    components.queryItems = @[formatQuery];
    NSURL *finalURL = components.URL;
    NSLog(@"%@",finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@",error);
            completion(nil);
            return;
        }
        
        if (!data)
        {
            NSLog(@"%@",error);
            completion(nil);
            return;
        }
        
        NSDictionary *topLevelObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray<NSDictionary *> *secondLevelObject = topLevelObject[@"Results"];
        NSMutableArray *manufacturers = [NSMutableArray new];
        
        for (NSDictionary *mfrDictionary in secondLevelObject)
        {
            CTTManufacturer *mfr = [[CTTManufacturer alloc] initWithDictionary:mfrDictionary];
            [manufacturers addObject:mfr];
        }
        
        completion(manufacturers);
        
    }] resume];
}

@end
