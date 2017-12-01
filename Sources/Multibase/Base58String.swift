import Foundation
import BigInt

public enum Base58String {
    public static let btcAlphabet = [UInt8]("123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".utf8)
    public static let flickrAlphabet = [UInt8]("123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ".utf8)
}

public extension Data {

    public init?(base58Encoded string: String, alphabet: [UInt8] = Base58String.btcAlphabet) {
        var answer = BigUInt(0)
        var j = BigUInt(1)
        let radix = BigUInt(alphabet.count)
        let byteString = [UInt8](string.utf8)

        for ch in byteString.reversed() {
            if let index = alphabet.index(of: ch) {
                answer = answer + (j * BigUInt(index))
                j *= radix
            } else {
                return nil
            }
        }

        let bytes = answer.serialize()
        self = byteString.prefix(while: { i in i == alphabet[0]}) + bytes
    }

    public init?(base58Encoded data: Data, alphabet: [UInt8] = Base58String.btcAlphabet) {
        guard let string = String(data: data, encoding: .utf8) else {
            return nil
        }
        self.init(base58Encoded: string, alphabet: alphabet)
    }

    public func base58EncodedString(alphabet: [UInt8] = Base58String.btcAlphabet) -> String {
        var x = BigUInt(self)
        let radix = BigUInt(alphabet.count)

        var answer = [UInt8]()
        answer.reserveCapacity(self.count)

        while x > 0 {
            let (quotient, modulus) = x.quotientAndRemainder(dividingBy: radix)
            answer.append(alphabet[Int(modulus)])
            x = quotient
        }

        let prefix = Array(self.prefix(while: {$0 == 0})).map { _ in alphabet[0] }
        answer.append(contentsOf: prefix)
        answer.reverse()

        return String(bytes: answer, encoding: String.Encoding.utf8)!
    }

    public func base58EncodedData() -> Data {
        return self.base58EncodedString().data(using: .utf8)!
    }

}

