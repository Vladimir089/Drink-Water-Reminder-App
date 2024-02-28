//
//  DailyDrinkData.swift
//  Drink Water Reminder App
//
//  Created by Владимир Кацап on 28.02.2024.
//

import Foundation


struct DayData: Codable {
    var date: Date
    var drinkAmount: Float
}



struct Element: Codable {
    var imageElement: String
    var mililiter: Int
    var note: String
}
