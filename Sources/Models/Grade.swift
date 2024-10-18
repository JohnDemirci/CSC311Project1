import Foundation

struct Grade: ExpressibleByFloatLiteral, Hashable {
    typealias FloatLiteralType = Double

    let point: Double

    init(floatLiteral value: FloatLiteralType) {
        point = value
    }
}

extension Grade {
    var description: Letter {
        switch point {
        case 90...:
            return .A
        case 80 ..< 90:
            return .B
        case 70 ..< 80:
            return .C
        case 60 ..< 70:
            return .D
        case ..<60:
            return .F
        default:
            return .F
        }
    }
}

extension Grade {
    enum Letter: String, Equatable {
        case A, B, C, D, F
    }
}
