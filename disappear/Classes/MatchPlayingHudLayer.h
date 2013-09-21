//
//  MatchPlayingHudLayer.h
//  disappear
//
//  Created by CpyShine on 13-6-20.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "config.h"
@class DownStateLayer;
@interface MatchPlayingHudLayer : CCLayer {
    
    DownStateLayer * m_downStateLayer;
    
    
    CCLabelTTF * selfName;
    CCLabelTTF * pointLabel;
    CCLabelTTF * timeLabel;
    
    CCLabelTTF * oppNameLabel;
    CCLabelTTF * oppPoints;
}

-(void) startAnimation:(NSString*)oppname;

-(void) playerUseSkill:(PLAYERTOOLTYPE) skillTpye;

-(void) resetPoint:(NSInteger) point;

-(void) resetTimeString:(CGFloat)times;

-(void) sendMessage:(NSInteger)point;

-(void) reveiveMessage:(NSDictionary*)infoDic Error:(NSDictionary*) errorMsg;

-(void) gameOverMssage:(NSDictionary*)infoDic Error:(NSDictionary*) errorMsg;


-(void) gameOver:(NSInteger) point;

@end
