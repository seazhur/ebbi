//
//  Course.swift
//  ebbi
//
//  Created by Cesar Fuentes on 5/28/21.
//


import UIKit
import RealmSwift


class Course: Object {
    
    
    // MARK: Properties
    
    
    @objc dynamic var courseName: String
    @objc dynamic var courseSubName: String
    // TODO: Check If The Following 3 Properties Are Necessary
    @objc dynamic var minutesToStudy: Int
    @objc dynamic var startDate: Date
    @objc dynamic var endDate: Date
    @objc dynamic var colorName: String
    @objc dynamic var icon: NSData
    let weeklySchedule = List<Bool>()
    let yearlySchedule = List<DailyEntry>()
    
    
    // MARK: Initialization
    
    
    override class func primaryKey() -> String? {
        return "courseName"
    }
    
    required override init() {
        courseName = ""
        courseSubName = ""
        minutesToStudy = 0
        startDate = Date()
        endDate = Date()
        colorName = ""
        icon = NSData() // NSData(data: (UIImage(named: "pencil").pngData()!)) //
        for _ in 0...6 {
            weeklySchedule.append(false) // 7 things
        }
        // yearlySchedule
        super.init()
    }

    convenience init?(courseName: String, courseSubName: String, weeklySchedule: [Bool], startDate: Date, endDate: Date, color: UIColor, icon: UIImage) {
        
        
        // TODO: See Above -> weeklySchedule: [Bool]
        
        
        self.init()
        self.courseName = courseName
        self.courseSubName = courseSubName
        self.minutesToStudy = 0
        self.startDate = startDate
        self.endDate = endDate
        self.colorName = UIColor.StringFromUIColor(color: color)
        self.icon = NSData(data: icon.pngData()!)
        for i in 0...6 {
            self.weeklySchedule.replace(index: i, object: weeklySchedule[i]) // 7 things
        }
        popYearlySchedule()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Helper Functions
    
    
    func popYearlySchedule() {
        // Calculate the Schedule Number Pattern (1 = Sunday, 7 = Saturday)
        var scheduleInNumbers = [Int]()
        var count = 1
        for n in weeklySchedule {
            if n {
                scheduleInNumbers.append(count)
            }
            count += 1
        }
        
        count = 1
        // Fill Yearly Schedule With The Scheduled Dates Between StartDate and EndDate
        let calendar = Calendar.current
        // Finding matching dates at midnight - adjust as needed
        let components = DateComponents(hour: 0, minute: 0, second: 0) // midnight
        calendar.enumerateDates(startingAfter: calendar.date(byAdding: .day, value: -1, to: self.startDate) ?? self.startDate, matching: components, matchingPolicy: .nextTime) { (date, strict, stop) in
            if let date = date {
                if date <= self.endDate {
                    let weekDay = calendar.component(.weekday, from: date)
                    if scheduleInNumbers.contains(weekDay) {
                        self.yearlySchedule.append(DailyEntry(date: date, topic: "Topic " + String(count))!)
                        count += 1
                    }
                } else {
                    stop = true
                }
            }
        }
    }
    
    
}












/*
public extension UIColor {
    class func StringFromUIColor(color: UIColor) -> String {
        let components = color.cgColor.components // CGColorGetComponents(color.cgColor)
        return "[\(components![0]), \(components![1]), \(components![2]), \(components![3])]"
    }
    class func UIColorFromString(string: String) -> UIColor {
        let componentsString = string.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        let components = componentsString.components(separatedBy: ", ") // componentsSeparatedByString(", ")
        return UIColor(red: CGFloat((components[0] as NSString).floatValue),
                     green: CGFloat((components[1] as NSString).floatValue),
                      blue: CGFloat((components[2] as NSString).floatValue),
                     alpha: CGFloat((components[3] as NSString).floatValue))
    }
}
*/
