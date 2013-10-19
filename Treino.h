//
//  Treino.h
//  ProjetoTreino
//
//  Created by Pos Graduacao on 05/10/13.
//  Copyright (c) 2013 Pos Graduacao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Esporte;

@interface Treino : NSManagedObject

@property (nonatomic, retain) NSDate * data;
@property (nonatomic, retain) NSNumber * duracao;
@property (nonatomic, retain) Esporte *esporte;

@end
