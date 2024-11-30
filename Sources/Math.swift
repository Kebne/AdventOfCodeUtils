import Foundation

public func mod(_ a: Int, _ n: Int) -> Int {
    assert(n > 0, "modulus must be positive")
    let r = a % n
    return r >= 0 ? r : r + n
}

public func gcd(_ x: Int, _ y: Int) -> Int {
    var a = 0
    var b = max(x, y)
    var r = min(x, y)

    while r != 0 {
        a = b
        b = r
        r = a % b
    }
    return b
}

public func lcm(_ x: Int, _ y: Int) -> Int {
    return x / gcd(x, y) * y
}
