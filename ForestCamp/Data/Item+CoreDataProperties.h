//
//  Item+CoreDataProperties.h
//  ForestCamp
//
//  Created by Alla Golovinova on 8/6/21.
//
//

#import "Item+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface Item (CoreDataProperties)

+ (NSFetchRequest<Item *> *)fetchRequest;

@property (nonatomic) BOOL checked;
@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
