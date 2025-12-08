
import Foundation

public extension String {
    var lines: [String] {
        components(separatedBy: "\n")
    }
}

public extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
}
