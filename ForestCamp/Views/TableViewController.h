//
//  TableViewController.h
//  ForestCamp
//
//  Created by Alla Golovinova on 7/22/21.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>
{
 NSFetchedResultsController *fetchedResultsController;
 NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSIndexPath* checkedIndexPath;
@property (nonatomic, retain) NSMutableArray* cellSelected;
@property (nonatomic, retain) NSMutableArray* cellAll;
@property (nonatomic, assign) NSInteger indexSelectedCategory;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (void)getCheckedItems;

@end

NS_ASSUME_NONNULL_END
