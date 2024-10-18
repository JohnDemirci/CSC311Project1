//
//  Options.swift
//  School
//
//  Created by John Demirci on 10/14/24.
//

import Foundation

enum UserOption {
    case addStudent(id: String, name: String)
    case sortStudents(SortOption)
    case viewUnseenGrades
    case viewAllGradesWithoutMarkingThemAsSeen
    case viewStudents
}

enum SortOption {
    case grade, name
}
