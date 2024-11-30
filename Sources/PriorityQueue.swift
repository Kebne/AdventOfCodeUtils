import Foundation

public struct PriorityQueue<Element> {
    private var elements: [Element]
    private let sort: (Element, Element) -> Bool

    public init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        self.sort = sort
        self.elements = elements
        self.elements.sort(by: sort)
    }

    public var isEmpty: Bool {
        return elements.isEmpty
    }

    public mutating func enqueue(_ element: Element) {
        elements.append(element)
        elements.sort(by: sort)
    }

    public mutating func dequeue() -> Element? {
        return isEmpty ? nil : elements.removeFirst()
    }

    public func peek(where closure: (Element) -> Bool ) -> Element? {
        elements.first { closure($0) }
    }

    public func peek() -> Element? {
        return elements.first
    }
}
