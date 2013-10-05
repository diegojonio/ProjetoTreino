//
//  PTViewController.m
//  ProjetoTreino
//
//  Created by Pos Graduacao on 05/10/13.
//  Copyright (c) 2013 Pos Graduacao. All rights reserved.
//

#import "PTViewController.h"

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
    
    [xmlParser parse];

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict

{
    if ([elementName isEqualToString:@"trkpt"]) {
        NSLog(@"lat = %@", [attributeDict valueForKey:@"lat"]);
        NSLog(@"lon = %@", [attributeDict valueForKey:@"lon"]);
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
}

@end
