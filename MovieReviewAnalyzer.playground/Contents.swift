import Foundation
import Cocoa
import CreateML
import NaturalLanguage



let trainingData = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/haseeb/Desktop/WWDC18-Highlights-Demo/MovieReviewEmotionAnalysis/moviereviewdata.json"))
let model = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "label")
print( "Training metrics ::: \(model.trainingMetrics)")
print( "Validation metrics :::: \(model.validationMetrics)")
try model.write(to: URL(fileURLWithPath: "/Users/haseeb/Desktop/WWDC18-Highlights-Demo/MovieReviewEmotionAnalysis/moviereview.mlmodel"))

//if let modelURL = Bundle.main.url(forResource: "moviereview", withExtension: "mlmodelc"){
//    let model = try NLModel(contentsOf: modelURL)
//    let label = model.predictedLabel(for: "The movie was Ok")
//    print(label)
//}
