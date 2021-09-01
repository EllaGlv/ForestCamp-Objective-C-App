//
//  CollectionViewController.m
//  ForestCamp
//
//  Created by Alla Golovinova on 7/22/21.

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "TableViewController.h"
#import "Item+CoreDataProperties.h"
#import "AppDelegate.h"

@interface CollectionViewController ()
{
    NSArray *categoriesForDisplay;
    NSArray *categories;
}
@end

@implementation CollectionViewController

NSNumber *numberOfCheckedItems;
NSNumber *numberOfAllItems;

@synthesize managedObjectContext;

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    categoriesForDisplay = @[@"Sleeping", @"Tools", @"Fire", @"Lighting", @"Health", @"Kitchen", @"Personal Care", @"Clothes", @"For Kids", @"Others"];
    categories = @[@"sleeping", @"tools", @"fire", @"lighting", @"health", @"kitchen", @"personalCare", @"clothes", @"forKids", @"others"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.collectionView reloadData];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return categories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.layer.borderWidth=1.0f;
    cell.layer.cornerRadius = 7;
    cell.layer.borderColor=[UIColor colorWithRed: 0.937 green:0.937 blue: 0.957 alpha: 1].CGColor;
    
    cell.categoryImages.image = [UIImage imageNamed: categoriesForDisplay[indexPath.row]];
    cell.categoryLabel.text = categoriesForDisplay[indexPath.row];
    
    if ([self areAllItemsCheckedInCategory: categories[indexPath.row]] == true) {
        cell.checkedCategoryIcon.image = [UIImage imageNamed: @"categoryCheck"];
    }
    else {
        cell.checkedCategoryIcon.image = [UIImage imageNamed: @"categoryUncheck"];
    }
    
    cell.numberOfItemsLabel.text = [NSString stringWithFormat: @"%@/%@ Items", numberOfCheckedItems, numberOfAllItems];
    
    return cell;
}


#pragma mark <PrepareForSegue>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showItemsSegue" sender: categories[indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showItemsSegue"]){
        
        TableViewController *controller = (TableViewController *)segue.destinationViewController;
        controller.indexSelectedCategory = [categories indexOfObject:sender];
    }
}

#pragma mark - Check if are the items were checked in Category

-(bool)areAllItemsCheckedInCategory: (NSString *)category {
    managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSFetchRequest *fetchRequestAllFromCategory = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"category CONTAINS[c] %@", category];
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"checked == 1"];
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[predicate1, predicate2]];
    
    [fetchRequest setPredicate:predicate];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    
    [fetchRequestAllFromCategory setPredicate:predicate1];
    NSArray *fetchedObjectsFromCategory = [context executeFetchRequest:fetchRequestAllFromCategory error:nil];
    
    numberOfCheckedItems = [NSNumber numberWithInt: fetchedObjects.count];
    numberOfAllItems = [NSNumber numberWithInt: fetchedObjectsFromCategory.count];

    if (fetchedObjects.count > 0 && fetchedObjectsFromCategory.count == fetchedObjects.count)  {
        return true;
    } else {
        return false;
    }
}



#pragma mark - Refresh All Items Button

- (IBAction)refreshAllItems:(id)sender {
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Reload data"
                                 message:@"Are you sure you want to uncheck all the items?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Uncheck All"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
        
        self->managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        NSManagedObjectContext *context = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
        NSNumber *someNumber = [NSNumber numberWithInt:0];
        NSError *error = nil;
        
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
        [self.collectionView reloadData];
    }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

@end
