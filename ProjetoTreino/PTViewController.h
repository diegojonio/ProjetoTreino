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

@interface PTViewController : UIViewController <NSFetchedResultsControllerDelegate, NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate> {
    
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *treinos;
    Treino *treino;
    NSMutableArray *coordenadas;
    NSString *tag;
    NSMutableString *currentStringValue;
    
    IBOutlet UITableView *histTreino;
    
    /* (...Existing Application Code...) */
}

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong) NSMutableArray *treinos;
@property (nonatomic, strong) Treino *treino;
@property (nonatomic, strong) NSMutableArray *coordenadas;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSMutableString *currentStringValue;


@end
