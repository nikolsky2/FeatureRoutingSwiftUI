import SwiftUI

public
struct PieChartViewModel: Decodable, Hashable {
    let value: Double
    let name: String
    let color: Color

    public
    init(value: Double, name: String, color: Color) {
        self.value = value
        self.name = name
        self.color = color
    }
}

fileprivate extension Color {
    #if os(macOS)
    typealias SystemColor = NSColor
    #else
    typealias SystemColor = UIColor
    #endif

    var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        #if os(macOS)
        SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        // Note that non RGB color will raise an exception, that I don't now how to catch because it is an Objc exception.
        #else
        guard SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            // Pay attention that the color should be convertible into RGB format
            // Colors using hue, saturation and brightness won't work
            return nil
        }
        #endif

        return (r, g, b, a)
    }
}

extension Color: Codable {
    enum CodingKeys: String, CodingKey {
        case red, green, blue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let r = try container.decode(Double.self, forKey: .red)
        let g = try container.decode(Double.self, forKey: .green)
        let b = try container.decode(Double.self, forKey: .blue)

        self.init(red: r, green: g, blue: b)
    }

    public func encode(to encoder: Encoder) throws {
        guard let colorComponents = self.colorComponents else {
            return
        }

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(colorComponents.red, forKey: .red)
        try container.encode(colorComponents.green, forKey: .green)
        try container.encode(colorComponents.blue, forKey: .blue)
    }
}

public
struct PieChartView: View {
    let viewModels: [PieChartViewModel]

    public init(viewModels: [PieChartViewModel]) {
        self.viewModels = viewModels
    }

    private var slices: [PieSliceData] {
        let sum = viewModels.map { $0.value }.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        for viewModel in viewModels {
            let degrees: Double = viewModel.value * 360 / sum
            let data = PieSliceData(startAngle: Angle(degrees: endDeg),
                                    endAngle: Angle(degrees: endDeg + degrees),
                                    text: viewModel.name,
                                    color: viewModel.color)
            tempSlices.append(data)
            endDeg += degrees
        }
        return tempSlices
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack{
                ZStack{
                    ForEach(0..<viewModels.count) { i in
                        PieSlice(pieSliceData: self.slices[i])
                    }
                }
            }
        }
    }
}

private let mockPieChartViewModels = [
    PieChartViewModel(value: 2, name: "Rent", color: .blue),
    PieChartViewModel(value: 3, name: "Transport", color: .green),
    PieChartViewModel(value: 10, name: "Education", color: .orange)
]

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(viewModels: mockPieChartViewModels)
    }
}
