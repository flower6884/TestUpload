//
//  RatingControl.swift
//  CloudsAPP
//
//  Created by Paul Hua on 2017/8/17.
//  Copyright © 2017年 mike. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    private var starButtons = [UIButton]()
    var stars = 0 {
        didSet {
            drawStarButton()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 15.0, height: 15.0)
    {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var starNumber: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupButtons()
        
    }
    
    required init(coder: NSCoder)
    {
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
        setupButtons()
    }
    
    
    private func setupButtons()
    {
        for button in starButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        starButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let starEmpty = UIImage(named: "starEmpty", in: bundle, compatibleWith: self.traitCollection)
        let starFilled = UIImage(named: "starFilled", in: bundle, compatibleWith: self.traitCollection)
        let star = UIImage(named: "star", in: bundle, compatibleWith: self.traitCollection)
        
        //產生一些 button
        for _ in 0..<starNumber
        {
            let button = UIButton()
            // button.backgroundColor = UIColor.black
            button.setImage(starEmpty, for: .normal)
            button.setImage(starFilled, for: .selected)
            button.setImage(star, for: .highlighted)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
    
            button.addTarget(self, action: #selector(RatingControl.tapButton(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            starButtons.append(button)
        }
        
        
    }
    
    func tapButton(button: UIButton)
    {
        print("點評")
        guard let index = starButtons.index(of: button) else {
            fatalError("按鈕不在陣列中")
        }
        
        let selectedStarNumber = index + 1
        stars = selectedStarNumber
    }
    
    private func drawStarButton()
    {
        for (index, button) in starButtons.enumerated()
        {
            button.isSelected = index < stars
        }
    }
//    extension Selector{
//        static let tapButton = #selector(RatingControl.tapButton(button:))
//    }
    
}
