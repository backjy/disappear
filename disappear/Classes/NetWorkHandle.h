//
//  NetWorkHandle.h
//  disappear
//
//  Created by CpyShine on 13-6-19.
//  Copyright (c) 2013年 CpyShine. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"
#import "ASIHTTPRequestDelegate.h"


@interface NetWorkHandle : NSObject{
    NSString * selfMd5Address;
    id startMatchDel;
    id sendPointDel;
    id sendGameOverDel;
}

+(NetWorkHandle*) getSharedNetWork;

-(void) startMatchOppoent:(id) startMatchDelegate;
-(void) cancellationMatchOppoent;

-(void) sendCurrentPoint:(id) sendDelegate point:(NSInteger) point;
-(void) cancellationSendPoint;

-(void) sendGameOver:(id) gameOver point:(NSInteger)point;
-(void) cancellationGameOver;

@end
