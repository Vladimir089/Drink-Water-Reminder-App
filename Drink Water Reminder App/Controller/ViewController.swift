//
//  ViewController.swift
//  Drink Water Reminder App
//
//  Created by Владимир Кацап on 26.02.2024.
//

import UIKit

var targetDrink: Float = 3500
var dailyDrink: Float = 0

class ViewController: UIViewController {
    
    var mainView: MainView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = MainView(frame: view.frame)
        self.view = mainView
        checkDaily()
        mainView?.slider?.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        addGesture()
    }
    
    func checkDaily() {
        if dailyDrink > targetDrink {
            mainView?.progressView?.progressTintColor = .systemRed
        } else {
            mainView?.progressView?.progressTintColor = .white
        }
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        targetDrink = sender.value
        self.mainView?.targetLabel?.text = "\(Int(targetDrink)) ml"
        mainView?.progressView?.setProgress(dailyDrink / targetDrink, animated: true)
        checkDaily()
    }
    
    func addGesture() {
        let arrView = [mainView?.coffeeView, mainView?.aquaView, mainView?.teaView, mainView?.colaView, mainView?.yogurtView, mainView?.milkshakeView, mainView?.juiceView, mainView?.wineView, mainView?.milkView]
        for views in arrView {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(tapView(_:)))
            views?.addGestureRecognizer(gesture)
        }
    }
    
    @objc func tapView(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view else { return }
        
        
        switch tappedView {
        case mainView?.coffeeView:
            dailyDrink += 50
        case mainView?.aquaView:
            dailyDrink += 100
        case mainView?.teaView:
            dailyDrink += 150
        case mainView?.colaView:
            dailyDrink += 200
        case mainView?.yogurtView:
            dailyDrink += 250
        case mainView?.milkshakeView:
            dailyDrink += 200
        case mainView?.juiceView:
            dailyDrink += 200
        case mainView?.wineView:
            dailyDrink += 25
        case mainView?.milkView:
            dailyDrink += 50
        default:
            return
        }
        
        mainView?.progressView?.setProgress(dailyDrink / targetDrink, animated: true)
        mainView?.dailyLabel?.text = "\(Int(dailyDrink))"
        checkDaily()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: { [self] in
            tappedView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { (_) in
            UIView.animate(withDuration: 0.3) { [self] in
                tappedView.transform = .identity
            }
        })
        
        
            
        
    }
    
    
    
    
    
}

