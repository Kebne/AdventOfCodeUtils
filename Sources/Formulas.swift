import Foundation

public enum Formulas {

    /// Calculate the area of a polygon
    public static func shoelace(corners: [(Point, Corner)]) -> Int {
        zip(corners.dropLast(), corners.dropFirst())
            .map { $0.0.x * $1.0.y - $0.0.y * $1.0.x }
            .reduce(0, +) / 2
    }

    /// Points inside polygon, using picks theorem
    public static func pointsInsidePolygon(edgeCount: Int, area: Int) -> Int {
        return area - (edgeCount / 2) + 1
    }

    
}
