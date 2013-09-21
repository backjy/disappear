//
//  DataHandle.h
//  disappear
//
//  Created by CpyShine on 13-5-29.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#include "config.h"

@class DrawSprite;

@interface DataHandle : CCLayerColor {
    
    NSMutableArray * m_drawSpriteArray;
    
    ccColor4F m_currentDrawColor;
    
    NSMutableArray * m_stackArray;
    
    BOOL m_drawLine;
    
    BOOL m_objectHasContina;
    
    BOOL m_removeAllSameColor;
    
    BOOL m_toolsDisappear;
    
    BOOL m_toolsDisappearType;
    
    BOOL m_canPlaying;
    
    CGPoint m_movePos;
}

-(void) startAnimtionDisplay;

-(void) startPlaying;

//-(DrawSprite *)getCurrentSelectSprite:(CGPoint)pos color:(ccColor4F) color;

-(BOOL) touchBegine:(CGPoint) local;//touch begine

-(void) touchMove:(CGPoint) local; // touch moved

-(void) touchEnd;// touch 结束

-(void) disappearEnd;// 消除结束

-(BOOL) allDrawNodeBeSelected:(BOOL) disappearType;//全部选中

//-(void) cancelAllDrawNodeBeSelected;// 取消全部选中的情况

-(void) moveOut;
-(void) moveIn;

@end
