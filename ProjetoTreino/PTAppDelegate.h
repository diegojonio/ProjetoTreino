//
//  PTAppDelegate.h
//  ProjetoTreino
//
//  Created by Pos Graduacao on 05/10/13.
//  Copyright (c) 2013 Pos Graduacao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTViewController;

@interface PTAppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PTViewController *viewController;

@end
