//
//  ViewController.swift
//  Drink Water Reminder App
//
//  Created by Владимир Кацап on 26.02.2024.
//

import UIKit
import SnapKit
import UserNotifications

var targetDrink: Float = 3500
var dailyDrink: Float = 0
var weeklyData: [DayData] = []
var lastResetDate: Date?
var viewIndex = 0
var isNotifyClick: Bool?

class ViewController: UIViewController {
    
    var secondView: ChangeCellView?
    var mainView: MainView?
    var isClick = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = MainView(frame: view.frame)
        secondView = ChangeCellView()
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
        
        mainView?.addButton?.addTarget(self, action: #selector(changeElement), for: .touchUpInside)
        mainView?.changeCellView?.changeButton?.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
        mainView?.notificationButton?.addTarget(self, action: #selector(offOnNotify), for: .touchUpInside)
        mainView?.statButton?.addTarget(self, action: #selector(nextPageStat), for: .touchUpInside)
        
        chechNotify()
    }
    
    @objc func nextPageStat() {
        let nextViewController = StatUIViewController()
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    func chechNotify() {
        if let isNot = UserDefaults.standard.object(forKey: "notify")  {
            isNotifyClick = isNot as? Bool
            if isNotifyClick == false {
                print(3)
                mainView?.notificationButton?.tintColor = .systemGray
            } 
            if isNotifyClick == true{
                mainView?.notificationButton?.tintColor = .systemGreen
                print(4)
            }
        } else {
            isNotifyClick = false // По умолчанию устанавливаем значение в false, если нет сохраненного значения
            UserDefaults.standard.set(isNotifyClick, forKey: "notify")
            mainView?.notificationButton?.tintColor = .systemGray
        }
    }

    @objc func offOnNotify() {
        chechNotify()
        let center = UNUserNotificationCenter.current()
        if isNotifyClick == false {
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                if granted {
                    let content = UNMutableNotificationContent()
                    content.title = "Notify!"
                    content.body = "Drink water!"
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3 * 60 * 60, repeats: false)
                    var dateComponents = DateComponents()
                    dateComponents.hour = 9
                    dateComponents.minute = 0
                    let fromDate = Calendar.current.date(from: dateComponents)!
                    
                    dateComponents.hour = 22
                    let toDate = Calendar.current.date(from: dateComponents)!
                    
                    let request = UNNotificationRequest(identifier: "PeriodicNotification", content: content, trigger: trigger)
                    
                    center.add(request) { (error) in
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        } else {
                            print("Periodic notification scheduled")
                        }
                    }
                    
                } else {
                    print("Permission for notifications not granted")
                }
            }
            isNotifyClick = true
            UserDefaults.standard.set(isNotifyClick, forKey: "notify")
            print(1)
            print(isNotifyClick)
            chechNotify()
            return
        }
        if isNotifyClick == true {
            print(2)
            center.removePendingNotificationRequests(withIdentifiers: ["PeriodicNotification"])
            isNotifyClick = false
            UserDefaults.standard.set(isNotifyClick, forKey: "notify")
            print(isNotifyClick)
            chechNotify()
            return
        }
    }
    
    @objc func saveButton() {
        let main = mainView?.changeCellView
        
        if main?.nameTextField?.text == nil || main?.mlTextField?.text == nil || main?.imageSet == nil {
            return
        }
        var components = mainView?.elements
        let ml = Int(main?.mlTextField?.text ?? "1")
        components?[viewIndex].imageElement = main?.imageSet ?? "aqua"
        components?[viewIndex].mililiter = ml ?? 1
        components?[viewIndex].note = main?.nameTextField?.text ?? "text"
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(components)
            UserDefaults.standard.set(data, forKey: "arrayComponents")
        } catch {
            print("Error encoding elements: \(error.localizedDescription)")
        }
        
        
        
        loadView()
        viewDidLoad()
        
        UIView.animate(withDuration: 0.7) { [self] in
            self.mainView?.changeCellView?.alpha = 0
            self.mainView?.addButton?.isEnabled = true
            self.mainView?.okImageView?.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.7) { [self] in
                self.mainView?.okImageView?.alpha = 0
            }
        }
    }
    
    @objc func changeElement() {
        UIView.animate(withDuration: 0.5) {
            self.mainView?.selectLabel?.alpha = 1.0
            self.mainView?.centerView?.layer.borderColor = UIColor.systemGreen.cgColor
            self.mainView?.centerView?.layer.borderWidth = 2
            self.isClick = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            UIView.animate(withDuration: 0.5) {
                self.mainView?.selectLabel?.alpha = 0.0
                self.mainView?.centerView?.layer.borderColor = UIColor.clear.cgColor
                self.mainView?.centerView?.layer.borderWidth = 0
                self.isClick = false
            }
        }
        
        return
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
            print(weeklyData)
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
        let elements = mainView?.elements
        guard let tappedView = sender.view else { return }
        switch tappedView {
        case mainView?.coffeeView:
            guard !checkIsClick(index: 0) else { return }
            dailyDrink += Float(elements?[0].mililiter ?? 0)
            addWaterConsumption(Float(elements?[0].mililiter ?? 0))
        case mainView?.aquaView:
            guard !checkIsClick(index: 1) else { return }
            dailyDrink += Float(elements?[1].mililiter ?? 0)
            addWaterConsumption(Float(elements?[1].mililiter ?? 0))
        case mainView?.teaView:
            guard !checkIsClick(index: 2) else { return }
            dailyDrink += Float(elements?[2].mililiter ?? 0)
            addWaterConsumption(Float(elements?[2].mililiter ?? 0))
        case mainView?.colaView:
            guard !checkIsClick(index: 3) else { return }
            dailyDrink += Float(elements?[3].mililiter ?? 0)
            addWaterConsumption(Float(elements?[3].mililiter ?? 0))
        case mainView?.yogurtView:
            guard !checkIsClick(index: 4) else { return }
            dailyDrink += Float(elements?[4].mililiter ?? 0)
            addWaterConsumption(Float(elements?[4].mililiter ?? 0))
        case mainView?.milkshakeView:
            guard !checkIsClick(index: 5) else { return }
            dailyDrink += Float(elements?[5].mililiter ?? 0)
            addWaterConsumption(Float(elements?[5].mililiter ?? 0))
        case mainView?.juiceView:
            guard !checkIsClick(index: 6) else { return }
            dailyDrink += Float(elements?[6].mililiter ?? 0)
            addWaterConsumption(Float(elements?[6].mililiter ?? 0))
        case mainView?.wineView:
            guard !checkIsClick(index: 7) else { return }
            dailyDrink += Float(elements?[7].mililiter ?? 0)
            addWaterConsumption(Float(elements?[7].mililiter ?? 0))
        case mainView?.milkView:
            guard !checkIsClick(index: 8) else { return }
            dailyDrink += Float(elements?[8].mililiter ?? 0)
            addWaterConsumption(Float(elements?[8].mililiter ?? 0))
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
        
        
        func checkIsClick(index: Int) -> Bool {
            if isClick == true {
                UIView.animate(withDuration: 0.3) {
                    self.mainView?.changeCellView?.alpha = 1
                    self.mainView?.addButton?.isEnabled = false
                }
                viewIndex = index
                isClick = false
                return true
            } else {
                return false
            }
            
        }
        
    }
    
    
    
    
    
}

