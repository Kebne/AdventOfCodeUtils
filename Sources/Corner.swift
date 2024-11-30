import Foundation

public enum Corner: CustomDebugStringConvertible {
    case start
    case northSouth
    case eastWest
    case northWest
    case northEast
    case southWest
    case southEast

    public var isNorthFacing: Bool {
        switch self {
        case .northSouth: true
        case .northWest: true
        case .northEast: true
        case .start: false
        case .eastWest: false
        case .southWest: false
        case .southEast: false
        }
    }

    public var debugDescription: String {
        switch self {
        case .start: "S"
        case .northSouth: "│"
        case .eastWest: "─"
        case .northWest: "┘"
        case .northEast: "└"
        case .southWest: "┐"
        case .southEast: "┌"
        }
    }

    public static func coner(for first: Direction, relative other: Direction) -> Corner {
        switch (first, other) {
        case (.up, .up): .northSouth
        case (.down, .down): .northSouth
        case (.left, .left): .eastWest
        case (.right, .right): .eastWest
        case (.up, .left): .southWest
        case (.up, .right): .southEast
        case (.down, .right): .northEast
        case (.down, .left): .northWest
        case (.left, .up): .northEast
        case (.left, .down): .southEast
        case (.right, .up): .northWest
        case (.right, .down): .southWest
        default: fatalError("Illegal move")
        }
    }
}
