//
//  MatchHudLayer.m
//  disappear
//
//  Created by CpyShine on 13-6-20.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import "MatchHudLayer.h"

#import "NetWorkHandle.h"

#import "WebRegisterController.h"

#import "MutablePlayerScene.h"
#import "AppDelegate.h"


@implementation MatchHudLayer

- (id)init
{
    self = [super init];
    if (self) {
        [self setAnchorPoint:CGPointZero];
        hasResponse = false;
    }
    return self;
}

-(void)onEnter{
    [super onEnter];
    CGSize size = [CCDirector sharedDirector].winSize;
    
    
//    [menu setIgnoreAnchorPointForPosition:true];
}

-(void) startMatch:(id)sender{
    if (hasResponse) {
        return;
    }
    hasResponse = true;
}

-(void) exitMatch{
}

-(void)onExit{
}


-(void)reveiveMessage:(NSDictionary *)dic Error:(NSDictionary *)error{
    NSLog(@"dic:%@",dic);NSLog(@"error:%@",error);
    if (dic) {
        [self otherMessageHandle:dic];
    }else{
        [self errorMessageHandle :error];
    }
    
}

-(void) otherMessageHandle:(NSDictionary*)dic{
    
    NSString * title = nil;
    NSString * message = nil;
    NSString * oBTitile = nil;
    
    NSInteger tag = 0;
    
//    NSLog(@"%@",[[dic objectForKey:@"fail_code"] class]);
    
}

-(void) errorMessageHandle:(NSDictionary*)error{
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    hasResponse = false;
    
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
//            [self stargGame];
        }
    }
    if (alertView.tag == 2) {
        if (buttonIndex == 1) {
            [self registerNow];
        }
    }
}

-(void) stargGame:(NSString*)oppname :(NSString*)oppPoint{
    if (self.parent) {
        NSLog(@"start game!");
        MutablePlayerScene * mps = (MutablePlayerScene*)self.parent;
        [mps startGame:oppname Point:oppPoint];
    }
    return;
}


-(void) registerNow{
    
    WebRegisterController * viewController = [[[WebRegisterController alloc]init]autorelease];
    
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    
    [[app navController] pushViewController:viewController animated:YES];
}


@end
