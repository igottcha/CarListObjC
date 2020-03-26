//
//  CTTManufacturerController.h
//  CarListObjC
//
//  Created by Chris Gottfredson on 3/26/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CTTManufacturer;

@interface CTTManufacturerController : NSObject

+(void)fetchManufacturers: (void(^) (NSArray<CTTManufacturer *> *))completion;

@end

NS_ASSUME_NONNULL_END
