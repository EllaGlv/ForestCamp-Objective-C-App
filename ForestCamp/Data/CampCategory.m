//
//  CampCategory.m
//  ForestCamp
//
//  Created by Alla Golovinova on 8/14/21.
//

#import "CampCategory.h"

@implementation CampCategory

// ref: https://medium.com/@MarkEdwardMurray/objective-c-class-initializers-a-k-a-constructors-94dcd6d2ffd7

- (instancetype)initWithName:(NSString *)name label:(NSString*) label items:(NSArray*)items {
    self = [super init];
    if (self) {
        _name = name;
        _label = label;
        _items = items;
    }
    return self;
}

@end
