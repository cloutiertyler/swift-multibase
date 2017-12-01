import XCTest
@testable import Multibase

let sampleBytes = Data("Decentralize everything!!!".utf8)
let encodedSamples: [BaseEncoding:String] = [
    .identity: String(bytes: ([BaseEncoding.identity.rawValue] + sampleBytes), encoding: String.Encoding.utf8)!,
    .base16: "f446563656e7472616c697a652065766572797468696e67212121",
    .base16Upper: "F446563656E7472616C697A652065766572797468696E67212121",
// TODO: Implement no padding
//    .base32: "birswgzloorzgc3djpjssazlwmvzhs5dinfxgoijbee",
//    .base32Upper: "BIRSWGZLOORZGC3DJPJSSAZLWMVZHS5DINFXGOIJBEE",
    .base32Pad: "cirswgzloorzgc3djpjssazlwmvzhs5dinfxgoijbee======",
    .base32PadUpper: "CIRSWGZLOORZGC3DJPJSSAZLWMVZHS5DINFXGOIJBEE======",
// TODO: Implement no padding
//    .base32Hex: "v8him6pbeehp62r39f9ii0pbmclp7it38d5n6e89144",
//    .base32HexUpper: "V8HIM6PBEEHP62R39F9II0PBMCLP7IT38D5N6E89144",
    .base32HexPad: "t8him6pbeehp62r39f9ii0pbmclp7it38d5n6e89144======",
    .base32HexPadUpper: "T8HIM6PBEEHP62R39F9II0PBMCLP7IT38D5N6E89144======",
    .base58BTC: "z36UQrhJq9fNDS7DiAHM9YXqDHMPfr4EMArvt",
    .base64Pad: "MRGVjZW50cmFsaXplIGV2ZXJ5dGhpbmchISE=",
    .base64URLPad: "URGVjZW50cmFsaXplIGV2ZXJ5dGhpbmchISE=",
]

class MultibaseTests: XCTestCase {

    func testEncode() {
        for (encoding, expected) in encodedSamples {
            let actual = sampleBytes.multibaseEncodedString(inBase: encoding)
            XCTAssertEqual(actual, expected, "Encoding: \(encoding)")
        }
    }

    func testDecode() {
        for (expectedEncoding, string) in encodedSamples {
            let actualData = Data(multibaseEncoded: string)
            let actualEncoding = string.baseEncoding
            let expectedData = sampleBytes
            XCTAssertEqual(actualData, expectedData, "Encoding: \(expectedEncoding)")
            XCTAssertEqual(actualEncoding, expectedEncoding, "Encoding: \(expectedEncoding)")
        }
    }

    func testRoundTrip() {
        let bases = encodedSamples.keys
        var bytes = sampleBytes
        for base in bases {
            let string = bytes.multibaseEncodedString(inBase: base)
            XCTAssertEqual(string.baseEncoding, base)
            bytes = Data(multibaseEncoded: string)!
        }
        XCTAssertEqual(bytes, sampleBytes)
    }

    static var allTests = [
        "testEncode": testEncode,
        "testDecode": testDecode,
        "testRoundTrip": testRoundTrip,
    ]
}
