//
//  secondView.swift
//  Drink Water Reminder App
//
//  Created by Владимир Кацап on 02.03.2024.
//

import UIKit

class secondView: UIView {
    
    let progressLayer = CAShapeLayer()
    let dataSource = ["Today", "Yesterday", "2 days ago", "3 days ago", "4 days ago", "5 days ago", "6 days ago"]
    var buttonDropDownMenu: UIButton?
    var actionClosure: ((String) -> Void)?
    var arrowDownImageView: UIImageView?
    var corneredBorderView: UIView?
    var labelProcent, remainingLabel, targetLabel: UILabel?
    

    override init(frame: CGRect) {
        super .init(frame: frame)
        createComp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createComp() {
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
        
        let botBackground: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
        addSubview(botBackground)
        botBackground.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topBackground.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
       
        
        let drinkReportLabel: UILabel = {
            let label = UILabel()
            label.text = "Drink Report"
            label.textColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
            label.font = .systemFont(ofSize: 20, weight: .light)
            return label
        }()
        topBackground.addSubview(drinkReportLabel)
        drinkReportLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(50)
        }
        
        //MARK: -Button Drop Down Menu
        
        var menuChildren: [UIMenuElement] = []
        for fruit in dataSource {
            menuChildren.append(UIAction(title: fruit) { [weak self] _ in
                guard let self = self else { return }
                self.actionClosure?(fruit)
            })
        }
        buttonDropDownMenu = {
            let button = UIButton()
            button.contentHorizontalAlignment = .left
            button.titleLabel?.font = .systemFont(ofSize: 40, weight: .medium)
            button.menu = UIMenu(options: .displayInline, children: menuChildren)
            button.showsMenuAsPrimaryAction = true
            button.changesSelectionAsPrimaryAction = true
            return button
        }()
        topBackground.addSubview(buttonDropDownMenu ?? UIButton())
        buttonDropDownMenu?.snp.makeConstraints({ make in
            make.height.equalTo(50)

            make.left.equalTo(drinkReportLabel.snp.left)
            make.top.equalTo(drinkReportLabel.snp.bottom).inset(-10)
        })
        
        arrowDownImageView = {
            let image = UIImage(named: "arrowtriangle.down.fill")
            let imageView = UIImageView(image: image)
            return imageView
        }()
        topBackground.addSubview(arrowDownImageView ?? UIImageView())
        arrowDownImageView?.snp.makeConstraints({ make in
            make.width.height.equalTo(18)
            make.centerY.equalTo((buttonDropDownMenu?.snp.centerY)!).offset(3)
            make.left.equalTo((buttonDropDownMenu?.snp.right)!).inset(-5)
        })
        
        let centerView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 236/255, green: 250/255, blue: 242/255, alpha: 1)
            view.layer.cornerRadius = 15
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.15
            view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
            view.layer.shadowRadius = 10
            return view
        }()
        addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo((buttonDropDownMenu?.snp.bottom)!).inset(-20)
            make.height.equalTo(350)
        }
        
        corneredBorderView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
            view.layer.cornerRadius = 100
            return view
        }()
        centerView.addSubview(corneredBorderView!)
        corneredBorderView?.snp.makeConstraints { make in
            make.height.width.equalTo(200)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(50)
        }
        
       
        
        let whiteViewOne: UIView = {
            let view = UIView()
            view.backgroundColor =  .white
            view.layer.cornerRadius = 80
            return view
        }()
        
        corneredBorderView?.addSubview(whiteViewOne)
        whiteViewOne.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(160)
        }
        
        let separatorView: UIView = {
            let view = UIView()
            view.backgroundColor =  .systemGray6
            view.layer.cornerRadius = 72.5
            return view
        }()
        
        whiteViewOne.addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(145)
        }
        
        let whiteViewTwo: UIView = {
            let view = UIView()
            view.backgroundColor =  .white
            view.layer.cornerRadius = 71.5
            return view
        }()
        
        separatorView.addSubview(whiteViewTwo)
        whiteViewTwo.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(143)
        }
        
        
        
        labelProcent = {
            let label = UILabel()
            
            label.font = .systemFont(ofSize: 30, weight: .medium)
            label.textColor = .systemGreen
            return label
        }()
        whiteViewTwo.addSubview(labelProcent ?? UILabel())
        labelProcent?.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        })
        
        
        let textTargetLabel: UILabel = {
            let label = UILabel()
            label.text = "Target"
            label.font = .systemFont(ofSize: 14, weight: .bold)
            label.textColor = .separator
            return label
        }()
        centerView.addSubview(textTargetLabel)
        textTargetLabel.snp.makeConstraints { make in
            make.top.equalTo((corneredBorderView?.snp.bottom)!).inset(-20)
            make.right.equalTo((corneredBorderView?.snp.right)!)
        }
        
        let textRemainingLabel: UILabel = {
            let label = UILabel()
            label.text = "Remaining"
            label.font = .systemFont(ofSize: 14, weight: .bold)
            label.textColor = .separator
            return label
        }()
        centerView.addSubview(textRemainingLabel)
        textRemainingLabel.snp.makeConstraints { make in
            make.top.equalTo((corneredBorderView?.snp.bottom)!).inset(-20)
            make.left.equalTo((corneredBorderView?.snp.left)!)
        }
        
        remainingLabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 20, weight: .bold)
            label.text = "0 ml"
            return label
        }()
        centerView.addSubview(remainingLabel ?? UILabel())
        remainingLabel?.snp.makeConstraints({ make in
            make.centerX.equalTo(textRemainingLabel)
            make.top.equalTo(textRemainingLabel.snp.bottom).inset(-5)
        })
        
        targetLabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 20, weight: .bold)
            label.text = "0 ml"
            return label
        }()
        centerView.addSubview(targetLabel ?? UILabel())
        targetLabel?.snp.makeConstraints({ make in
            make.centerX.equalTo(textTargetLabel)
            make.top.equalTo(textTargetLabel.snp.bottom).inset(-5)
        })
        
        
        setupCircularProgressBar()
        
    }
    
    
    func setupCircularProgressBar() {
        guard let corneredBorderView = corneredBorderView else { return }

        // Вычисляем центр corneredBorderView в его собственной координатной системе
        let corneredBorderCenter = CGPoint(x: corneredBorderView.bounds.midX + 100, y: corneredBorderView.bounds.midY + 100)
        let corneredBorderCenterInSelf = corneredBorderView.convert(corneredBorderCenter, to: corneredBorderView)

        let circularPath = UIBezierPath(arcCenter: corneredBorderCenterInSelf, radius: 90, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)

        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.systemGreen.cgColor
        progressLayer.lineWidth = 5

        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0

        corneredBorderView.layer.addSublayer(progressLayer)
        
    }


    
    
    
    
    
    
}


