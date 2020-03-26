//
//  CTTMakeController.m
//  CarListObjC
//
//  Created by Chris Gottfredson on 3/26/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

#import "CTTMakeController.h"
#import "CTTMake.h"

static NSString *const baseURLString = @"https://vpic.nhtsa.dot.gov/api/vehicles";
static NSString *const getComponent = @"getmakeformanufacturer";
static NSString *const queryFormatName = @"format";
static NSString *const queryFormatKey = @"json";

@implementation CTTMakeController

+ (void)fetchMakes:(NSInteger)mfrID completion:(void (^)(NSArray<CTTMake *> *))completion
{
    NSString *idString = [NSString stringWithFormat:@"%ld",(long)mfrID];
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *searchURL = [[baseURL URLByAppendingPathComponent:getComponent] URLByAppendingPathComponent:idString];
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
        NSArray<NSDictionary *> *secondLevelOjbects = topLevelObject[@"Results"];
        NSMutableArray *makes = [NSMutableArray new];
        
        for (NSDictionary *makeDictionary in secondLevelOjbects)
        {
            CTTMake *make = [[CTTMake alloc] initWithDictionary:makeDictionary];
            [makes addObject:make];
        }
        
        completion(makes);
        
    }] resume];
}

@end
