//
//  Extensions.swift
//  ebbi
//
//  Created by Cesar Fuentes on 6/2/21.
//


import UIKit


public extension UIView {
    class func makeViewRound(view: UIView, color: UIColor, radius: CGFloat) {
        view.layer.cornerRadius = radius;
        let shadowColor = UIColor(red: 199.0/255.0, green: 199.0/255.0, blue: 210.0/255.0, alpha: 255.0/255.0)
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 6
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.backgroundColor = color
    }
}

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




/*
let topColor = UIColor(red: 143.0/255.0, green: 142.0/255.0, blue: 147.0/255.0, alpha: 255.0/255.0)
let bottomColor = UIColor(red: 106.0/255.0, green: 105.0/255.0, blue: 112.0/255.0, alpha: 255.0/255.0)
let gradientLayer = CAGradientLayer()
gradientLayer.colors = [bottomColor.cgColor, topColor.cgColor]
gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
gradientLayer.locations = [0, 1]
gradientLayer.frame = cell.bounds
gradientLayer.cornerRadius = cell.layer.cornerRadius
cell.layer.insertSublayer(gradientLayer, at: 0)
 */

/*
let topColor = UIColor(red: 254.0/255.0, green: 140.0/255.0, blue: 20.0/255.0, alpha: 255.0/255.0)
let bottomColor = UIColor(red: 255.0/255.0, green: 50.0/255.0, blue: 195.0/255.0, alpha: 255.0/255.0)
let gradientLayer = CAGradientLayer()

gradientLayer.colors = [bottomColor.cgColor, topColor.cgColor] // [UIColor.clear.cgColor, UIColor.clear.cgColor]

gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0) // SEE IF THESE AFFECT COLORING
gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
gradientLayer.locations = [0, 1]
gradientLayer.frame = chartBackground.bounds
gradientLayer.cornerRadius = chartBackground.layer.cornerRadius

chartBackground.layer.insertSublayer(gradientLayer, at: 0)

weeklyBarChart.bringSubviewToFront(weeklyBarChart)
*/

/*
 
 //MARK: Private Methods
 
 
 private func loadSampleCourses() {
     
     var components1 = DateComponents()
     components1.year = 2021
     components1.month = 7
     components1.day = 1
     let date1 = Calendar.current.date(from: components1) ?? Date()

     var components2 = DateComponents()
     components2.year = 2021
     components2.month = 8
     components2.day = 1
     let date2 = Calendar.current.date(from: components2) ?? Date()
     
     let image = UIImage(systemName: "book")
     
     guard let course1 = Course(courseName: "CHEM 101", courseSubName: "General Chemistry", weeklySchedule:[false,true,false,true,false,true,false], startDate: date1, endDate: date2, color: UIColor.systemTeal, icon: image!) else {fatalError("Unable to instantiate course1")}
     
     // // [false,true,false,true,false,true,false]
     
     do {
         try realm.write {
             realm.add(course1);
         }
     }catch {
         print("Error starting Realm! \(error)");
     }
 }

 */
