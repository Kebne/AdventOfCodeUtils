import Foundation

public extension Collection {
    subscript(safe index: Index) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}

public extension Array {
    func bubbleSorted(by sorter: (Element, Element) -> Bool) -> Array<Element> {
        var arr = self
        guard arr.count > 1 else { return arr }

        for i in 0 ..< arr.count {
            for j in 1 ..< arr.count - i {
                if sorter(arr[j], arr[j - 1]) {
                    arr.swapAt(j, j - 1)
                }
            }
        }

        return arr
    }
}

public extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

public extension Array where Element == Array<String> {
    func printMap(highlight: [Point] = []) {
        var map = self
        highlight.forEach { hp in
            map[hp.y][hp.x] = "O"
        }
        let toPrint = map.map { $0.joined() }.joined(separator: "\n")
        print(toPrint)
    }
}

public extension Array where Element: Hashable {

    
    /// Returns a dictionary where the element is the key and the number of times
    ///  it exists as the value
    var countedElements: [Element: Int] {
        var countDictionary: [Element: Int] = [:]

        for element in self {
            countDictionary[element, default: 0] += 1
        }

        return countDictionary
    }
}

public extension Collection where Self.Iterator.Element: RandomAccessCollection {
    func transposed() -> [[Self.Iterator.Element.Iterator.Element]] {
        guard let firstRow = first else { return [] }
        return firstRow.indices.map { index in
            self.map { $0[index] }
        }
    }
}

