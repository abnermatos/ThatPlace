//
//  MomentoStore.m
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import "MomentoStore.h"
#import "AppDelegate.h"
#import "Momento.h"

@interface MomentoStore ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation MomentoStore

static NSString *DATA_MODEL_ENTITY_NAME = @"Momento";

+ (instancetype)sharedStore {
    static MomentoStore *sharedStore = nil;
    
    if (!sharedStore) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        sharedStore = [[self alloc] initPrivate];
        sharedStore.managedObjectContext = [appDelegate managedObjectContext];
        
        [sharedStore resetStoredData];
    }
    NSLog(@"OK ATÉ AQUI"); //OK
    return sharedStore;
}

- (instancetype)initPrivate {
    self = [super init];
    return self;
}
-(Momento *)createMomentoWithTitulo:(NSString *)titulo andDescricao:(NSString *)descricao andIdUsuario:(NSString *)idUsuario{
    
    NSLog(@"LOLOLOLOLOL %@",self.managedObjectContext);
    Momento *momento = [NSEntityDescription
                                insertNewObjectForEntityForName:DATA_MODEL_ENTITY_NAME
                                inManagedObjectContext:self.managedObjectContext];
    momento.id = [[[NSUUID alloc] init] UUIDString];
    momento.titulo = titulo;
    momento.descricao = descricao;
    momento.idUsuairo = idUsuario;
    NSLog(@"Andador"); //É LOGO ANTES DESSA LINHA
    
    NSError *error;
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Could not save %@, %@", error, error.userInfo);
    }
    NSLog(@"O CREATE ESTÁ OK");
    return momento;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[MomentoStore sharedStore]"
                                 userInfo:nil];
}
- (void)resetStoredData{
    // Delete all objects
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:DATA_MODEL_ENTITY_NAME];
    NSError *error;
    NSArray *objects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Error fetching objects: %@", error.userInfo);
    }
    
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    for (NSManagedObject *object in objects) {
        [self.managedObjectContext deleteObject:object];
    }
    
}
- (void)removeMomento:(Momento *)momento{
    [self.managedObjectContext deleteObject:momento];
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
- (BOOL)saveChanges {
    NSError *error;
    
    if ([self.managedObjectContext hasChanges]) {
        BOOL successful = [self.managedObjectContext save:&error];
        
        if (!successful) {
            NSLog(@"Error saving: %@", [error localizedDescription]);
        }
        
        return successful;
    }
    
    return YES;
}

@end
