//
//  ScheduleControl.swift
//  ebbi
//
//  Created by Cesar Fuentes on 5/30/21.
//


import UIKit


@IBDesignable class ScheduleControl: UIStackView {
    
    
    //MARK: Properties
    
    
    var weekdays:[String] = ["S","M","T","W","R","F","S"]
    private var scheduleButtons = [UIButton]()
    var weeklySchedule:[Bool] = [false,false,false,false,false,false,false]
    
    
    //MARK: Initialization
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScheduleButtons()
    }
     
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupScheduleButtons()
    }
    
    
    //MARK: Button Action

    
    @objc func scheduleButtonTapped(button: UIButton) {
        guard let index = scheduleButtons.firstIndex(of: button) else {
                fatalError("The button title, \(button), is not in the weekdays array: \(weekdays)")
        }
        if (weeklySchedule[index]) {
            //the button is already pressed
            button.backgroundColor = UIColor.lightGray
            weeklySchedule[index] = false
        } else {
            //the button is not already pressed
            button.backgroundColor = UIColor.darkGray
            weeklySchedule[index] = true
        }
    }
    
    
    //MARK: Private Methods
    
    
    private func setupScheduleButtons() {
        for button in scheduleButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        scheduleButtons.removeAll()
        for i in 0..<7 {
            // Create the button
            let button = UIButton()
            //Set the button colors
            button.backgroundColor = UIColor.lightGray
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 42).isActive = true
            button.widthAnchor.constraint(equalToConstant: 42).isActive = true
            // Setup the button action
            button.addTarget(self, action: #selector(ScheduleControl.scheduleButtonTapped(button:)), for: .touchUpInside)
            button.setTitle("\(weekdays[i])", for: .normal)
            // Add the button to the stack
            addArrangedSubview(button)
            // Add the new button to the rating button array
            scheduleButtons.append(button)
        }
    }
    
    
}
