//
//  Driver.swift
//  School
//
//  Created by John Demirci on 10/14/24.
//

import Foundation

@available(macOS 14, *)
struct Driver {
    let classroom = Class()

    func run() {
        main()
    }

    func goBackOrTryAgain(
        tryAgain: @escaping () -> Void
    ) {
        print("press [r] retry [b] back [q] quit")

        guard let userInput = readLine() else {
            print("invalid input")
            goBackOrTryAgain(tryAgain: tryAgain)
            return
        }

        switch userInput {
        case "r":
            tryAgain()
        case "b":
            main()
        case "q":
            exit(0)
        default:
            print("invalid input")
            goBackOrTryAgain(tryAgain: tryAgain)
        }
    }

    func main() {
        print("Welcome to School please choose an option")

        print("""
        [0] add a student
        [1] sort students
        [2] view unseen grades
        [3] view all grades without marking them as seen
        [4] view students
        [5] batch add students
        [6] add a grade for student
        """
        )

        let userInput = readLine()

        guard
            let userInput
        else {
            main()
            return
        }

		switch userInput {
        case "0":
            addStudent()
        case "1":
            sort()
        case "2":
            unseenGrades()
        case "3":
            classroom.viewGradesWithoutMarkingThemAsSeen()

            goBackOrTryAgain {
                classroom.viewGradesWithoutMarkingThemAsSeen()
            }
        case "4":
            classroom.studentList()

            goBackOrTryAgain {
                classroom.studentList()
            }
        case "5":
            batchAddStudents()
        case "6":
            addGrade()
		case "q":
			exit(0)
        default:
            main()
        }
    }
}
