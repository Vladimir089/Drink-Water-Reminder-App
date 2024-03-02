//
//  ProgressView.swift
//  Drink Water Reminder App
//
//  Created by Владимир Кацап on 02.03.2024.
//

import UIKit

class ProgressView: UIView {

    var startProgress: Int = 0 // Начальная точка прогресса
        var totalSegments: Int = 10 // Общее количество отрезков
        var currentProgress: Int = 5 // Текущий прогресс
        
        override func draw(_ rect: CGRect) {
            super.draw(rect)
            
            // Определяем параметры для отрисовки отрезков прогресса
            let segmentWidth = rect.width / CGFloat(totalSegments)
            let segmentHeight = rect.height / 3
            let padding = CGFloat(5)
            
            // Определяем стиль отрезков прогресса
            let progressColor = UIColor.green.cgColor
            let remainingColor = UIColor.gray.cgColor
            
            // Создаем контекст для отрисовки
            guard let context = UIGraphicsGetCurrentContext() else { return }
            
            // Отрисовываем отрезки прогресса
            for i in 0..<totalSegments {
                let startX = CGFloat(i) * segmentWidth
                let startY = rect.height / 2 - segmentHeight / 2
                
                let segmentRect = CGRect(x: startX, y: startY, width: segmentWidth - padding, height: segmentHeight)
                
                if i < startProgress || i >= startProgress + currentProgress {
                    // Отрисовываем серый отрезок для непрогрессируемой части
                    context.setFillColor(remainingColor)
                    context.fill(segmentRect)
                } else {
                    // Отрисовываем зеленый отрезок для прогрессируемой части
                    context.setFillColor(progressColor)
                    context.fill(segmentRect)
                }
            }
        }

}
