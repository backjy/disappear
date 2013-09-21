//
//  DotGameScene.m
//  disappear
//
//  Created by CpyShine on 13-5-31.
//  Copyright 2013年 CpyShine. All rights reserved.
//

#import "DotGameScene.h"

#include "AppDelegate.h"

#import "DotPlayingScnen.h"

#import "DataController.h"

#import "TableLayer.h"

#import "TopScoreLayer.h"
#import "config.h"

#import "NetWorkHandle.h"

#import "MutablePlayerScene.h"

#import "WebRegisterController.h"

#define GameLayerTag 1001


@implementation DotGameScene


- (id)init
{
    self = [super init];
    if (self) {
        
        CCLayerColor * backGroundLayer = [CCLayerColor layerWithColor:ccc4(100, 100, 100, 255)];
        [backGroundLayer setAnchorPoint:ccp(0, 0)];
        [self addChild:backGroundLayer];
        
//        [DataController getSharedDataController];
////        
//        [[DataController getSharedDataController] savePlayerTemplateData:300];
//        [[DataController getSharedDataController] savePlayerTemplateData:300];
//        [[DataController getSharedDataController] savePlayerTemplateData:300];
//        [[DataController getSharedDataController] savePlayerTemplateData:300];
////
//        NSArray * array = [NSArray arrayWithArray:[[DataController getSharedDataController] readLoaclScoreTopList]];
//        
//        NSLog(@"%@",array);
//        for (int i=0; i<80; i++) {
//            NSLog(@"level %d:%ld",i+1,expArray[i]);
//        }
    }
    return self;
}


-(void)onEnter{
    
    [super onEnter];
    
    CGSize size = [CCDirector sharedDirector].winSize;
    
    
    m_playnow = [CCMenuItemImage itemWithNormalImage:@"Images/play_now.png" selectedImage:@"Images/play_now.png" target:self selector:@selector(playingNow:)];
    
    m_multiplayer = [CCMenuItemImage itemWithNormalImage:@"Images/multiple_player.png" selectedImage:@"Images/multiple_player.png" target:self selector:@selector(multiplePlayer:)];
    
    m_highscore = [CCMenuItemImage itemWithNormalImage:@"Images/high_score.png" selectedImage:@"Images/high_score.png" target:self selector:@selector(highScore:)];
    
    m_settings = [CCMenuItemImage itemWithNormalImage:@"Images/settings.png" selectedImage:@"Images/settings.png" target:self selector:@selector(settings:)];
    
    m_aboutus = [CCMenuItemImage itemWithNormalImage:@"Images/about_us.png" selectedImage:@"Images/about_us.png" target:self selector:@selector(aboutus:)];
    
    CCMenu *menu = [CCMenu menuWithItems:m_playnow, m_multiplayer,
                    m_highscore, m_settings, m_aboutus, nil];
    
    [menu alignItemsVerticallyWithPadding:10];
    
    [menu setPosition:ccp(size.width/2,size.height/3)];

    [self addChild:menu];
}


-(void) startGame{
    
    [self removeAllChildren];
    
}


-(void) playingNow:(id)sender{
    
    CCScene * playingScene = [DotPlayingScnen scene];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionMoveInR transitionWithDuration:0.2 scene:playingScene]];
}

-(void) multiplePlayer:(id) sender{
//    [[NetWorkHandle getSharedNetWork] startMatchOppoent:self];
    CCScene * playingScene = [MutablePlayerScene node];
    
    [[CCDirector sharedDirector] pushScene:[CCTransitionMoveInR transitionWithDuration:0.2 scene:playingScene]];
}

-(void) highScore:(id) sender{
    
    CCScene * playingScene = [TopScoreLayer scene];
    
    [[CCDirector sharedDirector] pushScene:[CCTransitionMoveInR transitionWithDuration:0.2 scene:playingScene]];
}

-(void) settings:(id) sender{
    
}

-(void) aboutus:(id) sender{
    
}

-(void)onEnterTransitionDidFinish{
    [super onEnterTransitionDidFinish];
    NSLog(@"trans");
}

@end
