//
//  UpStateLayer.m
//  disappear
//
//  Created by CpyShine on 13-6-6.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import "UpStateLayer.h"

#import "DotHudController.h"

@implementation UpStateLayer

- (id)init
{
    CGSize s = [CCDirector sharedDirector].winSize;
    self = [super initWithColor:ccc4(198, 203, 206, 255) width:s.width height:60];
    if (self) {
        m_scoreItem = [CCMenuItemImage itemWithNormalImage:@"Images/scorebutton.png"
                                             selectedImage:@"Images/score_unselect.png" target:self selector:@selector(menuBePressed:)];
        
        m_timeItem = [CCMenuItemImage itemWithNormalImage:@"Images/timebutton.png"
                                            selectedImage:@"Images/time_unselect.png" target:self selector:@selector(menuBePressed:)];
        
        [m_scoreItem setAnchorPoint:ccp(0, 0)];
        [m_timeItem setAnchorPoint:ccp(1, 0)];
        
        [m_scoreItem setPosition:ccp(0, 0)];
        [m_timeItem setPosition:ccp(s.width, 0)];
        
        
        CCMenu * menu = [CCMenu menuWithItems:m_scoreItem, m_timeItem, nil];
        
        [menu setPosition:ccp(0, 2)];
        [self addChild:menu];
        
        m_labelScore = [CCLabelTTF labelWithString:@"0" fontName:@"Arial" fontSize:18];
        m_labelTime  = [CCLabelTTF labelWithString:@"60" fontName:@"Arial" fontSize:18];
        
        [m_labelScore setAnchorPoint:ccp(0, 0.5)];
        [m_labelScore setColor:ccc3(0, 0, 0)];
        [m_labelScore setPosition:ccp(m_scoreItem.contentSize.width/2+10,
                                      m_scoreItem.contentSize.height/2)];
        
        [m_labelTime setAnchorPoint:ccp(0, 0.5)];
        [m_labelTime setColor:ccc3(0, 0, 0)];
        [m_labelTime setPosition:ccp(m_timeItem.contentSize.width/2+10,
                                     m_timeItem.contentSize.height/2)];
        
        [m_timeItem addChild:m_labelTime z:11];
        [m_scoreItem addChild:m_labelScore z:11];
        
        [self setVisible:false];
    }
    return self;
}


-(void)startAnimationDisplay{
    
    CGSize s = [CCDirector sharedDirector].winSize;
    [self setVisible:true];
    
    [self setAnchorPoint:ccp(0, 0)];
    [self setPosition:ccp(0, s.height)];
    
    CCMoveTo * moveTo = [CCMoveTo actionWithDuration:0.2 position:ccp(0, s.height-60)];
    CCMoveTo * moveTo2 = [CCMoveTo actionWithDuration:0.2 position:ccp(0, s.height-43)];
    CCCallBlock * call = [CCCallBlock actionWithBlock:^{
        if (self.parent) {
            DotHudController * dhc = (DotHudController*)self.parent;
            [dhc startGame];
        }
    }];    
    [self runAction:[CCSequence actions:moveTo, moveTo2, call, nil]];
}

-(void)resetScoreString:(NSString *)string{
    [m_labelScore setString:string];
}
-(void) resetTimeString:(NSString *)string{
    [m_labelTime setString:string];
}

-(void) menuBePressed:(id)sender{
    if (self.parent) {
        DotHudController *hc = (DotHudController*)self.parent;
        [hc gamePause];
    }
}

@end
