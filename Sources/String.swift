
import Foundation

public extension String {
    var lines: [String] {
        components(separatedBy: "\n")
    }
}
