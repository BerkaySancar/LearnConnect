//
//  SimpleDonutChart.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 25.11.2024.
//

import Charts
import SwiftUI

struct SimpleDonutChart: View {
    let completed: Double
    let total: Double
    
    var remaining: Double {
        max(total - completed, 0)
    }
    
    var body: some View {
        Chart {
            SectorMark(
                angle: .value("Completed", completed),
                innerRadius: .ratio(0.5),
                outerRadius: .ratio(1.0)
            )
            .foregroundStyle(.appGreen)
            
            SectorMark(
                angle: .value("Remaining", remaining),
                innerRadius: .ratio(0.5),
                outerRadius: .ratio(1.0)
            )
            .foregroundStyle(.orange)
        }
        .frame(height: 100)
        .padding()
    }
}

#Preview {
    SimpleDonutChart(completed: 1, total: 3)
}
