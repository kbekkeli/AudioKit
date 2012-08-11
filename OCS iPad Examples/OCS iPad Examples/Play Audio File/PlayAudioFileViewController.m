//
//  PlayAudioFileViewController.m
//  Objective-C Sound Example
//
//  Created by Aurelius Prochazka on 6/16/12.
//  Copyright (c) 2012 Hear For Yourself. All rights reserved.
//

#import "PlayAudioFileViewController.h"
#import "Helper.h"
#import "OCSManager.h"
#import "AudioFilePlayer.h"

@interface PlayAudioFileViewController () {
    AudioFilePlayer *audioFilePlayer;
    OCSOrchestra *orchestra;
}
@end

@implementation PlayAudioFileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    orchestra = [[OCSOrchestra alloc] init];    
    audioFilePlayer = [[AudioFilePlayer alloc] init];
    [orchestra addInstrument:audioFilePlayer];
    [[OCSManager sharedOCSManager] runOrchestra:orchestra];

}

- (IBAction)touchButton:(id)sender {
    float speed = [Helper randomFloatFrom:kSpeedMin to:kSpeedMax];
    OCSEvent *start = [[OCSEvent alloc]initWithInstrument:audioFilePlayer];
    [start setNoteProperty:[audioFilePlayer speed] toValue:speed];
    [[OCSManager sharedOCSManager] triggerEvent:start];
    OCSEvent *stop = [[OCSEvent alloc] initDeactivation:start afterDuration:5.0f/speed];
    [[OCSManager sharedOCSManager] triggerEvent:stop];
}


@end