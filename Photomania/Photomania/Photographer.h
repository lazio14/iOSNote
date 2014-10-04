//
//  Photographer.h
//  Photomania
//
//  Created by lazio14 on 14-10-4.
//  Copyright (c) 2014年 lazio14. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Photographer : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *takephotos;
@end

@interface Photographer (CoreDataGeneratedAccessors)

- (void)addTakephotosObject:(Photo*)value;
- (void)removeTakephotosObject:(Photo *)value;
- (void)addTakephotos:(NSSet *)values;
- (void)removeTakephotos:(NSSet *)values;

@end
