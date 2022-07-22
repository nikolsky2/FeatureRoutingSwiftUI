import Foundation

public
struct DetailsViewModel: Hashable, Identifiable {
    public let id: UUID
    public let title: String
    public let subtitle: String

    public
    init(id: UUID, title: String, subtitle: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
    }
}
