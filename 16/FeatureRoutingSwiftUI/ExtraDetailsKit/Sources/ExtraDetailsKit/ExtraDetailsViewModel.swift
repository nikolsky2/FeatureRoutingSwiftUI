import Foundation
import UIExtensionsKit

public
struct ExtraDetailsViewModel: Hashable, Identifiable {
    public let id: UUID
    public let title: String
    public let pieChartViewModels: [PieChartViewModel]

    public
    init(id: UUID, title: String, pieChartViewModels: [PieChartViewModel]) {
        self.id = id
        self.title = title
        self.pieChartViewModels = pieChartViewModels
    }
}
