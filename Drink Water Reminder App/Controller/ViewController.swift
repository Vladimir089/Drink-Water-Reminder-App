//
//  ViewController.swift
//  Drink Water Reminder App
//
//  Created by Владимир Кацап on 26.02.2024.
//

import UIKit

var targetDrink: Float = 3500
var dailyDrink: Float = 0
var weeklyData: [DayData] = []
var lastResetDate: Date?

class ViewController: UIViewController {
    
    var mainView: MainView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = MainView(frame: view.frame)
        self.view = mainView
        checkDaily()
        mainView?.slider?.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        addGesture()
        loadWeeklyData()
        loadTarget()
        checkResetData()
        let currentDate = Date()
        if let todayDataIndex = weeklyData.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: currentDate) }) {
            dailyDrink = weeklyData[todayDataIndex].drinkAmount
        }
        
    }
    
    
    func addWaterConsumption(_ amount: Float) {
        let currentDate = Date()
        if let todayDataIndex = weeklyData.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: currentDate) }) {
            weeklyData[todayDataIndex].drinkAmount += amount
            print(weeklyData[todayDataIndex].drinkAmount)
        } else {
            let dayData = DayData(date: currentDate, drinkAmount: amount)
            weeklyData.append(dayData)
        }
        saveWeeklyData()
    }
    
    func resetWeeklyData() {
        weeklyData = []
        lastResetDate = Date()
        UserDefaults.standard.set(lastResetDate, forKey: "LastResetDate")
        saveWeeklyData()
    }

    func loadWeeklyData() {
        if let savedData = UserDefaults.standard.data(forKey: "WeeklyData2"),
           let decodedData = try? JSONDecoder().decode([DayData].self, from: savedData) {
            weeklyData = decodedData
        } else {
            resetWeeklyData()
        }
        lastResetDate = UserDefaults.standard.object(forKey: "LastResetDate") as? Date
    }
    
    func saveWeeklyData() {
        DispatchQueue.global().async {
            if let encodedData = try? JSONEncoder().encode(weeklyData) {
                UserDefaults.standard.set(encodedData, forKey: "WeeklyData2")
            }
        }
    }
    
    func checkResetData() {
        let currentDate = Date()
        if let lastResetDate = lastResetDate,
           Calendar.current.isDate(currentDate, equalTo: lastResetDate, toGranularity: .weekOfYear) {
            loadWeeklyData()
        } else {
            resetWeeklyData()
        }
    }
    
    func checkDaily() {
        if dailyDrink > targetDrink {
            mainView?.progressView?.progressTintColor = .systemRed
        } else {
            mainView?.progressView?.progressTintColor = .white
        }
    }
    func loadTarget() {
        if let target = UserDefaults.standard.integer(forKey: "target") as? Int {
            mainView?.slider?.setValue(Float(target), animated: true)
        } else {
            mainView?.slider?.setValue(3500, animated: true)
        }
        sliderValueChanged(mainView?.slider ?? UISlider())
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        targetDrink = sender.value
        self.mainView?.targetLabel?.text = "\(Int(targetDrink)) ml"
        mainView?.progressView?.setProgress(dailyDrink / targetDrink, animated: true)
        UserDefaults.standard.set(targetDrink, forKey: "target")
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
            addWaterConsumption(50)
        case mainView?.aquaView:
            dailyDrink += 100
            addWaterConsumption(100)
        case mainView?.teaView:
            dailyDrink += 150
            addWaterConsumption(150)
        case mainView?.colaView:
            dailyDrink += 200
            addWaterConsumption(200)
        case mainView?.yogurtView:
            dailyDrink += 250
            addWaterConsumption(250)
        case mainView?.milkshakeView:
            dailyDrink += 200
            addWaterConsumption(200)
        case mainView?.juiceView:
            dailyDrink += 200
            addWaterConsumption(200)
        case mainView?.wineView:
            dailyDrink += 25
            addWaterConsumption(25)
        case mainView?.milkView:
            dailyDrink += 50
            addWaterConsumption(50)
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

