//
//  Item.swift
//  SwiftDataPractise
//
//  Created by Göksu Bayram on 30.07.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
