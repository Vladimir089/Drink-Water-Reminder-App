//
//  StatUIViewController.swift
//  Drink Water Reminder App
//
//  Created by Владимир Кацап on 01.03.2024.
//

import UIKit

class StatUIViewController: UIViewController {
    
    var mainView: secondView?
    var isMenuOpen = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = secondView(frame: view.frame)
        self.view = mainView
        changeStat()
        mainView?.buttonDropDownMenu?.addTarget(self, action: #selector(menuTapped), for: .touchUpInside)
        animateCircularProgressBar()
    }
    
    func animateCircularProgressBar() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        вв  
        basicAnimation.toValue = 0.7 // Пример: 70% завершено
        basicAnimation.duration = 2 // Продолжительность анимации

        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        mainView?.progressLayer.lineDashPattern = [NSNumber(value: 1), NSNumber(value: 10)] // Пример: пять точек, пять пробелов
        mainView?.progressLayer.add(basicAnimation, forKey: "progressAnimation")
    }
    
    @objc func menuTapped() {
        isMenuOpen.toggle()
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            print(1)
            // Вращаем изображение на 180 градусов, если меню открыто, и возвращаем в исходное положение, если закрыто
            self.mainView?.arrowDownImageView?.transform = self.isMenuOpen ? CGAffineTransform(rotationAngle: .pi) : .identity
        }
    }

    
    func changeStat() {
        mainView?.actionClosure = { selectedFruit in
            print("Выбрано: \(selectedFruit)")
            // Здесь вы можете выполнять дополнительные действия с выбранным фруктом
        }
    }

}




