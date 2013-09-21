//
//  MutablePlayerScene.m
//  disappear
//
//  Created by CpyShine on 13-6-19.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import "MutablePlayerScene.h"
#import "MutableLayer.h"
#import "MatchHudLayer.h"
#import "MatchPlayingHudLayer.h"
#import "DataHandle.h"

@implementation MutablePlayerScene

-(id)init{
    if([super init]){
        
        backLayer = [MutableLayer node];
        [self addChild:backLayer z:0 tag:1];
        
         m_hudLayer= [MatchHudLayer node];
        [self addChild:m_hudLayer];
        
        m_core = [DataHandle node];
        [self addChild:m_core];
        
        m_playingHudLayer = [MatchPlayingHudLayer node];
        [self addChild:m_playingHudLayer];
        
        m_sendDelta = 2.0;
    }
    return self;
}

-(void)onEnterTransitionDidFinish{
    [super onEnterTransitionDidFinish];
    [backLayer startAnimation];
}

-(void)startGame:(NSString *)oppname Point:(NSString *)point{
    
    m_hudLayer.visible = false;
    backLayer.visible = false;
    
    [m_core startAnimtionDisplay];
    [m_core startPlaying];
    
    [m_playingHudLayer startAnimation:oppname];
    
    m_timeCounter = 60.0;
    [self scheduleUpdate];
}


-(void)update:(ccTime)delta{
    m_delta += delta;
    if (m_delta>0.9999) {
        m_delta = 0;
        m_timeCounter -=1.0;
        if (m_timeCounter<=0) {
            [m_playingHudLayer resetTimeString:m_timeCounter];
            [self gameOver];
        }else{
            
            [m_playingHudLayer resetTimeString:m_timeCounter];
        }
    }
//    m_sendDelta +=delta;
//    if (m_sendDelta>=2.0) {
//        m_sendDelta = 0;
////        [m_playingHudLayer sendMessage:m_point];
//    }
}

-(void)playingScoreAdd:(NSInteger)score{
    m_point +=score;
    if (m_playingHudLayer) {
        [m_playingHudLayer sendMessage:score];
        [m_playingHudLayer resetPoint:m_point];
    }
}

-(void) gameOver{
    [self unscheduleUpdate];
    [m_core moveOut];
    [m_playingHudLayer gameOver:m_point];
}


-(void)playerUsedToolDisappear:(PLAYERTOOLTYPE)type{
    
    if (type == tooltime) {
        
    }else{
        if (type == toolDisappearAll) {
            if([m_core allDrawNodeBeSelected:YES]){
                
            }
        }else{
            
            if([m_core allDrawNodeBeSelected:NO]){
                
            }
        }
    }

}


@end
