//
//  ViewController.swift
//  moviereview
//
//  Created by Haseeb on 6/21/18.
//  Copyright © 2018 haseeb. All rights reserved.
//

import UIKit
import QuartzCore
import CoreML
import NaturalLanguage

enum Sentiment{
    case Positive
    case Negative
    case Neutral
    case Unknown
}

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var comment: UITextView!
    @IBOutlet weak var emotion: UIButton!

    let modelURL = Bundle.main.url(forResource: "moviereview", withExtension: "mlmodelc")

    override func viewDidLoad() {
        super.viewDidLoad()

        comment.delegate = self
        comment.layer.borderColor = UIColor.gray.cgColor
        comment.layer.borderWidth = 3

        emotion.setTitle("Emotion", for: .normal)
        emotion.layer.backgroundColor = UIColor.lightText.cgColor

        print("Model file ::: \(String(describing: modelURL))")
    }

    //Textview delegate method
    func textViewDidChange(_ textView: UITextView) {
        if let feedback = textView.text{
            let sentiment:Sentiment = predictSentiment(feedback: feedback.lowercased())

            switch sentiment {
            case .Positive:
                //print("Positive feedback")
                self.emotion.backgroundColor = UIColor.green
                self.emotion.setTitle("\u{1f600}",for: .normal)
            case .Negative:
                print("Negative feedback")
                self.emotion.backgroundColor = UIColor.red
                self.emotion.setTitle("\u{1f614}",for: .normal)
            case .Neutral:
                print("Neutral feedback")
                self.emotion.backgroundColor = UIColor.orange
                self.emotion.setTitle("\u{1f928}",for: .normal)
            case .Unknown:
                print("Unseen input the system will add this input to the training model")
                self.emotion.backgroundColor = UIColor.gray
                self.emotion.setTitle("Analyzing...",for: .normal)
                self.trainNewData(newComment: feedback)
            }
        }

    }

    func predictSentiment( feedback: String ) -> Sentiment{
        var sentiment:Sentiment = .Unknown

        if feedback.count > 5 {
            do {
                let model = try NLModel(contentsOf: modelURL!)
                let label = model.predictedLabel(for: feedback)

                if label == "positive"{
                    sentiment = .Positive
                }else if label == "negative"{
                    sentiment = .Negative
                }else{
                    sentiment = .Neutral
                }

            }catch(let error){
                print (error)
            }
        }

        return sentiment
    }

    func trainNewData( newComment: String ){

    }

}

