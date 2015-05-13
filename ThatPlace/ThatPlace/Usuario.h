//
//  Usuario.h
//  ThatPlace
//
//  Created by Matheus Ribeiro on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@import UIKit;
@interface Usuario : NSManagedObject

@property (nonatomic, retain) NSString* id;
@property (nonatomic, retain) NSString* nome;
@property (nonatomic, retain) NSString* senha;

@end
