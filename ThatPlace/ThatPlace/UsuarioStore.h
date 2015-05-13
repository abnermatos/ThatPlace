//
//  UsuarioStore.h
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//
@import CoreData;
#import "Usuario.h"
#import <Foundation/Foundation.h>

@interface UsuarioStore : NSObject
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

+ (instancetype)sharedStore;

- (Usuario *)createUsuarioWithNome:(NSString *)nome andSenha:(NSString *)senha;
- (void)removeSenhaUsuario:(Usuario *)usuario;
@end
