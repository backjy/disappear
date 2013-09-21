//
//  NetWorkHandle.m
//  disappear
//
//  Created by CpyShine on 13-6-19.
//  Copyright (c) 2013年 CpyShine. All rights reserved.
//

#import "NetWorkHandle.h"
#import "DeviveMD5/UIDevice+IdentifierAddition.h"
#import "MatchHudLayer.h"

@implementation NetWorkHandle

static NetWorkHandle* _sharedNewWork = NULL;

+(NetWorkHandle *)getSharedNetWork{
    if (!_sharedNewWork) {
        _sharedNewWork = [[NetWorkHandle alloc] init];
    }
    return _sharedNewWork;
}

- (id)init
{
    self = [super init];
    if (self) {
        selfMd5Address = [[[UIDevice currentDevice] uniqueGlobalDeviceIdentifier] retain];
    }
    return self;
}

-(void)startMatchOppoent:(id)startMatchDelegate{
    startMatchDel = startMatchDelegate;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://183.230.5.13:8020/Game1/LookingPartners?appid=%@",selfMd5Address]];
    NSLog(@"%@",url);
    ASIHTTPRequest * startMatchRequest = [ASIHTTPRequest requestWithURL:url];
//    startMatchRequest.delegate = self;
    [startMatchRequest setRequestMethod:@"GET"];
    [startMatchRequest setTimeOutSeconds:30.0];
    
    [startMatchRequest setCompletionBlock:^{
        
        NSError * error;
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:startMatchRequest.responseData options:NSJSONReadingMutableLeaves error:&error];
        
        if (startMatchDel) {
            MatchHudLayer * hud = (MatchHudLayer*)startMatchDel;
            [hud reveiveMessage:dic Error:nil];
        }
        
    }];
    
    [startMatchRequest setFailedBlock:^{
        if (startMatchDel) {
            MatchHudLayer * hud = (MatchHudLayer*)startMatchDel;
            [hud reveiveMessage:nil Error:startMatchRequest.error.userInfo];
        }
    }];
    [startMatchRequest startAsynchronous];
}

-(void)cancellationMatchOppoent{
    startMatchDel = Nil;
}

-(void) sendCurrentPoint:(id) sendDelegate point:(NSInteger) point{
    sendPointDel = sendDelegate;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"NULL",selfMd5Address,point]];
    ASIHTTPRequest * sendPoint = [ASIHTTPRequest requestWithURL:url];
    [sendPoint setRequestMethod:@"GET"];
    [sendPoint setTimeOutSeconds:30.0];
    
    [sendPoint setCompletionBlock:^{
        
        NSError * error;
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:sendPoint.responseData options:NSJSONReadingMutableLeaves error:&error];
        
        if (sendPointDel) {
//            MatchHudLayer * hud = (MatchHudLayer*)startMatchDel;
//            [hud reveiveMessage:dic Error:nil];
            [sendPointDel reveiveMessage:dic Error:nil];
        }
        
    }];
    
    [sendPoint setFailedBlock:^{
        if (sendPointDel) {
//            MatchHudLayer * hud = (MatchHudLayer*)startMatchDel;
            [sendPointDel reveiveMessage:nil Error:sendPoint.error.userInfo];;
        }
    }];
    [sendPoint startAsynchronous];
}
-(void) cancellationSendPoint{
    sendPointDel = nil;
}

-(void) sendGameOver:(id) gameOver point:(NSInteger)point{
    
    sendGameOverDel = gameOver;
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"NULL",selfMd5Address]];
    ASIHTTPRequest * gameOverR = [ASIHTTPRequest requestWithURL:url];
    [gameOverR setRequestMethod:@"GET"];
    [gameOverR setTimeOutSeconds:30.0];
    
    [gameOverR setCompletionBlock:^{
        
        NSError * error;
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:gameOverR.responseData options:NSJSONReadingMutableLeaves error:&error];
        
        if (sendPointDel) {
//            MatchHudLayer * hud = (MatchHudLayer*)startMatchDel;
//            [hud reveiveMessage:dic Error:nil];
            [sendGameOverDel gameOverMssage:dic Error:nil];
        }
        
    }];
    
    [gameOverR setFailedBlock:^{
        if (sendPointDel) {
//            MatchHudLayer * hud = (MatchHudLayer*)startMatchDel;
            [sendGameOverDel gameOverMssage:nil Error:gameOverR.error.userInfo];
        }
    }];
    [gameOverR startAsynchronous];
}
-(void) cancellationGameOver{
    
}


- (void)dealloc
{
    [selfMd5Address release];
    [super dealloc];
}

@end
