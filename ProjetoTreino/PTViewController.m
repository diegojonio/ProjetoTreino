//
//  PTViewController.m
//  ProjetoTreino
//
//  Created by Pos Graduacao on 05/10/13.
//  Copyright (c) 2013 Pos Graduacao. All rights reserved.
//

#import "PTViewController.h"
#import "Coordenadas.h"
#import "Esporte.h"
#import "PTAppDelegate.h"

@interface PTViewController ()

@end

@implementation PTViewController

@synthesize fetchedResultsController, managedObjectContext, treino, coordenadas;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Chegou aqui");

//    [self cadastrarTreinos];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) cadastrarTreinos
{
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"treino1" ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
    
    [xmlParser setDelegate:self];
    PTAppDelegate* deleg = (PTAppDelegate*)[UIApplication sharedApplication].delegate;
    //treino = [[Treino alloc] init];
    //treino = [NSEntityDescription entityForName:@"Treino" inManagedObjectContext:deleg.managedObjectContext];
    //treino = [NSManagedObject i]
    
    treino = [NSEntityDescription
                            insertNewObjectForEntityForName:@"Treino"
                            inManagedObjectContext:deleg.managedObjectContext];

    coordenadas = [[NSMutableArray alloc] init];
    
    [xmlParser parse];
    
    NSLog(@"%@", treino);
    NSLog(@"%@", coordenadas);
    
    
//    for (Coordenadas *coord in  coordenadas) {
//        NSLog(@"Coodenadas de Latitude: %@", coord.lat);
//    }
    
    [deleg saveContext];

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict

{
    
    PTAppDelegate* deleg = (PTAppDelegate*)[UIApplication sharedApplication].delegate;
    
    if ([elementName isEqualToString:@"metadata"]) {
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"yyyy-MM-dd'T'hh:mm:ss'Z'"];
        NSLog(@"DICIONARIO: %@", attributeDict);
        NSString *valueForTime = [attributeDict valueForKey:@"time"];
        NSLog(@"%@", valueForTime);
        NSString *date = [valueForTime substringFromIndex:10];
        NSString *time = [[date substringFromIndex:12] substringToIndex:19];
        
        NSString *dateTime = [date stringByAppendingFormat:@" %@", time];
        
        [treino setData: [df dateFromString:dateTime]];
    }
    
    
    if ([elementName isEqualToString:@"trk"]) {
        
        Esporte *esporte = [NSEntityDescription
                            insertNewObjectForEntityForName:@"Esporte"
                            inManagedObjectContext:deleg.managedObjectContext];
        
        [esporte setNome: [attributeDict valueForKey:@"type"]];
        NSLog(@"%@", [esporte nome]);
        [treino setEsporte:esporte];
    }
    
    
    if ([elementName isEqualToString:@"trkpt"]) {
        Coordenadas *coordenada = [NSEntityDescription
                                   insertNewObjectForEntityForName:@"Coordenadas"
                                   inManagedObjectContext:deleg.managedObjectContext];

        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        [nf setNumberStyle:NSNumberFormatterDecimalStyle ];
        [coordenada setLat: [nf numberFromString:[attributeDict valueForKey:@"lat"]]];
        [coordenada setLog:[nf numberFromString:[attributeDict valueForKey:@"lon"]]];
//       [coordenada setTempo:[attributeDict valueForKey:@"time"]];
        [coordenada setTreino:treino];
        [coordenadas addObject:coordenada];
        
        NSLog(@"%@", attributeDict);
    }

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
}

@end
