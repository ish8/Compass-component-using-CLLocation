//
//  ViewController.m
//  compassProcess
//
//  Created by Ish on 4/3/14.
//  Copyright (c) 2014 Ishani. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CLHeading.h>

#import "math.h"

#define toRad(X) (X*M_PI/180.0)
#define toDeg(X) (X*180.0/M_PI)
#define radius_timer 70
#define diffInHeight 8
#define stepValue 1
#define intialValue 0.0
#define animationDuration 0.3
@interface ViewController ()

@end

@implementation ViewController
@synthesize progressTimerIndicator;
@synthesize compassInsideImage;
@synthesize progressCurrentvalue;
@synthesize progressFinalValue;
@synthesize directionAngleValue;
@synthesize totalPoints;
//@synthesize mapViewController;
@synthesize timeLeftLabel,timeLeftValue,rotationLabel,rotationValue,pointsLeftLabel,PointsLeftValue;
@synthesize emptyStatusBarImage;
@synthesize pointsCallibrated;

@synthesize compassView;
@synthesize locationManager, currentHeading;
@synthesize currentPoint;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //[self performSelector:@selector(setProgress:) withObject:[NSNumber numberWithFloat:1.0] afterDelay:0.0];
    [self initializeData];
}

-(void)viewWillDisappear:(BOOL)animated
{
   
    if (self.locationManager) {
        [locationManager stopUpdatingHeading];
        [locationManager stopUpdatingLocation];
    }
}
- (void)initializeData
{
    progressCurrentvalue = intialValue;
    newToValueProgress = intialValue;
    IsAnimationInProgress = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateHeadingDisplays {
    // Animate Compass
    [UIView animateWithDuration:animationDuration
                          delay:intialValue
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         CGAffineTransform headingRotation;
                         headingRotation = CGAffineTransformRotate(CGAffineTransformIdentity, (CGFloat)-toRad(currentHeading));
                         compassView.transform = headingRotation;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    rotationAngleInDegrees = toDeg((CGFloat)-toRad(currentHeading) );
    rotationAngleInDegrees = (rotationAngleInDegrees + 360) % 360;
    
    
    
    [directionAngleValue setText:[NSString stringWithFormat:@"%03d ° N",rotationAngleInDegrees]];
    [rotationValue setText:[NSString stringWithFormat:@"%03d degree",rotationAngleInDegrees]];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    currentLocation = newLocation.coordinate;
    [self updateHeadingDisplays];
    
}

- (void)startLocationHeadingEvents {
    if (!self.locationManager) {
        CLLocationManager* theManager = [[CLLocationManager alloc] init];
        
        // Retain the object in a property.
        self.locationManager = theManager;
        locationManager.delegate = self;
    }
    
    // Start location services to get the true heading.
    locationManager.distanceFilter = 1;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    [locationManager startUpdatingLocation];
    
    // Start heading updates.
    if ([CLLocationManager headingAvailable]) {
        locationManager.headingFilter = 1;
        [locationManager startUpdatingHeading];
    }
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if (newHeading.headingAccuracy < 0)
        return;
    
    // Use the true heading if it is valid.
    CLLocationDirection  theHeading = ((newHeading.trueHeading > intialValue) ?
                                       newHeading.trueHeading : newHeading.magneticHeading);
    
    self.currentHeading = theHeading;
    [self updateHeadingDisplays];

    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self startLocationHeadingEvents] ;
    
    [self updateHeadingDisplays];
}


@end
