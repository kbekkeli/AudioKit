//
//  main.swift
//  AudioKit
//
//  Created by Aurelius Prochazka on 1/28/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

import Foundation

let testDuration: Float = 10.0

class Crunch : AKInstrument {
    
    var auxilliaryOutput = AKAudio()
    
    override init() {
        super.init()
        
        let crunch = AKCrunch()
        connect(crunch)
        
        auxilliaryOutput = AKAudio.globalParameter()
        assignOutput(auxilliaryOutput, to: crunch)
    }
}


class BinauralEffects : AKInstrument {

    init(input: AKAudio) {
        super.init()
        
        let azimuth = AKOscillator()
        azimuth.amplitude = 180.ak
        azimuth.frequency = 0.5.ak
        connect(azimuth)
        
        let elevation = AKLine(
            firstPoint: 0.ak,
            secondPoint: 90.ak,
            durationBetweenPoints: testDuration.ak
        )
        connect(elevation)
        
        
        let binaural_audio = AK3DBinauralAudio(input: input)
        binaural_audio.azimuth = azimuth
        binaural_audio.elevation = elevation
        connect(binaural_audio)

        connect(AKAudioOutput(stereoAudioSource:binaural_audio))
        
        resetParameter(input)
    }
}

// Set Up
let crunch = Crunch()
let fx = BinauralEffects(input: crunch.auxilliaryOutput)
AKOrchestra.addInstrument(crunch)
AKOrchestra.addInstrument(fx)
AKManager.sharedManager().isLogging = true
AKOrchestra.testForDuration(testDuration)

fx.play()

let phrase = AKPhrase()

for i in 1...40 {
    let note = AKNote()
    note.duration.setValue(0.25)
    phrase.addNote(note, atTime: Float(i-1)/4.0)
}

crunch.playPhrase(phrase)

while(AKManager.sharedManager().isRunning) {} //do nothing
println("Test complete!")
