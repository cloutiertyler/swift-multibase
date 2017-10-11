import Foundation

extension Data {

    init?(base64URLPadEncoded string: String) {
        let base64PadEncoded = string
            .replacingOccurrences(of: "_", with: "/")
            .replacingOccurrences(of: "-", with: "+")
        self.init(base64Encoded: base64PadEncoded)
    }

    func base64URLPadEncodedString() -> String {
        return self.base64EncodedString()
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "+", with: "-")
    }
}
