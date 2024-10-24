import Foundation

struct GradeUpdateDetail: Hashable {
    let studentID: String
    let grade: Grade
    let date: Date
    let reason: GradeUpdateReason
}

enum GradeUpdateReason: Hashable {
    case new
    case change(from: Grade)
}
