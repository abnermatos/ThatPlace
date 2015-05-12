//
//  FeedTableViewController.m
//  ThatPlace
//
//  Created by Matheus Ribeiro on 11/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import "FeedTableViewController.h"

@interface FeedTableViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation FeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView dequeueReusableCellWithIdentifier:@"Cell1"];
}


@end
