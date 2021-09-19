//
//  ColorControl.swift
//  ebbi
//
//  Created by Cesar Fuentes on 6/2/21.
//

import UIKit

@IBDesignable class ColorControl: UIStackView {
    
    //MARK: Properties
    
    private var colorButtons = [UIButton]()
    var colorSelections:[UIColor] = [UIColor.systemRed,
                                     UIColor.systemOrange,
                                     UIColor.systemYellow,
                                     UIColor.systemGreen,
                                     UIColor.systemTeal,
                                     UIColor.systemBlue,
                                     UIColor.systemPurple,
                                     UIColor.systemPink]
    var color: UIColor = UIColor.white
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupColorButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupColorButtons()
    }
    
    //MARK: Button Action

    @objc func colorButtonTapped(button: UIButton) {
        guard let index = colorButtons.firstIndex(of: button) else {
                fatalError("The button color, \(button), is not in the weekdays array: \(colorSelections)")
        }
        // indicate that the button is now pressed
        color = colorSelections[index]
        button.layer.borderWidth = 2 //0.8
        button.layer.borderColor = UIColor.black.cgColor
        
        /*
        // Change color of Navigation Bar
        let objNavigationController = findViewController()
        objNavigationController?.navigationController?.navigationBar.barTintColor = color
            //?.navigationBar.barTintColor = color
        */

        // find the tapped button (if any) & untap it
        for colorButton in colorButtons {
            if (colorButton != button) {
                colorButton.layer.borderWidth = 0
            }
        }
    }
    
    //MARK: Private Methods
    
    private func setupColorButtons() {
        for button in colorButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        colorButtons.removeAll()
        for i in 0..<8 {
            // Create the button
            let button = UIButton()
            //Set the button colors
            button.backgroundColor = colorSelections[i]
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 35).isActive = true
            button.widthAnchor.constraint(equalToConstant: 35).isActive = true
            // Setup the button action
            button.addTarget(self, action: #selector(ColorControl.colorButtonTapped(button:)), for: .touchUpInside)
            // Add the button to the stack
            addArrangedSubview(button)
            // Add the new button to the rating button array
            colorButtons.append(button)
        }
    }
    
}








// TODO: Move

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
