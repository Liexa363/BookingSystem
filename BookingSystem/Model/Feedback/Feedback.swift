//
//  Feedback.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 27.05.2024.
//

import Foundation

struct Feedback {
    var id: String = ""
    var rating: String = ""
    var text: String = ""
    var date: String = ""
    var author: String = ""
    var serviceStationID: String = ""
    
    init(id: String, rating: String, text: String, date: String, author: String, serviceStationID: String) {
        self.id = id
        self.rating = rating
        self.text = text
        self.date = date
        self.author = author
        self.serviceStationID = serviceStationID
    }
}

