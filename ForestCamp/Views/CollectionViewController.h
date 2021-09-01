//
//  CollectionViewController.h
//  ForestCamp
//
//  Created by Alla Golovinova on 7/22/21.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIAlertViewDelegate>

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

NS_ASSUME_NONNULL_END
