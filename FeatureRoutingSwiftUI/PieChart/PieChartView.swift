import SwiftUI

struct PieChartViewModel {
    let value: Double
    let name: String
    let color: Color
}

public struct PieChartView: View {
    let viewModels: [PieChartViewModel]

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
