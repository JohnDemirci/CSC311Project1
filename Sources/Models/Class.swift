import Foundation

final class Class {
    private(set) var students: [Student]
    private let unseenUpdatedGrades: LiveGradeUpdates

    init() {
        students = []
        unseenUpdatedGrades = .init()
    }
}

// MARK: - Add Student

extension Class {
    func add(_ id: String, name: String) -> Result<Void, Failure> {
        let student = Student(id: id, name: name)
        guard !students.contains(student) else { return .failure(.alreadyAdmitted(student)) }
        students.append(student)
        return .success(())
    }

    func batchAdd(_ names: [String]) {
        let newStudents = names.map {
            Student(id: UUID().uuidString, name: $0)
        }

        students.append(contentsOf: newStudents)
    }
}

// MARK: - Find

extension Class {
    @available(macOS 14.0, *)
    func find(id: Student.ID) -> Result<Student, Failure> {
        let student = students.first { element in
            element.id == id
        }

        guard let student else { return .failure(.notExists) }
        return .success(student)
    }

    func find(_ name: String) -> [Student] {
        students.filter {
            $0.name.localizedStandardContains(name)
        }
    }
}

extension Class {
    func sortByName() {
        students.bubbleSort {
            $0.name < $1.name
        }
    }

    func sortByGrade() {
        students.bubbleSort {
            switch ($0.grade, $1.grade) {
            case let (.some(lhsGrade), .some(rhsGrade)):
                lhsGrade.point > rhsGrade.point
            case (.none, .some):
                false
            case (.some, .none):
                true
            case (.none, .none):
                true
            }
        }
    }
}

// MARK: - Display students

extension Class {
    func studentList() {
        for student in students {
            print("\(student.id) \(student.name)")
        }
    }
}

// MARK: - Live Grades

extension Class {
    func lookAtUnseenGrades() {
        unseenUpdatedGrades.displayRecentUpdates()
    }

    func viewGradesWithoutMarkingThemAsSeen() {
        unseenUpdatedGrades
            .viewAll()
    }
}

extension Class {
    @available(macOS 14.0, *)
    func addGrade(id: Student.ID, grade: Grade) -> Result<Void, Error> {
        let studentFindResult = find(id: id)

        switch studentFindResult {
        case let .success(student):
            let reason = student.upsertGrade(grade)
            unseenUpdatedGrades.addGrade(
                GradeUpdateDetail(
                    studentID: id,
                    grade: grade,
                    date: .now,
                    reason: reason
                )
            )
            return .success(())

        case let .failure(error):
            return .failure(error)
        }
    }

    @available(macOS 14.0, *)
    func updateGrade(
        _ id: Student.ID,
        oldIndex _: Int,
        grade: Grade
    ) -> Result<Void, Error> {
        let studentFindResult = find(id: id)

        switch studentFindResult {
        case let .success(student):
            _ = student.upsertGrade(grade)
            return .success(())

        case let .failure(failure):
            return .failure(failure)
        }
    }
}

extension Class {
    enum Failure: Error, Sendable {
        case alreadyAdmitted(Student)
        case notExists
    }
}
