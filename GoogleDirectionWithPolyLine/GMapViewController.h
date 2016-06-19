//
//  GMapViewController.h
//  GoogleIntegrationDemo
//
//  Created by Krishana on 12/29/15.
//  Copyright © 2015 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;

@interface GMapViewController : UIViewController

@property (strong, nonatomic) NSArray *polyArray;

@property (strong, nonatomic) NSArray *locationArray;
@property (strong, nonatomic) GMSPolyline *polyline;

@end
