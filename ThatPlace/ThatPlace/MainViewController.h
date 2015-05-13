//
//  MainViewController.h
//  ThatPlace
//
//  Created by Abner Josue Viana Matos on 13/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>
#import <CoreLocation/CoreLocation.h>

@interface MainViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mainMapkit;
@property (strong, nonatomic) CLLocationManager *locationManager;


@end
