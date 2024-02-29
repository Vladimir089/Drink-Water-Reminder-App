//
//  ChangeCellView.swift
//  Drink Water Reminder App
//
//  Created by Владимир Кацап on 29.02.2024.
//

import UIKit

class ChangeCellView: UIView {
    let imageArr = ["aqua", "cocktail", "coffee", "cola", "juice", "milk", "tea", "wine", "Yogurt"]

    var imageSet: String?

    
    var nameTextField, mlTextField: UITextField?
    
    var changeButton: UIButton?
    
    private var selectedCellIndex: Int?
    private var collectionView: UICollectionView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createComponents()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func hideKeyboard() {
        endEditing(true)
    }
    
    func createComponents() {
        backgroundColor = UIColor(red: 236/255, green: 250/255, blue: 242/255, alpha: 1)
        alpha = 0.0
        layer.cornerRadius = 15
        isUserInteractionEnabled = true
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = "Name"
            label.font = .systemFont(ofSize: 30, weight: .light)
            label.textColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1)
            return label
        }()
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.left.equalToSuperview().inset(20)
        }
        
        nameTextField = {
            let textField = UITextField()
            textField.delegate = self
            textField.layer.cornerRadius = 20
            textField.placeholder = "Put the name here"
            textField.clipsToBounds = true
            textField.backgroundColor = .white
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
                textField.leftView = leftPaddingView
                textField.leftViewMode = .always
            return textField
        }()
        addSubview(nameTextField ?? UITextField())
        nameTextField?.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(nameLabel.snp.bottom).inset(-10)
        }
        
        let mlLabel: UILabel = {
            let label = UILabel()
            label.text = "Mililiter"
            label.font = .systemFont(ofSize: 30, weight: .light)
            label.textColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1)
            return label
        }()
        addSubview(mlLabel)
        mlLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField?.snp.bottom ?? UITextField()).inset(-10)
            make.left.equalToSuperview().inset(20)
        }
        
        mlTextField = {
            let textField = UITextField()
            textField.layer.cornerRadius = 20
            textField.placeholder = "Specify the number of milliliters here "
            textField.clipsToBounds = true
            textField.backgroundColor = .white
            textField.keyboardType = .numberPad
            textField.returnKeyType = .done
            textField.delegate = self
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
                textField.leftView = leftPaddingView
                textField.leftViewMode = .always
            return textField
        }()
        addSubview(mlTextField ?? UITextField())
        mlTextField?.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(mlLabel.snp.bottom).inset(-10)
        }
        
        let imageLabel: UILabel = {
            let label = UILabel()
            label.text = "Image"
            label.font = .systemFont(ofSize: 30, weight: .light)
            label.textColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1)
            return label
        }()
        addSubview(imageLabel)
        imageLabel.snp.makeConstraints { make in
            make.top.equalTo(mlTextField?.snp.bottom ?? UITextField()).inset(-10)
            make.left.equalToSuperview().inset(20)
        }
        
        collectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.layer.cornerRadius = 7
            collection.allowsSelection = true
            collection.showsHorizontalScrollIndicator = false
            collection.isUserInteractionEnabled = true
            collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "1")
            return collection
        }()

        
        addSubview(collectionView ?? UICollectionView())
        collectionView?.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(100)
            make.top.equalTo(imageLabel.snp.bottom).inset(-5)
        }
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        changeButton = {
            let button = UIButton()
            button.setTitle("Save", for: .normal)
            button.backgroundColor = UIColor(red: 93/255, green: 203/255, blue: 116/255, alpha: 1)
            button.layer.cornerRadius = 20
            return button
        }()
        addSubview(changeButton ?? UIButton())
        changeButton?.snp.makeConstraints({ make in
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(collectionView!.snp.bottom).inset(-20)
            make.left.right.equalToSuperview().inset(15)
        })
        
        
    }
    
    
    @objc func tapCell(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionView?.indexPathForItem(at: sender.location(in: collectionView)) else {
            return
        }
        imageSet = imageArr[indexPath.row]
        print(indexPath.row)
        
        selectedCellIndex = indexPath.row
        collectionView?.reloadData()
    }
}
extension ChangeCellView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension ChangeCellView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "1", for: indexPath)
        cell.backgroundColor = UIColor(red: 236/255, green: 250/255, blue: 242/255, alpha: 1)
        cell.layer.cornerRadius = 7
        cell.isUserInteractionEnabled = true
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.clear.cgColor
        if indexPath.row == selectedCellIndex {
            cell.layer.borderColor = UIColor.systemGreen.cgColor
        }
        
        cell.clipsToBounds  = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapCell(sender:)))
           cell.addGestureRecognizer(gesture)
        for subview in cell.subviews {
                subview.removeFromSuperview()
            }
        
        let imageView = UIImageView(image: UIImage(named: imageArr[indexPath.row]))
        cell.addSubview(imageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 95, height: 95)
    }
    
    

    
}


