//
//  Location.h
//  SIGView
//
//  Created by Cainã on 12/24/12.
//
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import "Global.h"

@interface  LocationManager : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}

+ (LocationManager *)sharedInstance;

- (void)start;
- (void)stop;
- (BOOL)locationKnown;

@property (nonatomic, retain) CLLocation *currentLocation;

- (void)configureLocationManager;

@end
