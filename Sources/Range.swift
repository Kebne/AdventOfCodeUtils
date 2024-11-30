import Foundation

public extension ClosedRange {
    func isCovered(by other: ClosedRange) -> Bool {
        if lowerBound >= other.lowerBound && upperBound <= other.upperBound {
            return true
        }

        return false
    }

    func hasOverlap(with other: ClosedRange) -> Bool {
        if lowerBound >= other.lowerBound && lowerBound <= other.upperBound {
            return true
        }

        if upperBound >= other.lowerBound && upperBound <= other.upperBound {
            return true
        }

        return false
    }

    /// Returns a ClosedRange that exists in both Ranges
    /// - Parameter other: The range to compare intersect with
    /// - Returns: ClosedRange that exists in both Ranges
    func intersect(_ other: ClosedRange<Bound>) -> ClosedRange<Bound>? {
        let lowerBoundMax = Swift.max(lowerBound, other.lowerBound)
        let upperBoundMin = Swift.min(upperBound, other.upperBound)

        let lowerBeforeUpper = lowerBoundMax <= upperBound && lowerBoundMax <= other.upperBound
        let upperBeforeLower = upperBoundMin >= lowerBound && upperBoundMin >= other.lowerBound

        if lowerBeforeUpper, upperBeforeLower {
            return lowerBoundMax ... upperBoundMin
        }

        return nil
    }

}

public extension ClosedRange where Bound: Strideable {

    /// Removes the overlap of the two ranges if any
    /// - Parameter other: A ClosedRange to exclude from the current range
    /// - Returns: An array of ClosedRanges where the excluding Range is not included
    func excluding(_ other: ClosedRange<Bound>) -> [ClosedRange<Bound>] {
        guard let intersect = intersect(other) else {
            return [self]
        }

        var extraRanges: [ClosedRange<Bound>] = []

        if lowerBound < intersect.lowerBound {
            extraRanges.append((lowerBound...intersect.lowerBound.advanced(by: -1)))
        }

        if upperBound > intersect.upperBound {
            extraRanges.append((intersect.upperBound.advanced(by: 1)...upperBound))
        }

        return extraRanges.compactMap { $0 }
    }
}


public extension ClosedRange where Bound == Int {
    subscript(index: Int) -> Int {
        return lowerBound + index
    }

    func index(of value: Int) -> Int? {
        if value < lowerBound || value > upperBound {
            return nil
        }

        return value - lowerBound
    }
}
