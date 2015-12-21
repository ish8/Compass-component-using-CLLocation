//
//  ViewController.h
//  compassProcess
//
//  Created by Ish on 4/3/14.
//  Copyright (c) 2014 Ishani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
@interface ViewController : UIViewController<CLLocationManagerDelegate>
{
    CMMotionManager *motionManager;
    NSTimer *timer;
    float rotation;
    float previousRotationAngle;
    int rotationAngleInDegrees;
    
    //for custom progress
    float progressCurrentvalue;
    float newToValueProgress;
    
    BOOL IsAnimationInProgress;
    
    //for corelocation compass
    IBOutlet UIScrollView   *compassView;
    CLLocationManager       *locationManager;
    
    CLLocationCoordinate2D  currentLocation;
    CLLocationDirection     currentHeading;

}

#pragma properties declared

@property int progressFinalValue;
@property float progressCurrentvalue;
@property (weak, nonatomic) IBOutlet UILabel *progressTimerIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *compassInsideImage;
@property(nonatomic, retain) IBOutlet UIImageView *compassImage;
@property (weak, nonatomic) IBOutlet UILabel *directionAngleValue;


@property (nonatomic,retain) NSNumber *totalPoints;
@property (nonatomic,retain) NSNumber *pointsCallibrated;
@property (nonatomic,retain) NSNumber *currentPoint;

@property (weak, nonatomic) IBOutlet UILabel *timeLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLeftValue;
@property (weak, nonatomic) IBOutlet UILabel *rotationLabel;
@property (weak, nonatomic) IBOutlet UILabel *rotationValue;
@property (weak, nonatomic) IBOutlet UILabel *pointsLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *PointsLeftValue;
@property(nonatomic, retain) IBOutlet UIImageView *emptyStatusBarImage;
//@property (nonatomic, strong) LBSMapViewController *mapViewController;
//for core location compass
@property (nonatomic, retain) IBOutlet UIScrollView *compassView;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic) CLLocationDirection currentHeading;



@end
