//
//  ViewController.swift
//  Drink Water Reminder App
//
//  Created by Владимир Кацап on 26.02.2024.
//

import UIKit

class ViewController: UIViewController {

    var mainView: MainView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = MainView(frame: view.frame)
        self.view = mainView
    }


}

