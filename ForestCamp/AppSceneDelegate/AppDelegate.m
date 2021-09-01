//
//  AppDelegate.m
//  ForestCamp
//
//  Created by Alla Golovinova on 7/22/21.
//

#import "AppDelegate.h"
#import "TableViewController.h"
#import "CampCategory.h"

@interface AppDelegate ()
{
   NSArray* predefinedCategoties;
    NSArray *sleeping;
    NSArray *tools;
    NSArray *fire;
    NSArray *lighting;
    NSArray *health;
    NSArray *kitchen;
    NSArray *personalCare;
    NSArray *clothes;
    NSArray *forKids;
    NSArray *others;
    NSArray *items;
}

@end

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    static NSString* const hasRunAppOnceKey = @"hasRunAppOnceKey";
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:hasRunAppOnceKey] == NO)
    {
       NSLog(@"First time app launched");
       NSLog(@"Current user’s home directory is %@", NSHomeDirectory());
       
       //Ones App lounched we will save all predefined data in CoreData
        
        NSArray* categories = @[
            [[CampCategory alloc]
             initWithName:@"sleeping"
             label:@"Sleeping"
             items:@[
                 @"Tent",
                 @"Tarpaulin on the ground",
                 @"Sleeping bags",
                 @"Pillows",
                 @"Mattress or foam",
                 @"Air pump",
                 @"Bedclothes",
                 @"Plaid"
             ]],
            [[CampCategory alloc]
             initWithName:@"tools"
             label:@"Tools"
             items:@[
                 @"Scotch tape",
                 @"Rope",
                 @"Broom and scoop",
                 @"Elastic cords",
                 @"Axe",
                 @"Wooden/plastic hammer",
                 @"Multitool",
                 @"Travel sewing kit",
                 @"Clothespins"
             ]],
            [[CampCategory alloc]
             initWithName:@"fire"
             label:@"Fire"
             items:@[
                 @"Firewood",
                 @"Matches / lighter",
                 @"Fire lighting kit",
             ]],
            [[CampCategory alloc]
             initWithName:@"lighting"
             label:@"Lighting"
             items:@[
                 @"Lamp / large lantern",
                 @"Small flashlights and / or forehead flashlights",
                 @"Batteries",
             ]],
            [[CampCategory alloc]
             initWithName:@"health"
             label:@"Health"
             items:@[
                 @"Hiking first aid kit",
                 @"Pain reliever",
                 @"Tylenol/Advil",
                 @"Permanent medications",
                 @"Ointment for bites",
                 @"Medical card",
             ]],
            [[CampCategory alloc]
             initWithName:@"kitchen"
             label:@"Kitchen"
             items:@[
                 @"Tent with mosquito net",
                 @"Folding chairs",
                 @"Stove or gas burner",
                 @"Gas cylinder",
                 @"Water container",
                 @"Bottled drinking water",
                 @"Refrigerator bag for food",
                 @"Ice or cooling element",
                 @"Dish washing container",
                 @"Biodegradable soap",
                 @"Dishwashing sponge",
                 @"Paper towels",
                 @"Tablecloth",
                 @"Garbage bags",
                 @"Foil",
                 @"Zipper-lock bags and boxes for food",
                 @"Pot and pan",
                 @"Bowl",
                 @"Kitchen board",
                 @"Spatula for frying pan",
                 @"Salad spoons",
                 @"Knives",
                 @"Canned food opener",
                 @"Brazier or grill rack on fire",
                 @"Fire toaster",
                 @"Kettle, coffee maker",
                 @"Set: spoons (canteens, tea rooms), forks and knives",
                 @"Plates",
                 @"Glasses / cups"
             ]],
            [[CampCategory alloc]
             initWithName:@"personalCare"
             label:@"Personal Care"
             items:@[
                 @"Sunscreen with SPF",
                 @"Insect spray",
                 @"Towels",
                 @"Soap",
                 @"Shampoo",
                 @"Toothpaste and brush",
                 @"Deodorant",
                 @"Shaver",
                 @"Hairbrush",
                 @"Hand sanitizer",
                 @"Wet wipes",
                 @"Small mirror"
             ]],
            [[CampCategory alloc]
             initWithName:@"clothes"
             label:@"Clothes"
             items:@[
                 @"Closed shoes",
                 @"Socks",
                 @"Sandals / flip-flops",
                 @"Pants",
                 @"Shorts",
                 @"Underwear",
                 @"Pajamas",
                 @"Vest / T-shirts",
                 @"Hoodies",
                 @"Jacket / coat for rain",
                 @"Swimsuit",
                 @"Cap",
                 @"Sunglasses"
             ]],
            [[CampCategory alloc]
             initWithName:@"forKids"
             label:@"For Kids"
             items:@[
                 @"Favorite toy",
                 @"Favorite blanket or pillow",
                 @"Sports equipment(ball, etc.)",
                 @"Board games",
                 @"Books"
             ]],
            [[CampCategory alloc]
             initWithName:@"others"
             label:@"Clothes"
             items:@[
                 @"Camera",
                 @"Backpack",
                 @"Shoes for water",
                 @"Life jackets",
                 @"Beach sports inventory",
                 @"Bicycles, helmets",
                 @"Beach umbrella",
                 @"Fishing tackle",
                 @"Phone chargers"
             ]],
        ];
        
        NSManagedObjectContext *context = [self managedObjectContext];
        NSManagedObject *newItem;
        for (CampCategory* category in categories){
            for (NSString *i in category.items) {
                newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext: context];
                [newItem setValue: i forKey:@"name"];
                [newItem setValue: false forKey:@"checked"];
                [newItem setValue: category.name forKey:@"category"];
                
                NSLog(@"i=%@", i);
                NSError *error = nil;
                if ([[self managedObjectContext] save:&error] == NO) {
                    NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
                }
            }
        }
        
        NSLog(@"context in addItemsObject=%@", context);
        [defaults setBool:YES forKey:hasRunAppOnceKey];
    } else {
        NSLog(@"N-th time app launched");
        NSLog(@"Current user’s home directory is %@", NSHomeDirectory());
    }
    return YES;
}

#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

#pragma mark - Core Data Saving support

- (void)saveContext{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSManagedObjectContext *)managedObjectContext{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ForestCamp" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }

    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ForestCamp.sqlite"];

    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options: @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES} error:&error]) {

        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

       return _persistentStoreCoordinator;
   }

    #pragma mark - Application's Documents directory

   // Returns the URL to the application's Documents directory.
   - (NSURL *)applicationDocumentsDirectory{
       return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
   }

@end
