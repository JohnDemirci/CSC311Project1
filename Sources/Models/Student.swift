import Foundation

final class Student: Identifiable, Equatable, Sendable {
    let id: String
    let name: String

    private(set) nonisolated(unsafe) var grade: Grade?

    init(id: String, name: String) {
        self.id = id
        self.name = name
        grade = nil
    }

    func upsertGrade(_ grade: Grade) -> GradeUpdateReason {
        if let oldGrade = self.grade {
            self.grade = grade
            return .change(from: oldGrade)
        } else {
            self.grade = grade
            return .new
        }
    }
}

extension Student {
    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Student {
    enum Failure: Error {
        case outOfBounds
    }
}
