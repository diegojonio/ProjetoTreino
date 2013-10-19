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
#import "HistTreinoCell.h"

@interface PTViewController ()

@end

@implementation PTViewController

@synthesize fetchedResultsController, managedObjectContext, treinos, treino, coordenadas, tag, currentStringValue;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    histTreino.delegate = self;
    histTreino.dataSource = self;
    
    [self consultarTreinos];

//    [self cadastrarTreinos];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) consultarTreinos
{
    PTAppDelegate *deleg = (PTAppDelegate*) [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSError *error;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Treino"
                                              inManagedObjectContext:deleg.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedOject = [deleg.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    treinos = [[NSMutableArray alloc ] initWithArray: fetchedOject];

}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [treinos count];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SecondViewController *secondView = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil indice:indexPath.row];
//    
//    [[self navigationController] pushViewController:secondView animated:YES];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *uniqueIdentifier = @"HistTreinoCell";
    HistTreinoCell *cell = nil;
    
    cell = (HistTreinoCell*) [histTreino dequeueReusableCellWithIdentifier:uniqueIdentifier];
    
    if (!cell)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"HistTreinoCell" owner:nil options:nil];
        
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (HistTreinoCell *) currentObject;
                break;
            }
        }
    }
    
    cell = (HistTreinoCell *) cell;
    
    cell.fotoExercicio.image = [UIImage imageNamed:@"ic_launcher.png"];
    
    /*NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
     NSError *error;
     NSEntityDescription *entity = [NSEntityDescription entityForName:@"Contato"
     inManagedObjectContext:deleg.managedObjectContext];
     [fetchRequest setEntity:entity];
     
     NSArray *fetchedOject = [deleg.managedObjectContext executeFetchRequest:fetchRequest error:&error];*/
    Treino *t = [treinos objectAtIndex:indexPath.row];
    cell.exercicio.text = t.esporte.nome;
    return cell;
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

//    NSLog(@"%@", treino);
//    NSLog(@"%@", coordenadas);
    
    
//    for (Coordenadas *coord in  coordenadas) {
//        NSLog(@"Coodenadas de Latitude: %@", coord.lat);
//    }
    
//    [deleg saveContext];

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
        return;
    }
    
    
    if ([elementName isEqualToString:@"Type"]) {
        tag = @"Esporte";
        return;
        
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
        
//        NSLog(@"%@", attributeDict);
        return;
    }

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!currentStringValue) {
        // currentStringValue is an NSMutableString instance variable
        currentStringValue = [[NSMutableString alloc] initWithCapacity:50];
    }
    [currentStringValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    PTAppDelegate* deleg = (PTAppDelegate*)[UIApplication sharedApplication].delegate;
    
    if([tag isEqualToString:@"Esporte"]) {
        NSLog(@"%@", currentStringValue);
        
        Esporte *esporte = [NSEntityDescription
                                   insertNewObjectForEntityForName:@"Coordenadas"
                                   inManagedObjectContext:deleg.managedObjectContext];
        
        [esporte setNome:currentStringValue];
        [treino setEsporte:esporte];
    }
    
    currentStringValue = nil;
}

@end
