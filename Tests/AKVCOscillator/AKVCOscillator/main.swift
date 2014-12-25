//
//  main.swift
//  AudioKit
//
//  Auto-generated on 12/24/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

import Foundation

class Instrument : AKInstrument {

    override init() {
        super.init()
        
        let pulseWidthLine = AKLinearControl(firstPoint: 0.ak, secondPoint: 1.ak, durationBetweenPoints: 10.ak)
        connect(pulseWidthLine)

        let frequencyLine = AKLinearControl(firstPoint: 110.ak, secondPoint: 880.ak, durationBetweenPoints: 10.ak)
        connect(frequencyLine)

        
        let operation = AKVCOscillator()
        operation.waveformType = AKVCOscillatorWaveformType.SquarePWM
        operation.pulseWidth = pulseWidthLine
        operation.frequency = frequencyLine
        connect(operation)

        connect(AKAudioOutput(audioSource:operation))
    }
}


// Set Up
let instrument = Instrument()
AKOrchestra.addInstrument(instrument)
AKManager.sharedManager().isLogging = true
AKOrchestra.testForDuration(10)

instrument.play()

while(AKManager.sharedManager().isRunning) {} //do nothing
println("Test complete!")