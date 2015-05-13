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
    NSLog(@"RECONHECEU O BOTAO SALVAR"); //OK
    if (!self.momento) {
        NSLog(@"ENTROU NO IF"); //OK
        self.momento = [[MomentoStore sharedStore]createMomentoWithTitulo:self.tfTitulo.text andDescricao: self.tvDescricao.text andIdUsuario:@"LOL"];
        NSLog(@"FIM DO IF");
    } else {
        NSLog(@"ENTROU NO ELSE");
        self.momento.titulo = self.tfTitulo.text;
        self.momento.descricao = self.tvDescricao.text;
        NSLog(@"FIM DO ELSE");
    }
    NSLog(@"DEPOIS DO ELSE");
    [[MomentoStore sharedStore] saveChanges];
    NSLog(@"DEPOIS DO SAV CHANGES");
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"APOS ANIMATED");
}

@end
