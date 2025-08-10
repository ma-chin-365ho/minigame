//
//  VoiceRecog.swift
//  Shiritori
//
//  Created by 佐藤優成 on R 6/04/07.
//

import Foundation
import AVFAudio
import Speech



class VoiceRecog {
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ja_JP"))
    let recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

    init() {
        self.askPerm()
    }
    
    private func askPerm() {
        // Make the authorization request
        SFSpeechRecognizer.requestAuthorization { authStatus in

           // The authorization status results in changes to the
           // app’s interface, so process the results on the app’s
           // main queue.
           OperationQueue.main.addOperation {
              switch authStatus {
                 case .authorized:
                    print("User authorized access to speech recognition")
                 case .denied:
                    print("User denied access to speech recognition")
                 case .restricted:
                    print("Speech recognition restricted on this device")
                 case .notDetermined:
                    print("Speech recognition not yet authorized")
                 @unknown default:
                    print("Speech recognition Unknown")
              }
           }
        }
    }
    
    func listen() -> String? {
        // recognitionRequest.contextualStrings = ["特定の用語1", "特定の用語2"]
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(.record, mode: .measurement, options: [])
        try! audioSession.setActive(true, options: .notifyOthersOnDeactivation)

        let node = self.audioEngine.inputNode
        let format = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: format) { (buffer, time) in
            self.recognitionRequest.append(buffer)
        }
        self.recognitionRequest.requiresOnDeviceRecognition = true
        var recogResult : String? = nil

        self.audioEngine.prepare()
        do {
            try self.audioEngine.start()
        } catch {
            print("エラーが発生しました：\(error.localizedDescription)")
        }
        
        print("A")
        var recognitionTask = self.speechRecognizer?.recognitionTask(with: self.recognitionRequest) { result, error in
            var isFinal = false
            
            print("B")
            if let error = error {
                print("音声認識中にエラーが発生しました：\(error.localizedDescription)")
            } else if let result = result {
                recogResult = result.bestTranscription.formattedString
                print("音声認識の結果：\(result.bestTranscription.formattedString)")
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                node.removeTap(onBus: 0)
                
                // self.recognitionRequest = nil
                // recognitionTask = nil
            }
        }
        print("C")

        return recogResult
    }
    
}
