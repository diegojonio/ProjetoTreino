//
//  PTViewController.h
//  ProjetoTreino
//
//  Created by Pos Graduacao on 05/10/13.
//  Copyright (c) 2013 Pos Graduacao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

#import "Treino.h"

@interface PTViewController : UIViewController <NSFetchedResultsControllerDelegate, NSXMLParserDelegate> {
    
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    Treino *treino;
    
    /* (...Existing Application Code...) */
}

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Treino *treino;


@end
