//
//  AddViewController.swift
//  ebbi
//
//  Created by Cesar Fuentes on 6/2/21.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var courseNameField: UITextField!
    @IBOutlet weak var courseSubtitleField: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var schedulePicker: ScheduleControl!
    @IBOutlet weak var colorPicker: ColorControl!
    
    private let realm = try! Realm()
    public var addCompletionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        // self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        
        let text = courseNameField?.text
        let schedule = schedulePicker?.weeklySchedule
        let color = colorPicker?.color
        
        print(color as Any)
        
        if (text!.isEmpty == true) {
            let defaultAction = UIAlertAction(title: "Okay", style: .default) { (action) in }
            let alert = UIAlertController(title: "Missing Name", message: "Please enter a course name.", preferredStyle: .alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true) {}
        } else if (!schedule!.contains(true)) {
            let defaultAction = UIAlertAction(title: "Okay", style: .default) { (action) in }
            let alert = UIAlertController(title: "Missing Schedule", message: "Please enter a course schedule.", preferredStyle: .alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true) {}
            
            /*
            } else if (color == nil) {

                let defaultAction = UIAlertAction(title: "Okay", style: .default) { (action) in }
                let alert = UIAlertController(title: "Missing Color", message: "Please select a color.", preferredStyle: .alert)
                alert.addAction(defaultAction)
                self.present(alert, animated: true) {}
            */
            
        } else if (false) {
            // TODO: Check For Color
            // TODO: Check For Available Dates
            // TODO: Add Icon Condition
            // TODO: Add Same Name Condition
            /*
             let defaultAction = UIAlertAction(title: "Okay", style: .default) { (action) in }
             let alert = UIAlertController(title: "Duplicate Item", message: "At item with that name already exists. Please choose a different name", preferredStyle: .alert)
             alert.addAction(defaultAction)
             self.present(alert, animated: true) {}
             */
        } else {
            
            print("adding")
            guard let image = UIImage(systemName: "book") else { return }
            // TODO: Update This With Control
            guard let subtext = courseSubtitleField?.text else { return }
            guard let startDate = startDatePicker?.date else { return }
            guard let endDate = endDatePicker?.date else { return }
            try! realm.write {
                guard let newCourse = Course(courseName: text!, courseSubName: subtext, weeklySchedule: schedule!, startDate: startDate, endDate: endDate, color: color!, icon: image) else { return }
                realm.add(newCourse)
            }
            addCompletionHandler?()
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
    
    

}
