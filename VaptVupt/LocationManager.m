//
//  Location.m
//  SIGView
//
//  Created by Cainã on 12/24/12.
//
//

#import "LocationManager.h"

@implementation LocationManager

@synthesize currentLocation;

static LocationManager *sharedInstance;

#pragma mark - Singleton methods

/**
 * Singleton method to get always the same instance of a LocationManager object
 * @return a singleton LocationManager object
 */
+ (LocationManager *)sharedInstance {
    @synchronized(self) {
        if (!sharedInstance)
            sharedInstance = [[LocationManager alloc] init];
    }
    return sharedInstance;
}

+ (id)alloc {
    @synchronized(self) {
        NSAssert(sharedInstance == nil, @"Attempted to allocate a second instance of a singleton Location.");
        sharedInstance = [super alloc];
    }
    return sharedInstance;
}

- (id)init {
    if (self = [super init])
    {
        //Modificado silvio
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        self.currentLocation = [locationManager location];
        [self configureLocationManager];
    }
    return self;
}

/**
 * Configure the location manager with distance and interval values
 * @param the distance threshold to location manager receive position events
 * @param the interval to check for position events
 */
- (void)configureLocationManager{
    
    // Set the accuracy to the BestForNavigation, as we are tracking devices (users)
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    // Set a movement threshold for new events
    locationManager.distanceFilter = 10;
    
    // Start updating location
    [self start];
}

/**
 * Start updating location
 */
- (void)start {
    [locationManager startUpdatingLocation];
}

/**
 * Stop updating location temporarily, as the timer will start updating again when the interval end is reached
 */
- (void)stop {
    [locationManager stopUpdatingLocation];
}

- (BOOL)locationKnown {
    if (round(currentLocation.speed) == -1)
        return NO;
    else
        return YES;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

    //if the time interval returned from core location is more than two minutes we ignore it because it might be from an old session
    NSDate *eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    
    if ( abs(howRecent) < 15.0 )
    {

        self.currentLocation = newLocation;
        
#ifdef DEBUG_MODE
     NSLog(@"\nOLD --- \ncoord: \n%f / %f\nhorizontal accuracy: %f\nvertical accuracy: %f",oldLocation.coordinate.latitude,oldLocation.coordinate.longitude,oldLocation.horizontalAccuracy,oldLocation.verticalAccuracy);
     NSLog(@"\nNEW --- \ncoord: \n%f / %f\nhorizontal accuracy: %f\nvertical accuracy: %f\ncourse: %f",newLocation.coordinate.latitude,newLocation.coordinate.longitude,newLocation.horizontalAccuracy,newLocation.verticalAccuracy,newLocation.course);
#endif
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {

}

-(void) dealloc {
    [locationManager release];
    [currentLocation release];
    [super dealloc];
}

@end