//
//  PTViewController.m
//  ProjetoTreino
//
//  Created by Pos Graduacao on 05/10/13.
//  Copyright (c) 2013 Pos Graduacao. All rights reserved.
//

#import "PTViewController.h"
#import "Coordenadas.h"

@interface PTViewController ()

@end

@implementation PTViewController

@synthesize fetchedResultsController, managedObjectContext;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Chegou aqui");

    [self cadastrarTreinos];
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
    
    treino = [[Treino alloc] init];
    
    
    [xmlParser parse];

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict

{
    NSMutableArray *coordenadas = [[NSMutableArray alloc] init] ;
    
    Coordenadas *coordenada = [[Coordenadas alloc] init];
    
    if ([elementName isEqualToString:@"trkpt"]) {
        [coordenada setLat: [attributeDict valueForKey:@"lat"]];
        [coordenada setLog:[attributeDict valueForKey:@"lon"]];
        [coordenada setTreino:treino];
        
        NSLog(@"%@", attributeDict);
    }
    
    [coordenadas addObject:coordenada];
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
}

@end
