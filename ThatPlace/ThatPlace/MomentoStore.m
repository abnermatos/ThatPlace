//
//  MomentoStore.m
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import "MomentoStore.h"
#import "Momento.h"
#import "AppDelegate.h"

@import CoreData;

@interface MomentoStore ()

@property (nonatomic) NSMutableArray *privateItems;
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation MomentoStore

+(instancetype)sharedStore{
    static MomentoStore *sharedStore = nil;
    
    if(!sharedStore){
//        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        sharedStore = [[self alloc]initPrivate];
//        [[MomentoStore sharedStore] setManagedObjectContext:appDelegate.managedObjectContext];
    }
    return sharedStore;
}
-(instancetype)initPrivate{
    self = [super init];
    return self;
}
//Excessão caso tente criar objeto na marra
-(instancetype)init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[MomentoStore]" userInfo:nil];
    return nil;
}
-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    if(!self.managedObjectContext){
        _managedObjectContext = managedObjectContext;
        [self loadAllMomento];
    }
}
-(void)createMomentoWithTitulo:(NSString *)titulo andDescricao:(NSString *)descricao andIdUsuario:(NSString *)idUsuario{
    
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
@end
