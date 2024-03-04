//
//  StatUIViewController.swift
//  Drink Water Reminder App
//
//  Created by Владимир Кацап on 01.03.2024.
//

import UIKit

var countDay: Float?

class StatUIViewController: UIViewController {
    
    var mainView: secondView?
    var isMenuOpen = false
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = secondView(frame: view.frame)
        self.view = mainView
        changeStat(isMenuOpen: isMenuOpen)
    }
    		
    func animateCircularProgressBar(count: Float) {
        //сделать так чтобы по дефолту стоял Today
        let formetter = NumberFormatter()
        formetter.maximumFractionDigits = 1
        mainView?.labelProcent?.text = "\(String(format: "%.1f", floor((count/targetDrink)*100)))%"
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = (count/targetDrink)
        basicAnimation.duration = 2 // Продолжительность анимации
        mainView?.remainingLabel?.text = "\(Int(count)) ml"
        mainView?.targetLabel?.text = "\(Int(targetDrink)) ml"
        print(count)
        print(targetDrink)
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        mainView?.progressLayer.lineDashPattern = [NSNumber(value: 1), NSNumber(value: 10)]
        mainView?.progressLayer.add(basicAnimation, forKey: "progressAnimation")
    }
    
    
    
    

    
    func changeStat(isMenuOpen: Bool) {
        var i: Float = 0
        
        if isMenuOpen == false {
            if weeklyData.count > 0 {
                i = weeklyData[0].drinkAmount
                self.animateCircularProgressBar(count: i)
                self.isMenuOpen = true
            }
        }
        
        mainView?.actionClosure = { selectedFruit in
            print("Выбрано: \(selectedFruit)")
            switch selectedFruit {
            case "Today":
                if weeklyData.count > 0 {
                    i = weeklyData[0].drinkAmount
                    self.animateCircularProgressBar(count: i)
                }
            case "Yesterday":
                if weeklyData.count > 1 {
                    i = weeklyData[1].drinkAmount
                    self.animateCircularProgressBar(count: i)
                }
            case "2 days ago":
                if weeklyData.count > 2 {
                    i = weeklyData[2].drinkAmount
                    self.animateCircularProgressBar(count: i)
                }
            case "3 days ago":
                if weeklyData.count > 3 {
                    i = weeklyData[3].drinkAmount
                    self.animateCircularProgressBar(count: i)
                }
            case "4 days ago":
                if weeklyData.count > 4 {
                    i = weeklyData[4].drinkAmount
                    self.animateCircularProgressBar(count: i)
                }
            case "5 days ago":
                if weeklyData.count > 5 {
                    i = weeklyData[5].drinkAmount
                    self.animateCircularProgressBar(count: i)
                }
            case "6 days ago":
                if weeklyData.count > 6 {
                    i = weeklyData[6].drinkAmount
                    self.animateCircularProgressBar(count: i)
                }
            default:
                return
            }
        }
       
    }
    
    

}




