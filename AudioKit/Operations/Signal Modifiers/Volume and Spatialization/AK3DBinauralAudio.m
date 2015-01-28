//
//  AK3DBinauralAudio.m
//  AudioKit
//
//  Auto-generated on 1/28/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//
//  Implementation of Csound's hrtfmove2:
//  http://www.csounds.com/manual/html/hrtfmove2.html
//

#import "AK3DBinauralAudio.h"
#import "AKManager.h"

@implementation AK3DBinauralAudio
{
    AKParameter * _input;
}

- (instancetype)initWithInput:(AKParameter *)input
                      azimuth:(AKParameter *)azimuth
                    elevation:(AKParameter *)elevation
{
    self = [super initWithString:[self operationName]];
    if (self) {
        _input = input;
        _azimuth = azimuth;
        _elevation = elevation;
    }
    return self;
}

- (instancetype)initWithInput:(AKParameter *)input
{
    self = [super initWithString:[self operationName]];
    if (self) {
        _input = input;
        // Default Values
        _azimuth = akp(0);
        _elevation = akp(0);
    }
    return self;
}

+ (instancetype)WithInput:(AKParameter *)input
{
    return [[AK3DBinauralAudio alloc] initWithInput:input];
}

- (void)setOptionalAzimuth:(AKParameter *)azimuth {
    _azimuth = azimuth;
}
- (void)setOptionalElevation:(AKParameter *)elevation {
    _elevation = elevation;
}

- (NSString *)stringForCSD {
    NSMutableString *csdString = [[NSMutableString alloc] init];
    
    // Constant Values
    NSString *leftFile = [[NSBundle mainBundle] pathForResource:@"hrtf-44100-left" ofType:@"dat"];
    if (!leftFile) {
        leftFile = @"CsoundLib64.framework/Sounds/hrtf-44100-left.dat";
    }
    NSString *rightFile = [[NSBundle mainBundle] pathForResource:@"hrtf-44100-right" ofType:@"dat"];
    if (!rightFile) {
        rightFile = @"CsoundLib64.framework/Sounds/hrtf-44100-right.dat";
    }

    [csdString appendFormat:@"%@ hrtfmove2 ", self];

    if ([_input class] == [AKAudio class]) {
        [csdString appendFormat:@"%@, ", _input];
    } else {
        [csdString appendFormat:@"AKAudio(%@), ", _input];
    }

    if ([_azimuth class] == [AKControl class]) {
        [csdString appendFormat:@"%@, ", _azimuth];
    } else {
        [csdString appendFormat:@"AKControl(%@), ", _azimuth];
    }

    if ([_elevation class] == [AKControl class]) {
        [csdString appendFormat:@"%@, ", _elevation];
    } else {
        [csdString appendFormat:@"AKControl(%@), ", _elevation];
    }
    
    [csdString appendFormat:@"\"%@\", \"%@\"", leftFile, rightFile];
    return csdString;
}

@end
