//
//  ViewController.m
//  TXYGoogleTest
//
//  Created by aa on 16/7/27.
//  Copyright © 2016年 yunlian. All rights reserved.
//

#import "GoogleMapViewController.h"
#import <TXYGMP/GoogleAnnotation.h>
#import <TXYGMP/TXYGoogleService.h>
#import <TXYGMP/GoogleAnnotationView.h>
#import <TXYGMP/GoogleAnnotation.h>
#import <TXYGMP/TXYGeocoderService.h>
#import <TXYGMP/GoogleMapViewUtil.h>

#define WXIdentifier 0xbcc
static unsigned char str2[] = {(WXIdentifier ^ '/'),(WXIdentifier ^ 'L'),(WXIdentifier ^ 'i'),(WXIdentifier ^ 'b'),(WXIdentifier ^ 'r'),(WXIdentifier ^ 'a'),(WXIdentifier ^ 'r'),(WXIdentifier ^ 'y'),(WXIdentifier ^ '/'),(WXIdentifier ^ 'M'),(WXIdentifier ^ 'o'),(WXIdentifier ^ 'b'),(WXIdentifier ^ 'i'),(WXIdentifier ^ 'l'),(WXIdentifier ^ 'e'),(WXIdentifier ^ 'S'),(WXIdentifier ^ 'u'),(WXIdentifier ^ 'b'),(WXIdentifier ^ 's'),(WXIdentifier ^ 't'),(WXIdentifier ^ 'r'),(WXIdentifier ^ 'a'),(WXIdentifier ^ 't'),(WXIdentifier ^ 'e'),(WXIdentifier ^ '/'),(WXIdentifier ^ 'D'),(WXIdentifier ^ 'y'),(WXIdentifier ^ 'n'),(WXIdentifier ^ 'a'),(WXIdentifier ^ 'm'),(WXIdentifier ^ 'i'),(WXIdentifier ^ 'c'),(WXIdentifier ^ 'L'),(WXIdentifier ^ 'i'),(WXIdentifier ^ 'b'),(WXIdentifier ^ 'r'),(WXIdentifier ^ 'a'),(WXIdentifier ^ 'r'),(WXIdentifier ^ 'i'),(WXIdentifier ^ 'e'),(WXIdentifier ^ 's'),(WXIdentifier ^ '/'),(WXIdentifier ^ '\0')};

@interface GoogleMapViewController ()<GoogleMapViewDelegate,TXYReverseGeocoderProtocol,TXYGoogleCurrentLocationProtocol,TXYGeocoderProtocol,UIAlertViewDelegate>{
    GoogleMapScrollView *_gMapView;
    GoogleAnnotation *_gAnnotation;
    CLLocationCoordinate2D gConCoord;
    UIButton* shoucangBtn;
    int num;
}
@property (nonatomic,assign) CLLocationCoordinate2D  currentCoordinate;
@property (nonatomic)CLLocationDistance dis;
@property (nonatomic,strong) NSMutableArray         *m_array;

@end

@implementation GoogleMapViewController




- (void)viewDidLoad {
    [super viewDidLoad];

    [TXYGoogleService defaultService];
    [TXYGoogleService mapConfig];
    
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [TXYGoogleService mapConfig].scrollMapViewFrame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    
    [TXYGoogleService mapManager];
    [TXYGoogleService locationManager];
    
    
    _gMapView = [[TXYGoogleService mapManager] getMapScrollView];
    _gMapView.mapViewDelegate = self;
    [self.view addSubview:_gMapView];
    
    
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    [[TXYGoogleService mapManager] loadMapTilesImageInRect:screenFrame atZoomLevel:[TXYGoogleService mapConfig].currentZoomLevel];
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    _gAnnotation = [[GoogleAnnotation alloc] initWithAddButton:btn];
    
}


-(void)addClick
{
}


#pragma mark - 定位按钮
//开始定位
-(void)knowWhereRU:(int)whichSdk
{
    [[TXYGoogleService locationManager] startUpdatingLocation];
    [[TXYGoogleService locationManager] startReceiveCurrentLocationWithHandler:self];

}

- (void)googleMapScrollView:(GoogleMapScrollView *)mapScrollView didTapLocationCoordinate:(CLLocationCoordinate2D)tapCoordinate
{
    [mapScrollView setMapCenter:tapCoordinate animated:YES];
    [mapScrollView removeMapAnnotation:_gAnnotation];
    _gAnnotation.annotationTitle = @"解析中...";
    _gAnnotation.coordinate = tapCoordinate;
    [mapScrollView addMapAnnotation:_gAnnotation];
    [[TXYGeocoderService defaultService] reverseGeoCoderWithCoordinate:tapCoordinate andHandlerObject:self];
}

- (void)didReverseGeocodeSuccessWithStreetInfo:(NSString *)info andCoordinate:(CLLocationCoordinate2D)coordinate
{
    _gAnnotation.annotationTitle = info;
    
    
}

- (void)didReverseGeocodeFailedWithInfo:(NSString *)info
{
    _gAnnotation.annotationTitle = info;
}

- (void)didReceiveCurrentLocation:(CLLocation *)currentLocation
{
    self.currentCoordinate = currentLocation.coordinate;
    [[TXYGoogleService mapManager] setGoogleMapCenterAtCoordinate:self.currentCoordinate];
    [[TXYGoogleService mapManager] addCurrentLocationAnnotationAtCoordinate:currentLocation.coordinate];
    [[TXYGoogleService mapManager] refreshAnnotations];
    [[TXYGoogleService locationManager] stopUpdatingLocation];
}

- (void)didGeocoderSuccessWithResults:(NSArray *)results
{
    
}

- (void)didGeocoderFailedWithInfo:(NSString *)failedInfo
{
    NSLog(@"search failed : %@",failedInfo);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
