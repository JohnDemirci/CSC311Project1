import Foundation

final class LiveGradeUpdates {
    private var stack: [GradeUpdateDetail]

    init() {
        stack = []
    }

    private func pop() -> Result<GradeUpdateDetail, Failure> {
        guard !stack.isEmpty else { return .failure(.notExists) }
        return .success(stack.removeFirst())
    }

    func addGrade(_ detail: GradeUpdateDetail) {
        stack.insert(detail, at: 0)
    }
}

extension LiveGradeUpdates {
    func displayRecentUpdates() {
        let size = min(stack.count, 5)

        for _ in 0 ..< size {
            let popResult = pop()

            switch popResult {
            case let .success(detail):
                handlePrint(detail)
            case let .failure(error):
                print("error: \(error.localizedDescription)")
            }
        }
    }

    func handlePrint(_ detail: GradeUpdateDetail) {
        switch detail.reason {
        case .new:
            print(
                """
                \(detail.studentID) received \(detail.grade.point) (\(detail.grade.description)) at \(detail.date)
                """
            )
        case let .change(from: oldGrade):
            print(
                """
                \(detail.studentID) old grade \(oldGrade.point) changed to \(detail.grade.point) at \(detail.date)
                """
            )
        }
    }

    func viewAll() {
        for detail in stack {
            handlePrint(detail)
        }
    }
}

extension LiveGradeUpdates {
    func updateGrades(_ updateDetail: GradeUpdateDetail) -> Result<Void, Failure> {
        guard !stack.contains(updateDetail) else { return .failure(.alreadyExists) }
        handleUpdate(updateDetail)
        return .success(())
    }
}

private extension LiveGradeUpdates {
    func handleUpdate(_ detail: GradeUpdateDetail) {
        stack.insert(detail, at: 0)
    }
}

extension LiveGradeUpdates {
    enum Failure: Error {
        case alreadyExists
        case notExists
    }
}
