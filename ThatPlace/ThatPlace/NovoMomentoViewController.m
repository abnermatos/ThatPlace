//
//  NovoMomentoViewController.m
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import "NovoMomentoViewController.h"
#import "MomentoStore.h"

@interface NovoMomentoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfTitulo;
@property (weak, nonatomic) IBOutlet UITextView *tvDescricao;

@end

@implementation NovoMomentoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)btMaisFoto:(id)sender {
    //Tirar fotografia
}
- (IBAction)btAudio:(id)sender {
    //Gravar audio
}

- (IBAction)btSalvar:(id)sender {
    [[MomentoStore sharedStore]createMomentoWithTitulo:self.tfTitulo.text andDescricao:self.tvDescricao.text andIdUsuario:NULL];
    [self.navigationController popViewControllerAnimated:YES];
    //[[MomentoStore sharedStore] getAllMomento];
}

@end
