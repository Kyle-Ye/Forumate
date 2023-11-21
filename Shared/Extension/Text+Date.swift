//
//  Text+Date.swift
//  Forumate
//
//  Created by Kyle on 2023/9/11.
//

import SwiftUI

extension Date {
    var formattedText: Text {
        if Calendar.current.isDate(self, inSameDayAs: .now) {
            Text("\(self, style: .relative) ago")
        } else {
            Text("on \(self, style: .date)")            
        }
    }
}

