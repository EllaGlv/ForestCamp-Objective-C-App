//
//  TableViewController.m
//  ForestCamp
//
//  Created by Alla Golovinova on 7/22/21.
//

#import "TableViewController.h"
#import "Item+CoreDataProperties.h"
#import "AppDelegate.h"


@interface TableViewController ()

@end

@implementation TableViewController

@synthesize fetchedResultsController, managedObjectContext;

NSArray* categoriesForDisplay;
NSArray *categories;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellSelected = [NSMutableArray array];
    self.cellAll = [NSMutableArray array];
    
    categoriesForDisplay = @[@"Sleeping", @"Tools", @"Fire", @"Lighting", @"Health", @"Kitchen", @"Personal Care", @"Clothes", @"For Kids", @"Others"];
    categories = @[@"sleeping", @"tools", @"fire", @"lighting", @"health", @"kitchen", @"personalCare", @"clothes", @"forKids", @"others"];
    
    self.title = categoriesForDisplay[_indexSelectedCategory];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self getCheckedItems];
}

#pragma mark - Get Checked Items from CoreData

-(void)getCheckedItems {
    
    managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequestForChecked = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    NSFetchRequest *fetchRequestForAll = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    [fetchRequestForAll setReturnsObjectsAsFaults:NO];
    [fetchRequestForChecked setReturnsObjectsAsFaults:NO];
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"category == %@", categories[_indexSelectedCategory]];
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"checked == 1"];
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[predicate1, predicate2]];
    [fetchRequestForChecked setPredicate:predicate];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequestForChecked error:nil];

    for (Item *item in fetchedObjects) {
        [self.cellSelected addObject: item.name];
    }
    
    [fetchRequestForAll setPredicate:predicate1];
    NSArray *fetchedObjectsAll = [context executeFetchRequest:fetchRequestForAll error:nil];
    for (Item *item in fetchedObjectsAll) {
        [self.cellAll addObject: item.name];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.cellAll.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
    NSLog(@"checkedItems in cellForRowAtIndexPath =%@", self.cellSelected);
    cell.textLabel.text = self.cellAll[indexPath.row];
    
    if ([self.cellSelected containsObject:self.cellAll[indexPath.row]])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSManagedObjectContext *context = [self managedObjectContext];
    NSNumber *someNumber;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    
    [fetchRequest setReturnsObjectsAsFaults:NO];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name = %@", cell.textLabel.text]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    
    if ([self.cellSelected containsObject:self.cellAll[indexPath.row]])
    {
        [self.cellSelected removeObject:self.cellAll[indexPath.row]];
        someNumber = [NSNumber numberWithInt:0];
    }
    else
    {
        [self.cellSelected addObject:self.cellAll[indexPath.row]];
        someNumber = [NSNumber numberWithInt:1];
    }
    if (fetchedObjects != nil)  {
        for (Item *item in fetchedObjects) {
            [item setValue: someNumber forKey:@"checked"];
        }
        if ([[self managedObjectContext] save:&error] == NO) {
            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        }
    }
    else {
        NSLog(@"fetchResults == nil");
    }
    [tableView reloadData];
}

@end
