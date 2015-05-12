//
//  RecuroStore.m
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import "RecursoStore.h"
#import "Recurso.h"
#import "AppDelegate.h"
@interface RecursoStore ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation RecursoStore

static NSString *DATA_MODEL_ENTITY_NAME = @"Recurso";

+ (instancetype)sharedStore {
    static RecursoStore *sharedStore = nil;
    
    if (!sharedStore) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        sharedStore = [[self alloc] initPrivate];
        sharedStore.managedObjectContext = appDelegate.managedObjectContext;
        
        [sharedStore resetStoredData];
    }
    
    return sharedStore;
}

- (instancetype)initPrivate {
    self = [super init];
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[RecursoStore sharedStore]"
                                 userInfo:nil];
}

- (void)resetStoredData
{
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

-(Recurso *)createRecursoWithDescricao:(NSString *)descricaoResurso{
    Recurso *recurso = [NSEntityDescription
                                insertNewObjectForEntityForName:DATA_MODEL_ENTITY_NAME
                                inManagedObjectContext:self.managedObjectContext];
    
    recurso.id = [[[NSUUID alloc] init] UUIDString];
    // RECURSO DESCRICAO
    
    NSError *error;
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Could not save %@, %@", error, error.userInfo);
    }
    
    return recurso;
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
