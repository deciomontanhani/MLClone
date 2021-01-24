public protocol ViewCode: class {
    func buildHierarchy()
    func buildConstraints()
    func additionalSetup()
    func buildViewCode()
}

public extension ViewCode {
    func buildViewCode() {
        buildHierarchy()
        buildConstraints()
        additionalSetup()
    }

    func additionalSetup() { }
}
