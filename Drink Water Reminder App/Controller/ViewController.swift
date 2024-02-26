//
//  ViewController.swift
//  Drink Water Reminder App
//
//  Created by Владимир Кацап on 26.02.2024.
//

import UIKit

var targetDrink: Float = 3500
var dailyDrink: Float = 2000

class ViewController: UIViewController {
    
    var mainView: MainView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = MainView(frame: view.frame)
        self.view = mainView
        mainView?.slider?.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        targetDrink = sender.value
        self.mainView?.targetLabel?.text = "\(Int(targetDrink)) ml"
        mainView?.progressView?.setProgress(dailyDrink / targetDrink, animated: true)
        if dailyDrink > targetDrink {
            mainView?.progressView?.progressTintColor = .systemRed
        } else {
            mainView?.progressView?.progressTintColor = .white
        }
    }
    
    
}

