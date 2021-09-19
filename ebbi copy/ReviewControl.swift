//
//  ReviewControl.swift
//  ebbi
//
//  Created by Cesar Fuentes on 5/30/21.
//


import UIKit


@IBDesignable class ReviewControl: UIStackView {
    
    
    //MARK: Properties
    
    
    var reviewSchedule: [Bool] = [false,false,false,false]
    private var reviewButtons = [UIButton]()
    var scheduledMinutes: [String] = ["15","10","5","2"]
    
    
    //MARK: Initialization
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //reviewSchedule = thing
        setupReviewButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupReviewButtons()
    }
    
    
    //MARK: Button Action
    
    
    @objc func reviewButtonTapped(button: UIButton) {
        guard let index = reviewButtons.firstIndex(of: button) else {
                fatalError("The button title, \(button), is not in the weekdays array: \(scheduledMinutes)")
        }
        if (reviewSchedule[index]) {
            //the button is already pressed
            button.backgroundColor = UIColor.lightGray
            reviewSchedule[index] = false
        } else {
            //the button is not already pressed
            button.backgroundColor = UIColor.darkGray
            reviewSchedule[index] = true
        }
    }
    
    
    //MARK: Private Methods
    
    
    private func setupReviewButtons() {
        for button in reviewButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        reviewButtons.removeAll()
        for i in 0..<4 {
            // Create the button
            let button = UIButton()
            //Set the button colors
            if (reviewSchedule[i]) {
                button.backgroundColor = UIColor.darkGray
            } else {
                button.backgroundColor = UIColor.lightGray
            }
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 33).isActive = true
            button.widthAnchor.constraint(equalToConstant: 33).isActive = true
            button.layer.cornerRadius = (0.5)*33
            // Setup the button action
            button.addTarget(self, action: #selector(ReviewControl.reviewButtonTapped(button:)), for: .touchUpInside)
            button.setTitle("\(scheduledMinutes[i])", for: .normal)
            // Add the button to the stack
            addArrangedSubview(button)
            // Add the new button to the rating button array
            reviewButtons.append(button)
        }
    }
    
    // TODO: Determine If Needed With Realm
    func updateButtons() {
        for i in 0..<4 {
            if (reviewSchedule[i]) {
                reviewButtons[i].backgroundColor = UIColor.darkGray
            } else {
                reviewButtons[i].backgroundColor = UIColor.lightGray
            }
        }
    }
    
    
}
