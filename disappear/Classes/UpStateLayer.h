//
//  UpStateLayer.h
//  disappear
//
//  Created by CpyShine on 13-6-6.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface UpStateLayer : CCLayerColor {
    
    CCLabelTTF * m_labelTime;
    CCLabelTTF * m_labelScore;
    
    CCMenuItemImage * m_scoreItem;
    CCMenuItemImage * m_timeItem;
}

-(void) resetTimeString:(NSString*)string;
-(void) resetScoreString:(NSString*) string;

-(void) startAnimationDisplay;

@end
