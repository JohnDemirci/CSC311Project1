//
//  Driver+Grades.swift
//  School
//
//  Created by John Demirci on 10/17/24.
//

@available(macOS 14.0, *)
extension Driver {
    func unseenGrades() {
        classroom.lookAtUnseenGrades()
        goBackOrTryAgain {
            unseenGrades()
        }
    }

    public func addGrade() {
        print("enter student ID")

        guard let studentID = readLine() else {
            print("invalid input")
            addGrade()
            return
        }

        print("Add a double value for the grade")

        guard
            let stringValue = readLine(),
            let doubleValue = Double(stringValue)
        else {
            print("invalid input")
            addGrade()
            return
        }

        let result = classroom.addGrade(id: studentID, grade: Grade(floatLiteral: doubleValue))

        defer {
            goBackOrTryAgain {
                addGrade()
            }
        }

        switch result {
        case .success:
            print("successfully added grade")
        case .failure(let error):
            print("error: \(error.localizedDescription)")
        }
    }
}
