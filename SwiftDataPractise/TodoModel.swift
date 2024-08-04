//
//  TodoDataManager.swift
//  SwiftDataPractise
//
//  Created by Göksu Bayram on 30.07.2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Todo: Identifiable {

    @Attribute(.unique) var id: UUID
    var title: String
    var isCompleted: Bool
    var addedDate: Date
    var completeDate: Date? = nil
    
    init(title: String) {
        self.id = UUID()
        self.title = title
        self.isCompleted = false
        self.addedDate = Date()
        self.completeDate = nil
    }
}
