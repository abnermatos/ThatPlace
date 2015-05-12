//
//  UsuarioStore.m
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import "UsuarioStore.h"
#import "AppDelegate.h"
#import "Usuario.h"

@interface UsuarioStore ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation UsuarioStore

static NSString *DATA_MODEL_ENTITY_NAME = @"Usuario";

+ (instancetype)sharedStore {
    static UsuarioStore *sharedStore = nil;
    
    if (!sharedStore) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        sharedStore = [[self alloc] initPrivate];
        sharedStore.managedObjectContext = appDelegate.managedObjectContext;
    }
    
    return sharedStore;
}

- (instancetype)initPrivate {
    self = [super init];
    return self;
}
- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[UsuarioStore sharedStore]"
                                 userInfo:nil];
}
- (NSFetchedResultsController *)fetchedResultsController{
    if (!_fetchedResultsController) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:DATA_MODEL_ENTITY_NAME inManagedObjectContext:self.managedObjectContext];
        
        [fetchRequest setEntity:entity];
        
        // Set the batch size to a suitable number.
        [fetchRequest setFetchBatchSize:20];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        // _fetchedResultsController.delegate = self;
        
        NSError *error = nil;
        if (![_fetchedResultsController performFetch:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
    return _fetchedResultsController;
}
- (Usuario *)createUsuarioWithNome:(NSString *)nome andSenha:(NSString *)senha{
    Usuario *usuario = [NSEntityDescription
                                insertNewObjectForEntityForName:DATA_MODEL_ENTITY_NAME
                                inManagedObjectContext:self.managedObjectContext];
    
    usuario.id = [[[NSUUID alloc] init] UUIDString];
    usuario.nome = nome;
    usuario.senha = senha;
    
    NSError *error;
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Could not save %@, %@", error, error.userInfo);
    }
    
    return usuario;
}
- (void)removeSenhaUsuario:(Usuario *)usuario{
    usuario.senha = NULL;
}

@end
