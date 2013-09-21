//
//  TopScoreLayer.h
//  disappear
//
//  Created by CpyShine on 13-6-7.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class TableLayer;
@interface TopScoreLayer : CCLayerColor {
    
    CCLabelTTF * m_logoLabel;
    
    CCLabelTTF * m_levelLabel;
    
    CCLabelTTF * m_goldlabel;
    
    CCLabelTTF * m_highScore;
    
    CCLabelTTF * m_thisRound;
    
    CCProgressTimer * m_expProgress;
    
    TableLayer * m_tableLayer;
    
    CCMenuItemImage * m_imageItem;
    
    CGPoint m_touchStartLocation;
    
    BOOL m_imageButtonResponseType;
    
    BOOL m_canTriggerAction;
}

+(CCScene*) scene;

-(void) startAnimationDisplay:(NSInteger) score;

-(void) startAnimationDisplay;

@end
