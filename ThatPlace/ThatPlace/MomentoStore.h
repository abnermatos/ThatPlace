//
//  MomentoStore.h
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Momento.h"
@import CoreData;

@interface MomentoStore : NSObject

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

+ (instancetype)sharedStore;

- (Momento*)createMomentoWithTitulo:(NSString *)titulo andHumor:(NSString *)humor andDescricao:(NSString*)descricao andIdUsuario:(NSString*)idUsuario;
- (BOOL)saveChanges;
-(void)removeMomento:(Momento*)momento;
@end
