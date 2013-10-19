//
//  Coordenadas.h
//  ProjetoTreino
//
//  Created by Pos Graduacao on 05/10/13.
//  Copyright (c) 2013 Pos Graduacao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Treino;

@interface Coordenadas : NSManagedObject

@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * log;
@property (nonatomic, retain) NSDate * tempo;
@property (nonatomic, retain) Treino *treino;

@end
