//
//  Driver+AddStudent.swift
//  School
//
//  Created by John Demirci on 10/14/24.
//

import Foundation

@available(macOS 14, *)
extension Driver {
    func addStudent() {
        print("please enter the student's name")
        let name = readLine()

        print("please enter a unique ID for the student")
        let id = readLine()

        guard
            let name,
            let id
        else {
            print("invalid input please try again")
            addStudent()
            return
        }

        defer {
            goBackOrTryAgain {
                addStudent()
            }
        }

        switch classroom.add(id, name: name) {
        case .success:
            print("successfully added student")
        case .failure(let error):
            print("Could not add student due to the following reason \n\(error.localizedDescription)")
        }
    }

    func batchAddStudents() {
        print("please enter the name of the students seperated by a comma")
        let names = readLine()

        guard let names else {
            print("invalid input please try again")
            batchAddStudents()
            return
        }
        
        let namesArraySepeartedByCommas = names.split(separator: ",")

        let namesArray: [String] = namesArraySepeartedByCommas.map {
            $0.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        classroom.batchAdd(namesArray)
        classroom.studentList()

        goBackOrTryAgain {
            batchAddStudents()
        }
    }
}
