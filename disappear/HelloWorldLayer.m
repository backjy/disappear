//
//  HelloWorldLayer.m
//  disappear
//
//  Created by CpyShine on 13-5-29.
//  Copyright CpyShine 2013年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#include "DrawSprite.h"

#include "DataHandle.h"


#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
//        CGSize size = [CCDirector sharedDirector].winSize;
////
//        CCSprite * sprite = [CCSprite spriteWithFile:@"Icon.png"];
//        [sprite setPosition:ccp(size.width/2, size.height/2)];
//        
//        [self addChild:sprite];
        
//        CCMenuItemFont * fount = [CCMenuItemFont itemWithString:@"Jump Action"];
//        [fount setBlock:^(id sender) {
//            CCJumpTo * jump = [CCJumpTo actionWithDuration:0.4 position:sprite.position height:15 jumps:2];
//            sprite.scale = 1;
//            CCScaleBy * scaleBy = [CCScaleBy actionWithDuration:0.2 scale:2];
//            
//            [sprite runAction:scaleBy];
//            [sprite randpos];
//        }];
        
//        CCMenu * menu = [CCMenu menuWithItems:fount, nil];
//        [menu setPosition:ccp(100, 100)];
//        [self addChild:menu];
        
    }
	return self;
}

-(void)onEnter{
    [super onEnter];
    
    [self setTouchMode:kCCTouchesOneByOne];
    [self setTouchEnabled:YES];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
    CGPoint local = [m_data convertToNodeSpace:touchLocation];
    
    if (m_data) {
        return [m_data touchBegine:local];
    }
    return NO;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    
    CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
    CGPoint local = [m_data convertToNodeSpace:touchLocation];
    
    if (m_data) {
        [m_data touchMove:local];
    }
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    [m_data touchEnd];
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event{
    [m_data touchEnd];
}

-(void)draw{
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[super dealloc];
}


@end
