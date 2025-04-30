//
//  TextToSpeech.swift
//  TexttoSpeech
//
//  Created by Jordan McKnight on 4/29/25.
//


import AVFoundation

class TextToSpeech {
    private let synthesizer = AVSpeechSynthesizer()

    func speak(text: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            utterance.rate = 0.5

            DispatchQueue.main.async {
                self.synthesizer.speak(utterance)
            }
        }
    }
}
