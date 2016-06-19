//
//  GMapViewController.m
//  GoogleIntegrationDemo
//
//  Created by Krishana on 12/29/15.
//  Copyright © 2015 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import "GMapViewController.h"
@import GoogleMaps;

@interface GMapViewController ()

@end

@implementation GMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [GMSServices provideAPIKey:@"AIzaSyDgKZJr68Sorrhp-pnBcTZHBrOMNRrxcEA"];

   // NSLog(@"array->: %@",self.locationArray);

    // Do any additional setup after loading the view.
    [self showPolylineonMapView:self.locationArray];
}

#pragma mark -  FOR POLYLINE

-(void) showPolylineonMapView:(NSArray *)pointsArray
{
    double startLat = [[[[self.locationArray objectAtIndex:0] objectForKey:@"source"]objectForKey:@"lat"] doubleValue];
    double startLng = [[[[self.locationArray objectAtIndex:0] objectForKey:@"source"]objectForKey:@"lng"] doubleValue];
    
    double dLat = [[[[self.locationArray lastObject] objectForKey:@"destination"]objectForKey:@"lat"] doubleValue];
    double dLng = [[[[self.locationArray lastObject] objectForKey:@"destination"]objectForKey:@"lng"] doubleValue];
    
   
    
    //FOR POLYLINE
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:startLat
                                                                longitude:startLng
                                                                     zoom:15];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    GMSMarker *dmarker = [[GMSMarker alloc] init];
    dmarker.position = CLLocationCoordinate2DMake(dLat, dLng);
    dmarker.title = @"My Location";
    dmarker.snippet = @"Destination";
    dmarker.appearAnimation = kGMSMarkerAnimationPop;
    //marker.icon = [UIImage imageNamed:@"kipl.png"];
    dmarker.map = mapView;

    mapView.mapType = kGMSTypeTerrain;

    for (int i =0; i<self.polyArray.count; i++)
    {
        GMSPath *path = [GMSPath pathFromEncodedPath:[self.polyArray objectAtIndex:i]];
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.strokeColor = [UIColor blueColor];
        polyline.strokeWidth = 5.f;
        polyline.map = mapView;
        
    }
    
//    GMSMutablePath *path = [GMSMutablePath path];
//    
    for (NSDictionary *pointsDic in self.locationArray)
    {
        NSDictionary *sourceDic = [pointsDic objectForKey:@"source"];
        
        double lat = [[sourceDic objectForKey:@"lat"] doubleValue];
        double lng = [[sourceDic objectForKey:@"lng"] doubleValue];

        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(lat, lng);
        marker.title = [pointsDic objectForKey:@"addrs"];
        marker.snippet = @"";
        marker.appearAnimation = kGMSMarkerAnimationPop;
        //marker.icon = [UIImage imageNamed:@"kipl.png"];
        marker.map = mapView;
        //CLLocationCoordinate2D coordinatePoint = CLLocationCoordinate2DMake(lat, lng);
        //[path addCoordinate:coordinatePoint];
        /*****OR***/
        //[path addLatitude:lat longitude:lng];
        break;
    }
    
    
    
    
    self.view = mapView;

    //GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
//    GMSPolyline *polyline = self.polyline;
//    
//    polyline.strokeColor = [UIColor blueColor];
//    polyline.strokeWidth = 5.f;
//    polyline.map = mapView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
