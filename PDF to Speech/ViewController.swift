//
//  ViewController.swift
//  PDF to Speech
//
//  Created by Fahim Rahman on 21/2/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit
import AVFoundation
import PDFKit

class ViewController: UIViewController {

    let documentContent = NSMutableString()
    let url = URL(string: "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pdfToText(url: url!)
    }
    
    
    func pdfToText(url: URL) {
        
        if let pdf = PDFDocument(url: url) {
            let pageCount = pdf.pageCount
            

            for i in 5 ..< pageCount {
                guard let page = pdf.page(at: i) else { continue }
                guard let pageContent = page.string else { continue }
                documentContent.append(pageContent)
            }
            textToSpeech(document: documentContent as String)
            print(documentContent)
        }
    }

    func textToSpeech(document: String) {
        
        let utterance = AVSpeechUtterance(string: document)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.voice = AVSpeechSynthesisVoice(identifier: "")
        utterance.rate = 0.45

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
