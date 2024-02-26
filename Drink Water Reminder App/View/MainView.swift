//
//  MainView.swift
//  Drink Water Reminder App
//
//  Created by Владимир Кацап on 26.02.2024.
//

import UIKit
import SnapKit

class MainView: UIView {

    //MARK: -Elements
    
    var dailyLabel: UILabel?
    var targetLabel: UILabel?
    var progressView: UIProgressView?
    var slider: UISlider?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        createComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createComponents() {
        
        //MARK: -Background
        
        let topBackground: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 107/255, green: 226/255, blue: 140/255, alpha: 1)
            return view
        }()
        addSubview(topBackground)
        topBackground.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(frame.height/2)
        }
        
        let corneredView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 112/255, green: 234/255, blue: 146/255, alpha: 1)
            view.layer.cornerRadius = 250
            return view
        }()
        addSubview(corneredView)
        corneredView.snp.makeConstraints { make in
            make.width.height.equalTo(500)
            make.right.equalToSuperview().inset(-270)
            make.bottom.equalToSuperview().inset(frame.height / 2.4)
            
        }
        
        //MARK: -Other
        
        let dailyDrinkTargetLabel: UILabel = {
            let label = UILabel()
            label.text = "Daily Drink Target"
            label.font = .systemFont(ofSize: 20, weight: .light)
            label.textColor  = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
            return label
        }()
        addSubview(dailyDrinkTargetLabel)
        dailyDrinkTargetLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(70)
        }
        
    dailyLabel = {
        let label = UILabel()
        label.text = "\(Int(dailyDrink))"
        label.textColor = .white
        label.font = .systemFont(ofSize: 50, weight: .medium)
        return label
    }()
        addSubview(dailyLabel ?? UILabel())
        dailyLabel?.snp.makeConstraints({ make in
            make.top.equalTo(dailyDrinkTargetLabel).inset(20)
            make.left.equalTo(dailyDrinkTargetLabel)
        })
        
        let separatorLabel: UILabel = {
            let label = UILabel()
            label.text = "/"
            label.textColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
            label.font = .systemFont(ofSize: 20, weight: .medium)
            return label
        }()
        addSubview(separatorLabel)
        separatorLabel.snp.makeConstraints { make in
            make.right.equalTo(dailyLabel!).inset(-10)
            make.bottom.equalTo(dailyLabel!).inset(12)
        }
        
        targetLabel = {
            let label = UILabel()
            label.text = "\(Int(targetDrink)) ml"
            label.textColor = .white
            label.font = .systemFont(ofSize: 20, weight: .light)
            return label
        }()
        addSubview(targetLabel ?? UILabel())
        targetLabel?.snp.makeConstraints({ make in
            make.left.equalTo(separatorLabel).inset(10)
            make.bottom.equalTo(separatorLabel).inset(-2)
        })
        
        progressView = {
            let progress = UIProgressView(progressViewStyle: .bar)
            progress.trackTintColor = UIColor(red: 127/255, green: 243/255, blue: 166/255, alpha: 1)
            progress.layer.cornerRadius = 5
            progress.layer.sublayers?[1].cornerRadius = 5
            progress.clipsToBounds = true
            progress.subviews[1].clipsToBounds = true
            progress.setProgress(dailyDrink / targetDrink, animated: true)
            return progress
        }()

        addSubview(progressView ?? UIProgressView())
        addSubview(progressView ?? UIProgressView())
        progressView?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(10)
            make.top.equalTo(separatorLabel.snp.bottom).inset(-40)
        })
        
        slider = {
            let slider = UISlider()
            slider.maximumValue = 5000
            slider.value = targetDrink
            slider.minimumValue = 0
            slider.tintColor = .clear
            slider.maximumTrackTintColor = .clear
            slider.setThumbImage(UIImage(named: "triangle.fill"), for: .normal)
            return slider
        }()
        addSubview(slider ?? UISlider())
        slider?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(20)
            make.top.equalTo(progressView!.snp.bottom)

        })
    }

}
