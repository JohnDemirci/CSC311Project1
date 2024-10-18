import Foundation

final class Student: Identifiable, Equatable, Sendable {
    let id: String
    let name: String

    nonisolated(unsafe) private(set) var grades: [Grade]

    func addGrade(_ grade: Grade) {
        grades.append(grade)
    }

    func updateGrade(oldGradeIndex: Int, newGrade: Grade) -> Result<Void, Failure> {
        guard grades.count > oldGradeIndex else {
            return .failure(.outOfBounds)
        }

        grades[oldGradeIndex] = newGrade
        return .success(())
    }

    init(id: String, name: String) {
        self.id = id
        self.name = name
        grades = []
    }
}

extension Student {
    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Student {
    func averageGrade() -> Grade? {
        guard !grades.isEmpty else { return nil }
        var sum: Double = 0

        for grade in grades {
            sum += grade.point
        }

        let average = sum / Double(grades.count)

        return Grade(floatLiteral: average)
    }
}

extension Student {
    enum Failure: Error {
        case outOfBounds
    }
}
