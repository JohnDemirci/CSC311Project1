//
//  Driver+Sort.swift
//  School
//
//  Created by John Demirci on 10/14/24.
//

import Foundation

@available(macOS 14, *)
extension Driver {
    func sort() {
        print("please select sorting option")

        print("1. Sort by name")
        print("2. Sort by grade")

        defer {
            goBackOrTryAgain {
                sort()
            }
        }

        let option = readLine()

        switch option {
        case "1":
            classroom.sortByName()
        case "2":
            classroom.sortByGrade()
        default:
            print("invalid option")
        }
    }
}
