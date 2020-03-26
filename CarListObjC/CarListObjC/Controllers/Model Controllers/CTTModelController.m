//
//  CTTModelController.m
//  CarListObjC
//
//  Created by Chris Gottfredson on 3/26/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

#import "CTTModelController.h"
#import "CTTModel.h"

static NSString *const baseURLString = @"https://vpic.nhtsa.dot.gov/api/vehicles";
static NSString *const getComponent = @"getmodelsformakeid";
static NSString *const queryFormatName = @"format";
static NSString *const queryFormatKey = @"json";

@implementation CTTModelController

+ (void)fetchModels:(NSInteger)makeID completion:(void (^)(NSArray<CTTModel *> *))completion
{
    NSString *idString = [NSString stringWithFormat:@"%ld",(long)makeID];
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
        NSArray<NSDictionary *> *secondLevelObject = topLevelObject[@"Results"];
        NSMutableArray *models = [NSMutableArray new];
        
        for (NSDictionary *modelDictionary in secondLevelObject)
        {
            CTTModel *model = [[CTTModel alloc] initWithDictionary:modelDictionary];
            [models addObject:model];
        }
        
        completion(models);
        
    }] resume];
}

@end
