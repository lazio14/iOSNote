//
//  JustPostPhotoTVC.m
//  Shutterbug
//
//  Created by lazio14 on 14-10-3.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import "JustPostPhotoTVC.h"

@interface JustPostPhotoTVC ()

@end

@implementation JustPostPhotoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchPhotos];
//    NSArray *list = [NSArray arrayWithObjects:@"武汉",@"上海",@"北京",@"深圳",@"广州",@"重庆",@"香港",@"台海",@"天津", nil];
}

- (void)fetchPhotos
{
    NSMutableArray *photosArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        [self addPhoto:i URL:@"test" ARRAY:photosArray];
    }
    
    self.photos = photosArray;
}

- (void) addPhoto:(int)idx URL:(NSString*)url ARRAY:(NSMutableArray*)photos
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[[NSString alloc] initWithFormat:@"this is title%d", idx] forKey:@"title"];
    [dic setObject:[[NSString alloc] initWithFormat:@"this is detail%d", idx] forKey:@"detail"];
    [dic setObject:url forKey:@"url"];
    
    [photos addObject:dic];
}

@end
