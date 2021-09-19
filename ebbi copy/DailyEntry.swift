//
//  DailyEntry.swift
//  ebbi
//
//  Created by Cesar Fuentes on 5/28/21.
//


import UIKit
import RealmSwift


class DailyEntry: Object {
    
    
    //MARK: Properties
    
    
    @objc dynamic var date : Date
    @objc dynamic var dateString: String
    @objc dynamic var topic: String
    @objc dynamic var uuid : String
    let reviewSchedule = List<Bool>()

    
    //MARK: Initialization
    
    override class func primaryKey() -> String? {
        return "uuid"
    }
    
    required override init() {
        date = Date()
        dateString = ""
        topic = ""
        uuid = ""
        super.init()
    }
    
    convenience init?(date: Date, topic: String) {
        self.init()
        self.date = date
        self.dateString = "\(Calendar.current.component(.month, from: date))/\(Calendar.current.component(.day, from: date))"
        self.topic = topic
        self.uuid = UUID().uuidString
        for _ in 0...3 {
            self.reviewSchedule.append(false)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

