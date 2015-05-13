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
@property (nonatomic) NSMutableArray *privateItems;

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
    return sharedStore;
}

- (instancetype)initPrivate {
    self = [super init];
    return self;
}
-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    if(!self.managedObjectContext){
        _managedObjectContext = managedObjectContext;
        [self loadAllMomento];
    }
}
-(void)loadAllMomento{
    if(!self.privateItems){                                                //Nome da ENTIDADE, não da classe
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Momento"];
        NSError *error;
        NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        if(!result){
            [NSException raise:@"Fetch failed" format:@"Reason: %@",[error localizedDescription]];
        }
        self.privateItems = [NSMutableArray arrayWithArray:result];
    }
}
-(NSArray*)getAllMomento{
    return [self.privateItems copy];
}
-(Momento *)createMomentoWithTitulo:(NSString *)titulo andDescricao:(NSString *)descricao andIdUsuario:(NSString *)idUsuario{
    
//    Momento *momento = [NSEntityDescription
//                                insertNewObjectForEntityForName:DATA_MODEL_ENTITY_NAME
//                                inManagedObjectContext:self.managedObjectContext];
    Momento *momento = [NSEntityDescription insertNewObjectForEntityForName:@"Momento" inManagedObjectContext:self.managedObjectContext];
    
    momento.id = [[[NSUUID alloc] init] UUIDString];
    momento.titulo = titulo;
    momento.descricao = descricao;
    momento.idUsuario = idUsuario;
    
    NSError *error;
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Could not save %@, %@", error, error.userInfo);
    }
    
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
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"titulo" ascending:YES];
        NSArray *sortDescriptors = @[sortDescriptor];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
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
