//
//  DotPlayingScnen.h
//  disappear
//
//  Created by CpyShine on 13-6-1.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#include "config.h"

@class DataHandle;

@class DotHudController;

@interface DotPlayingScnen : CCLayer {
    
    DotHudController * m_hudController;
    
    DataHandle       * m_data;
    
    CGFloat m_delta;
    
    NSInteger m_score;
    NSInteger m_timeCounter;
    
    BOOL m_pause;
}

+(CCScene*)scene;

-(void) startDotGame;

-(void) playingScoreAdd:(NSInteger) score;

-(void) playerUsedToolDisappear:(PLAYERTOOLTYPE) type;

-(void) pauseGame;
-(void) resumeGame;

@end
