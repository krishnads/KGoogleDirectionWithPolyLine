//
//  ViewController.m
//  GoogleDirectionWithPolyLine
//
//  Created by Krishana on 6/13/16.
//  Copyright © 2016 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"
#import "GMapViewController.h"

@import GoogleMaps;

@interface ViewController ()
{
    NSMutableData *_responseData;
    NSMutableArray *tableArr;
    NSMutableArray *polyArr;

    IBOutlet UITextField *sourceField;
    IBOutlet UITextField *destField;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    sourceField.text = @"Jaipur Junction, Jaipur, India";
    destField.text = @"New Delhi, India";
    
}

- (IBAction)getDirectionButtonAction:(id)sender
{
    if (sourceField.text.length == 0 || destField.text.length == 0)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Enter both source and destination" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        // Create the request.
        
        NSString *urlStr = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&key=AIzaSyD7xqWG_cfPOpzd_FC4D1K4EGS36GSpjzc",sourceField.text,destField.text];
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        
        NSLog(@"url->%@",urlStr);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        
        // Create url connection and fire request
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [conn start];
    }
}


#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:_responseData
                                                         options:kNilOptions
                                                           error:&error];
    
    //NSArray* latestLoans = [json objectForKey:@"loans"];
    NSLog(@"response: %@",json);

    NSDictionary *dic = [[[[[json objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"] objectAtIndex:0] objectForKey:@"steps"];

    
    
    NSArray *routesArray = [json objectForKey:@"routes"];
    
    GMSPolyline *polyline = nil;
    if ([routesArray count] > 0)
    {
        NSDictionary *routeDict = [routesArray objectAtIndex:0];
        NSDictionary *routeOverviewPolyline = [routeDict objectForKey:@"overview_polyline"];
        NSString *points = [routeOverviewPolyline objectForKey:@"points"];
        GMSPath *path = [GMSPath pathFromEncodedPath:points];
        polyline = [GMSPolyline polylineWithPath:path];
    }

    tableArr = [[NSMutableArray alloc] init];
    polyArr = [[NSMutableArray alloc] init];
    
    for (NSDictionary *sDic in dic)
    {
        NSString *encodedPath = [[sDic objectForKey:@"polyline"]  objectForKey:@"points"];
        
        [polyArr addObject:encodedPath];
        NSString *sourceLocation = [sDic objectForKey:@"start_location"];
        NSString *destinationLocation = [sDic objectForKey:@"end_location"];

        NSMutableDictionary *locDic = [[NSMutableDictionary alloc] init];
        [locDic setObject:sourceLocation forKey:@"source"];
        [locDic setObject:destinationLocation forKey:@"destination"];
        //Source
        NSString *sourceAddrs = [[[[[json objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"] objectAtIndex:0] objectForKey:@"start_address"];

        [locDic setObject:sourceAddrs forKey:@"addrs"];
        
        [tableArr addObject:locDic];
    }
    
    NSLog(@"response: %@",tableArr);
    
    [self performSegueWithIdentifier:@"MAP_VIEW_SEGUE" sender:polyline];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"error->%@",error.userInfo);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.userInfo.description preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
    
    GMapViewController *vc = (GMapViewController *)[segue destinationViewController];
    vc.locationArray = tableArr;
    vc.polyline = (GMSPolyline *)sender;
    vc.polyArray = polyArr;
 }
 


@end
