//
//  MainViewController.m
//  ThatPlace
//
//  Created by Abner Josue Viana Matos on 13/05/15.
//  Copyright (c) 2015 BEPiD FUCAPI. All rights reserved.
//

#import "MainViewController.h"
#import "CustomAnnotation.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize mainMapkit;
@synthesize locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    if ([locationManager respondsToSelector:@selector (requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    
    [locationManager startUpdatingLocation];
    
    mainMapkit.showsUserLocation = YES;
    mainMapkit.delegate = self;
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.5; //user needs to press for half a second.
    [mainMapkit addGestureRecognizer:lpgr];
    
}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    CGPoint touchPoint = [gestureRecognizer locationInView:mainMapkit];
    
    CLLocationCoordinate2D touchMapCoordinate = [mainMapkit convertPoint:touchPoint toCoordinateFromView:mainMapkit];
    
    CustomAnnotation *point = [[CustomAnnotation alloc] init];
    
    point.coordinate = touchMapCoordinate;
    point.title = @"New";
    [mainMapkit addAnnotation:point];
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MKUserLocation class]])
//        return nil;
//
//    if ([annotation isKindOfClass:[CustomAnnotation class]])
//    {
//        static NSString* CustomAnnotationIdentifier = @"CustomAnnotationIdentifier";
//        MKPinAnnotationView* pinView = (MKPinAnnotationView *)
//        [mapView dequeueReusableAnnotationViewWithIdentifier:CustomAnnotationIdentifier];
//
//        MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
//                                                                   initWithAnnotation:annotation reuseIdentifier:CustomAnnotationIdentifier] autorelease];
//        MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
//        annotationView.canShowCallout = YES;
//        annotationView.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
//
//        return annotationView;}
//}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"segueCadastroMomento" sender:view];
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        MKAnnotationView *pinView = (MKAnnotationView *) [theMapView dequeueReusableAnnotationViewWithIdentifier:@"pinView"];
        if (!pinView) {
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pinview"];
            pinView.image = [UIImage imageNamed:@"current.png"];
            pinView.canShowCallout = YES;
            pinView.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    if ([annotation isKindOfClass:[CustomAnnotation class]])
    {
        MKAnnotationView *pinView = (MKAnnotationView *) [theMapView dequeueReusableAnnotationViewWithIdentifier:@"pinView"];
        if (!pinView) {
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pinview"];
            pinView.image = [UIImage imageNamed:@"icon.png"];
            pinView.canShowCallout = YES;
            pinView.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:
(NSArray *)locations
{
    NSLog(@"location info object=%@", [locations lastObject]);
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D myLocation = [userLocation coordinate];
    
    MKCoordinateRegion zoomRegion = MKCoordinateRegionMakeWithDistance(myLocation, 1000, 1000);
    [mainMapkit setRegion:zoomRegion animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end