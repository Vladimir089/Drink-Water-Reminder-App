//
//  MainView.swift
//  Drink Water Reminder App
//
//  Created by Владимир Кацап on 26.02.2024.
//

import UIKit
import SnapKit

class MainView: UIView {

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
        
        
    }

}
