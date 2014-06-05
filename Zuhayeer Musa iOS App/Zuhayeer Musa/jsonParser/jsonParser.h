//
//  jsonParser.h
//
//  Created by Ash Bhat on 3/26/14.
//  Copyright (c) 2014 Ash Bhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface jsonParser : UIViewController
@property NSString *urlString;
-(void)returnJsonwithParam:(NSDictionary *)parameters andEndpointString:(NSString *)urlString WithHandler:(void(^)(NSArray *result))handler;

@end
