//
//  Momento.h
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@import UIKit;
@interface Momento : NSManagedObject

@property (nonatomic, retain) NSString* id;
@property (nonatomic, retain) NSString* titulo;
@property (nonatomic, retain) NSString* descricao;
@property (nonatomic, retain) NSString* idUsuairo;

@end
