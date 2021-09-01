//
//  Item+CoreDataProperties.m
//  ForestCamp
//
//  Created by Alla Golovinova on 8/6/21.
//
//

#import "Item+CoreDataProperties.h"

@implementation Item (CoreDataProperties)

+ (NSFetchRequest<Item *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Item"];
}

@dynamic checked;
@dynamic name;

@end
