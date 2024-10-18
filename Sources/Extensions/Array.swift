import Foundation

extension Array {
    mutating func bubbleSort(
        comparison: @escaping (Element, Element) -> Bool
    ) {
        for i in 0 ..< count {
            for j in 0 ..< count - i - 1 {
                if !comparison(self[i], self[j]) {
                    swapAt(i, j)
                }
            }
        }
    }
}
