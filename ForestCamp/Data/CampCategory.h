//
//  CampCategory.h
//  ForestCamp
//
//  Created by Alla Golovinova on 8/14/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CampCategory : NSObject

@property (readonly) NSString *name;
@property (readonly) NSString *label;
@property (readonly) NSArray *items;

- (instancetype)initWithName:(NSString *)name label:(NSString*) label items:(NSArray*)items;

@end

NS_ASSUME_NONNULL_END

