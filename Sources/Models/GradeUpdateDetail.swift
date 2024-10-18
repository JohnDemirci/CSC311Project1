import Foundation

struct GradeUpdateDetail: Hashable {
    let studentID: String
    let grade: Grade
    let index: Int
    let date: Date
    let reason: GradeUpdateReason
}

enum GradeUpdateReason: Hashable {
    case new
    case change(from: Grade)
}
