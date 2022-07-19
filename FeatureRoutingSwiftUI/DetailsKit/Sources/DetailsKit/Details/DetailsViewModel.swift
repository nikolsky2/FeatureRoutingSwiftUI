import Foundation

public
struct DetailsViewModel: Hashable, Identifiable {
    public var id = UUID()
    public let title: String
    public let subtitle: String

    public
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}
