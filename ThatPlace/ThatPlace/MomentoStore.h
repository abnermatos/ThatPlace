//
//  MomentoStore.h
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;
@interface MomentoStore : NSObject

+ (instancetype)sharedStore;

- (void)createMomentoWithTitulo:(NSString *)titulo andDescricao:(NSString*)descricao andIdUsuario:(NSString*)idUsuario;
-(void)loadAllMomento;
-(NSArray*)getAllMomento;
-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
@end;