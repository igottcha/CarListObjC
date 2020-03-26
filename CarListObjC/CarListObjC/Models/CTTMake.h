//
//  CTTMake.h
//  CarListObjC
//
//  Created by Chris Gottfredson on 3/26/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTTMake : NSObject

@property (nonatomic) NSInteger makeID;
@property (nonatomic, copy) NSString *name;

-(instancetype) initWithName: (NSString *)name makeID: (NSInteger)makeID;

@end

@interface CTTMake (JSONConvertible)

-(instancetype) initWithDictionary: (NSDictionary *)dictionary;

@end


NS_ASSUME_NONNULL_END
