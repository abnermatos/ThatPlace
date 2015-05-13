//
//  FeedTableViewController.m
//  ThatPlace
//
//  Created by Matheus Ribeiro on 11/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import "FeedTableViewController.h"
#import "Momento.h"
#import "MomentoStore.h"
#import "FeedTableViewCell1.h"

@interface FeedTableViewController () <UITableViewDataSource, UITableViewDelegate,NSFetchedResultsControllerDelegate>

@property (nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

@end

@implementation FeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[MomentoStore sharedStore] fetchedResultsController].delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSFetchedResultsController *)fetchedResultsController {
    NSLog(@"LOLOLOLOL 1");
    return [[MomentoStore sharedStore] fetchedResultsController];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.fetchedResultsController sections][section] numberOfObjects];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"LOLOLOLOL 2");
    FeedTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1"];
    
    Momento *momento = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSLog(@"LOLLLOLOL 3");
    cell.lbTitulo.text = momento.titulo;
    //FALTA DATA E FOTO
    
    return cell;
}


@end
