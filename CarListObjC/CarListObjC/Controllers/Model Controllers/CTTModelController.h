//
//  CTTModelController.h
//  CarListObjC
//
//  Created by Chris Gottfredson on 3/26/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CTTModel;

@interface CTTModelController : NSObject

+(void)fetchModels: (NSInteger)makeID completion: (void(^)(NSArray<CTTModel *> *))completion;

@end

NS_ASSUME_NONNULL_END
