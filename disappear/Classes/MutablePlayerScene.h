//
//  MutablePlayerScene.h
//  disappear
//
//  Created by CpyShine on 13-6-19.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "config.h"
@class MutableLayer;
@class MatchHudLayer;
@class MatchPlayingHudLayer;
@class DataHandle;
@interface MutablePlayerScene : CCScene {
    
    MutableLayer *backLayer;
    MatchHudLayer * m_hudLayer;
    
    MatchPlayingHudLayer * m_playingHudLayer;
    
    DataHandle * m_core;
    
    
    CGFloat m_delta;
    
    CGFloat m_timeCounter;
    
    NSInteger m_point;
    
    CGFloat m_sendDelta;
    
}


-(void) playingScoreAdd:(NSInteger) score;

-(void) startGame:(NSString*)oppname Point:(NSString*)point;
-(void) playerUsedToolDisappear:(PLAYERTOOLTYPE) type;

@end
