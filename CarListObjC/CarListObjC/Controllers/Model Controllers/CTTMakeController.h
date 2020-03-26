//
//  CTTMakeController.h
//  CarListObjC
//
//  Created by Chris Gottfredson on 3/26/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CTTMake;

@interface CTTMakeController : NSObject

+(void)fetchMakes: (NSInteger)mfrID completion: (void(^) (NSArray<CTTMake *> *))completion;

@end

NS_ASSUME_NONNULL_END
