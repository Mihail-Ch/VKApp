//
//  LikeButton.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import UIKit

class LikeButton: UIControl {

    private let stackView = UIStackView()
    private let likeLabel = UILabel()
    private let button = UIButton()
    private var likeCount = 2
    private var buttonIsSelected = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    //MARK: - Privat methods
    
    private  func setupView() {
        //create button
        button.setImage(UIImage(named: "like"), for: .normal)
        button.addTarget(self, action: #selector(customButtonAction(_:)), for: .touchUpInside)
    
        likeLabel.text = "\(likeCount)"
        
        likeLabel.textColor = .black
        
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(likeLabel)
        stackView.spacing = 3
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
        
    }
    
    @objc func customButtonAction(_ sender: UIButton)  {
        print("Button pressed 👍")
        if buttonIsSelected == false {
            button.setImage(UIImage(named: "disLike"), for: .normal)
            likeCount += 1
            likeLabel.text = "\(likeCount)"
            buttonIsSelected = true
        } else {
            button.setImage(UIImage(named: "like"), for: .normal)
            likeCount -= 1
            likeLabel.text = "\(likeCount)"
            buttonIsSelected = false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
}





