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

@interface FeedTableViewController () //<UITableViewDataSource, UITableViewDelegate,NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableViewFeed;
@property (weak, nonatomic) NSArray *arrayMomentos;
@end

@implementation FeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrayMomentos = [[MomentoStore sharedStore] getAllMomento];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Adicionado
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[MomentoStore sharedStore] loadAllMomento];
    _arrayMomentos = [[MomentoStore sharedStore] getAllMomento];
    
    for(Momento *mom in self.arrayMomentos){
        NSLog(@"%@", mom.titulo);
    }
    
    [self.tableViewFeed reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[MomentoStore sharedStore]getAllMomento]count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell1";
    
    FeedTableViewCell1 *cell = (FeedTableViewCell1 *)[self.tableViewFeed
                                                dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[FeedTableViewCell1 alloc] initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Momento *momento = [[[MomentoStore sharedStore]getAllMomento] objectAtIndex:indexPath.row];
    
    cell.lbTitulo.text = momento.titulo;
    NSLog(@"Descricao: %@",momento.descricao);
    
    return cell;
}

@end
