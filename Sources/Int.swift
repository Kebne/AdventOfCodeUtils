import Foundation

public extension Int {
    func expo(_ power: Int) -> Int {
        var result = 1
        var powerNum = power
        var tempExpo = self
        while powerNum != 0 {
            if powerNum % 2 == 1 {
                result *= tempExpo
            }
            powerNum /= 2
            tempExpo *= tempExpo
        }
        return result
    }

    var numberOfDigits: Int {
        numberOfDigits(in: self)
    }

    private func numberOfDigits(in number: Int) -> Int {
        if number < 10 && number >= 0 || number > -10 && number < 0 {
            return 1
        } else {
            return 1 + numberOfDigits(in: number / 10)
        }
    }
}

infix operator %%

public extension Int {
    /// Non-negative modulus
    static func %% (_ left: Int, _ right: Int) -> Int {
        let mod = left % right
        return mod >= 0 ? mod : mod + right
    }
}
