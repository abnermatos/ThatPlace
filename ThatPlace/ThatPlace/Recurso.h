//
//  Recurso.h
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@import UIKit;
@interface Recurso : NSManagedObject

@property (nonatomic, retain) NSString* id;
@property (nonatomic, retain) NSString* idMomento;
@property (nonatomic, retain) NSString* descricaoRecurso;

@end
