import Foundation

public enum Direction: CustomDebugStringConvertible, Sendable {
    public var debugDescription: String {
        switch self {
        case .down: "↓"
        case .right: "→"
        case .left: "← "
        case .up: "↑"

        }
    }

    public static let all: [Direction] = [.up, .right, .down, .left]

    case up, right, down, left

    public var isVertical: Bool {
        switch self {
        case .up: return true
        case .down: return true
        case .left: return false
        case .right: return false
        }
    }

    public var isHorizontal: Bool {
        switch self {
        case .up: return false
        case .down: return false
        case .left: return true
        case .right: return true
        }
    }

    public func isOpposite(to other: Direction) -> Bool {
        switch (self, other) {
        case (.left, .right): true
        case (.right, .left): true
        case (.up, .down): true
        case (.down, .up): true
        default: false
        }
    }
}

public struct Point: Hashable {
    public let x: Int
    public let y: Int

    public var neighbors: Set<Point> {
        Set([
            Point(x: x - 1, y: y + 1),
            Point(x: x, y: y + 1),
            Point(x: x - 1, y: y + 1),
            Point(x: x - 1, y: y),
            Point(x: x + 1, y: y),
            Point(x: x - 1, y: y - 1),
            Point(x: x, y: y - 1),
            Point(x: x + 1, y: y - 1),
        ])
    }

    public var nonDiagonalNeighbors: Set<Point> {
        Set([
            Point(x: x - 1, y: y),
            Point(x: x, y: y - 1),
            Point(x: x, y: y + 1),
            Point(x: x + 1, y: y),
        ])
    }

    public func move(in direction: Direction, length: Int = 1) -> Point {
        switch direction {
        case .down: Point(x: x, y: y + length)
        case .right: Point(x: x + length, y: y)
        case .up: Point(x: x, y: y - length)
        case .left: Point(x: x - length, y: y)
        }
    }

    public func direction(to other: Point) -> Direction {
        if other.y < y && other.x == x {
            return .up
        } else if other.y > y && other.x == x {
            return .down
        } else if other.x > x && other.y == y {
            return .right
        } else if other.x < x && other.y == y {
            return .left
        }

        assertionFailure("Unsupported movement")
        fatalError()
    }

    public func manhattanDistance(to other: Point) -> Int {
        abs(x - other.x) + abs(y - other.y)
    }
}

extension Point: CustomDebugStringConvertible {
    public var debugDescription: String {
        "x:\(x) y:\(y)"
    }
}
