//
//  CustomAnnotation.h
//  MapKit
//
//  Created by Abner Josue Viana Matos on 12/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/Mapkit.h>

@interface CustomAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
