//
//  UILabel.swift
//  Level
//
//  Created by Pratik on 07/01/22.
//

import Foundation
import UIKit

extension UILabel {
    func countAnimation(upto: Double) {
        let from: Double = text?.replacingOccurrences(of: ",", with: ".").components(separatedBy: CharacterSet.init(charactersIn: "-0123456789.").inverted).first.flatMap { Double($0) } ?? 0.0
        let steps: Int = 20
        let duration = 2.0
        let rate = duration / Double(steps)
        let diff = upto - from
        for i in 0...steps {
            DispatchQueue.main.asyncAfter(deadline: .now() + rate * Double(i)) {
                self.text = "\(from + diff * (Double(i) / Double(steps))) %"
            }
        }
    }
}

class LoadingProcess {

    let minValue: Int
    let maxValue: Int
    var currentValue: Int

    private let progressQueue = DispatchQueue(label: "ProgressView")
    private let semaphore = DispatchSemaphore(value: 1)

    init (minValue: Int, maxValue: Int) {
        self.minValue = minValue
        self.currentValue = minValue
        self.maxValue = maxValue
    }

    private func delay(stepDelayUsec: useconds_t, completion: @escaping ()->()) {
        usleep(stepDelayUsec)
        DispatchQueue.main.async {
            completion()
        }
    }

    func simulateLoading(toValue: Int, step: Int = 1, stepDelayUsec: useconds_t? = 10_000,
                         valueChanged: @escaping (_ currentValue: Int)->(),
                         completion: ((_ currentValue: Int)->())? = nil) {

        semaphore.wait()
        progressQueue.sync {
            if currentValue <= toValue && currentValue <= maxValue {
                usleep(stepDelayUsec!)
                DispatchQueue.main.async {
                    valueChanged(self.currentValue)
                    self.currentValue += step
                    self.semaphore.signal()
                    self.simulateLoading(toValue: toValue, step: step, stepDelayUsec: stepDelayUsec, valueChanged: valueChanged, completion: completion)
                }

            } else {
                self.semaphore.signal()
                completion?(currentValue)
            }
        }
    }

    func finish(step: Int = 1, stepDelayUsec: useconds_t? = 10_000,
                valueChanged: @escaping (_ currentValue: Int)->(),
                completion: ((_ currentValue: Int)->())? = nil) {
        simulateLoading(toValue: maxValue, step: step, stepDelayUsec: stepDelayUsec, valueChanged: valueChanged, completion: completion)
    }
}
