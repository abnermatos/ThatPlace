//
//  RecuroStore.h
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recurso.h"
@import CoreData;

@interface RecursoStore : NSObject

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

+ (instancetype)sharedStore;

- (Recurso*)createRecursoWithDescricao:(NSString *)descricaoResurso;
- (BOOL)saveChanges;

@end
