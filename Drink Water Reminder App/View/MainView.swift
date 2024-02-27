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
    var centerView: UIView?
    var coffeeView, aquaView, teaView, colaView, yogurtView, milkshakeView, juiceView, wineView, milkView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        createComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createComponents() {
        
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
        
        //MARK: -Center view
        
        centerView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 236/255, green: 250/255, blue: 242/255, alpha: 1)
            view.layer.cornerRadius = 15
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.15
            view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
            
            view.layer.shadowRadius = 10
            return view
        }()
        addSubview(centerView ?? UIView())
        
        centerView?.snp.makeConstraints({ make in
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(450)
            make.top.equalTo(slider?.snp.bottom ?? UISlider()).inset(-30)
        })
        
        
        
        let separatorOneVertical: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 112/255, green: 234/255, blue: 146/255, alpha: 0.25)
            return view
        }()
        centerView?.addSubview(separatorOneVertical)
        separatorOneVertical.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(1)
            make.centerX.equalToSuperview().offset(-55)
            
        }
        let separatorTwoVertical: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 112/255, green: 234/255, blue: 146/255, alpha: 0.25)
            return view
        }()
        centerView?.addSubview(separatorTwoVertical)
        separatorTwoVertical.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(1)
            make.centerX.equalToSuperview().offset(+55)
            
        }
        
        let separatorOneHorizontal: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 112/255, green: 234/255, blue: 146/255, alpha: 0.25)
            return view
        }()
        centerView?.addSubview(separatorOneHorizontal)
        separatorOneHorizontal.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.centerY.equalToSuperview().offset(+80)
            
        }
        
        let separatorTwoHorizontal: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 112/255, green: 234/255, blue: 146/255, alpha: 0.25)
            return view
        }()
        centerView?.addSubview(separatorTwoHorizontal)
        separatorTwoHorizontal.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.centerY.equalToSuperview().offset(-80)
            
        }
        
        coffeeView = {
            let view = UIView()
            view.backgroundColor = .clear
            let image = UIImageView(image: UIImage(named: "coffee"))
            view.addSubview(image)
            image.tintColor = .systemGreen
            let labelML = UILabel()
            labelML.text = "50 ml"
            labelML.textColor = UIColor(red: 128/255, green: 136/255, blue: 144/255, alpha: 1)
            labelML.font = .systemFont(ofSize: 15, weight: .medium)
            view.addSubview(labelML)
            image.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-20)
                make.height.width.equalTo(50)
            }
            labelML.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(image.snp.bottom).inset(-10)
            }
            
            let labelCoffee = UILabel()
            labelCoffee.textColor = .separator
            labelCoffee.font = .systemFont(ofSize: 15, weight: .light)
            labelCoffee.text = "Coffee"
            view.addSubview(labelCoffee)
            labelCoffee.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(labelML.snp.bottom)
            }
            
            
            return view
        }()
        centerView?.addSubview(coffeeView ?? UIView())
        coffeeView?.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.bottom.equalTo(separatorTwoHorizontal.snp.top)
            make.right.equalTo(separatorOneVertical.snp.left)
        }
        
        
        aquaView = {
            let view = UIView()
            view.backgroundColor = .clear
            let image = UIImageView(image: UIImage(named: "aqua"))
            view.addSubview(image)
            image.tintColor = .systemGreen
            let labelML = UILabel()
            labelML.text = "100 ml"
            labelML.textColor = UIColor(red: 128/255, green: 136/255, blue: 144/255, alpha: 1)
            labelML.font = .systemFont(ofSize: 15, weight: .medium)
            view.addSubview(labelML)
            image.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-20)
                make.height.width.equalTo(50)
            }
            labelML.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(image.snp.bottom).inset(-10)
            }
            
            let labelCoffee = UILabel()
            labelCoffee.textColor = .separator
            labelCoffee.font = .systemFont(ofSize: 15, weight: .light)
            labelCoffee.text = "Aqua"
            view.addSubview(labelCoffee)
            labelCoffee.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(labelML.snp.bottom)
            }
            
            
            return view
        }()
        centerView?.addSubview(aquaView ?? UIView())
        aquaView?.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(separatorTwoHorizontal.snp.top)
            make.left.equalTo(separatorOneVertical.snp.right)
            make.right.equalTo(separatorTwoVertical.snp.left)
        }
        
        
        teaView = {
            let view = UIView()
            view.backgroundColor = .clear
            let image = UIImageView(image: UIImage(named: "tea"))
            view.addSubview(image)
            image.tintColor = .systemGreen
            let labelML = UILabel()
            labelML.text = "150 ml"
            labelML.textColor = UIColor(red: 128/255, green: 136/255, blue: 144/255, alpha: 1)
            labelML.font = .systemFont(ofSize: 15, weight: .medium)
            view.addSubview(labelML)
            image.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-20)
                make.height.width.equalTo(50)
            }
            labelML.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(image.snp.bottom).inset(-10)
            }
            
            let labelCoffee = UILabel()
            labelCoffee.textColor = .separator
            labelCoffee.font = .systemFont(ofSize: 15, weight: .light)
            labelCoffee.text = "Tea"
            view.addSubview(labelCoffee)
            labelCoffee.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(labelML.snp.bottom)
            }
            
            
            return view
        }()
        centerView?.addSubview(teaView ?? UIView())
        teaView?.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.left.equalTo(separatorTwoVertical.snp.right)
            make.bottom.equalTo(separatorTwoHorizontal.snp.top)
            
        }
        
        
        colaView = {
            let view = UIView()
            view.backgroundColor = .clear
            let image = UIImageView(image: UIImage(named: "cola"))
            view.addSubview(image)
            image.tintColor = .systemGreen
            let labelML = UILabel()
            labelML.text = "200 ml"
            labelML.textColor = UIColor(red: 128/255, green: 136/255, blue: 144/255, alpha: 1)
            labelML.font = .systemFont(ofSize: 15, weight: .medium)
            view.addSubview(labelML)
            image.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-20)
                make.height.equalTo(55)
                make.width.equalTo(55)
            }
            labelML.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(image.snp.bottom).inset(-10)
            }
            
            let labelCoffee = UILabel()
            labelCoffee.textColor = .separator
            labelCoffee.font = .systemFont(ofSize: 15, weight: .light)
            labelCoffee.text = "Cola"
            view.addSubview(labelCoffee)
            labelCoffee.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(labelML.snp.bottom)
            }
            
            
            return view
        }()
        centerView?.addSubview(colaView ?? UIView())
        colaView?.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(separatorTwoHorizontal.snp.bottom)
            make.bottom.equalTo(separatorOneHorizontal.snp.top)
            make.right.equalTo(separatorOneVertical.snp.left)
            
        }
        
        yogurtView = {
            let view = UIView()
            view.backgroundColor = .clear
            let image = UIImageView(image: UIImage(named: "Yogurt"))
            view.addSubview(image)
            image.tintColor = .systemGreen
            let labelML = UILabel()
            labelML.text = "250 ml"
            labelML.textColor = UIColor(red: 128/255, green: 136/255, blue: 144/255, alpha: 1)
            labelML.font = .systemFont(ofSize: 15, weight: .medium)
            view.addSubview(labelML)
            image.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-20)
                make.height.equalTo(55)
                make.width.equalTo(55)
            }
            labelML.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(image.snp.bottom).inset(-10)
            }
            
            let labelCoffee = UILabel()
            labelCoffee.textColor = .separator
            labelCoffee.font = .systemFont(ofSize: 15, weight: .light)
            labelCoffee.text = "Yogurt"
            view.addSubview(labelCoffee)
            labelCoffee.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(labelML.snp.bottom)
            }
            
            
            return view
        }()
        centerView?.addSubview(yogurtView ?? UIView())
        yogurtView?.snp.makeConstraints { make in
            make.left.equalTo(separatorOneVertical.snp.right)
            make.top.equalTo(separatorTwoHorizontal.snp.bottom)
            make.bottom.equalTo(separatorOneHorizontal.snp.top)
            make.right.equalTo(separatorTwoVertical.snp.left)
            
        }
        
        
        
        milkshakeView = {
            let view = UIView()
            view.backgroundColor = .clear
            let image = UIImageView(image: UIImage(named: "cocktail"))
            view.addSubview(image)
            image.tintColor = .systemGreen
            let labelML = UILabel()
            labelML.text = "200 ml"
            labelML.textColor = UIColor(red: 128/255, green: 136/255, blue: 144/255, alpha: 1)
            labelML.font = .systemFont(ofSize: 15, weight: .medium)
            view.addSubview(labelML)
            image.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-20)
                make.height.equalTo(55)
                make.width.equalTo(55)
            }
            labelML.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(image.snp.bottom).inset(-10)
            }
            
            let labelCoffee = UILabel()
            labelCoffee.textColor = .separator
            labelCoffee.font = .systemFont(ofSize: 15, weight: .light)
            labelCoffee.text = "Milkshake"
            view.addSubview(labelCoffee)
            labelCoffee.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(labelML.snp.bottom)
            }
            
            
            return view
        }()
        centerView?.addSubview(milkshakeView ?? UIView())
        milkshakeView?.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalTo(separatorTwoHorizontal.snp.bottom)
            make.bottom.equalTo(separatorOneHorizontal.snp.top)
            make.left.equalTo(separatorTwoVertical.snp.right)
        }
        
        juiceView = {
            let view = UIView()
            view.backgroundColor = .clear
            let image = UIImageView(image: UIImage(named: "juice"))
            view.addSubview(image)
            image.tintColor = .systemGreen
            let labelML = UILabel()
            labelML.text = "200 ml"
            labelML.textColor = UIColor(red: 128/255, green: 136/255, blue: 144/255, alpha: 1)
            labelML.font = .systemFont(ofSize: 15, weight: .medium)
            view.addSubview(labelML)
            image.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-25)
                make.height.equalTo(55)
                make.width.equalTo(55)
            }
            labelML.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(image.snp.bottom).inset(-10)
            }
            
            let labelCoffee = UILabel()
            labelCoffee.textColor = .separator
            labelCoffee.font = .systemFont(ofSize: 15, weight: .light)
            labelCoffee.text = "Juice"
            view.addSubview(labelCoffee)
            labelCoffee.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(labelML.snp.bottom)
            }
            
            
            return view
        }()
        centerView?.addSubview(juiceView ?? UIView())
        juiceView?.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(separatorOneHorizontal.snp.bottom)
            make.bottom.equalToSuperview()
            make.right.equalTo(separatorOneVertical.snp.left)
        }
        
        wineView = {
            let view = UIView()
            view.backgroundColor = .clear
            let image = UIImageView(image: UIImage(named: "wine"))
            view.addSubview(image)
            image.tintColor = .systemGreen
            let labelML = UILabel()
            labelML.text = "25 ml"
            labelML.textColor = UIColor(red: 128/255, green: 136/255, blue: 144/255, alpha: 1)
            labelML.font = .systemFont(ofSize: 15, weight: .medium)
            view.addSubview(labelML)
            image.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-25)
                make.height.equalTo(55)
                make.width.equalTo(55)
            }
            labelML.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(image.snp.bottom).inset(-10)
            }
            
            let labelCoffee = UILabel()
            labelCoffee.textColor = .separator
            labelCoffee.font = .systemFont(ofSize: 15, weight: .light)
            labelCoffee.text = "Wine"
            view.addSubview(labelCoffee)
            labelCoffee.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(labelML.snp.bottom)
            }
            
            
            return view
        }()
        centerView?.addSubview(wineView ?? UIView())
        wineView?.snp.makeConstraints { make in
            make.left.equalTo(separatorOneVertical.snp.right)
            make.top.equalTo(separatorOneHorizontal.snp.bottom)
            make.bottom.equalToSuperview()
            make.right.equalTo(separatorTwoVertical.snp.left)
        }
        
        
        milkView = {
            let view = UIView()
            view.backgroundColor = .clear
            let image = UIImageView(image: UIImage(named: "milk"))
            view.addSubview(image)
            image.tintColor = .systemGreen
            let labelML = UILabel()
            labelML.text = "50 ml"
            labelML.textColor = UIColor(red: 128/255, green: 136/255, blue: 144/255, alpha: 1)
            labelML.font = .systemFont(ofSize: 15, weight: .medium)
            view.addSubview(labelML)
            image.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-25)
                make.height.equalTo(55)
                make.width.equalTo(55)
            }
            labelML.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(image.snp.bottom).inset(-10)
            }
            
            let labelCoffee = UILabel()
            labelCoffee.textColor = .separator
            labelCoffee.font = .systemFont(ofSize: 15, weight: .light)
            labelCoffee.text = "Milk"
            view.addSubview(labelCoffee)
            labelCoffee.snp.makeConstraints { make in
                make.centerX.equalTo(image.snp.centerX)
                make.top.equalTo(labelML.snp.bottom)
            }
            
            
            return view
        }()
        centerView?.addSubview(milkView ?? UIView())
        milkView?.snp.makeConstraints { make in
            make.left.equalTo(separatorTwoVertical.snp.right)
            make.top.equalTo(separatorOneHorizontal.snp.bottom)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            
            
        }
        
    }

}
