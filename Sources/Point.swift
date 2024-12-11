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

    public var nextClockwise: Direction {
        switch self {
        case .up: return .right
        case .right: return .down
        case .down: return .left
        case .left: return .up
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

public enum Direction8: CustomDebugStringConvertible, Sendable, CaseIterable {
    case north, east, south, west, northEast, northWest, southEast, southWest

    public var debugDescription: String {
        switch self {
        case .north: "↑"
        case .east: "→"
        case .south: "↓"
        case .west: "←"
        case .northEast: "↗"
        case .northWest: "↖"
        case .southEast: "↘"
        case .southWest: "↙"
        }
    }
}

public struct Point: Hashable {
    public let x: Int
    public let y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

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

    public func pointsInAllDirections8(length: Int) -> [[Point]] {
        Direction8.allCases.map {
            points(in: $0, length: length)
        }
    }

    public func points(in direction: Direction8, length: Int) -> [Point] {
        var result: [Point] = []
        for step in 1 ... length {
            let nextPoint: Point
            switch direction {
            case .north:
                nextPoint = Point(x: x, y: y - step)
            case .east:
                nextPoint = Point(x: x + step, y: y)
            case .south:
                nextPoint = Point(x: x, y: y + step)
            case .west:
                nextPoint = Point(x: x - step, y: y)
            case .northEast:
                nextPoint = Point(x: x + step, y: y - step)
            case .northWest:
                nextPoint = Point(x: x - step, y: y - step)
            case .southEast:
                nextPoint = Point(x: x + step, y: y + step)
            case .southWest:
                nextPoint = Point(x: x - step, y: y + step)
            }
            result.append(nextPoint)
        }
        return result
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
