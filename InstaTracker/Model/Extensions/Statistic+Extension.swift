//
//  Statistic+Extension.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 30.11.2020.
//

import Foundation
import Charts

extension Array where Element == Statistic {
    func toChartDataEntries() -> [ChartDataEntry] {
        var result = [ChartDataEntry]()

        for statistic in self {
            let timeIntervalForDate: TimeInterval = statistic.date!.timeIntervalSince1970
            let dataEntry = ChartDataEntry(x: Double(timeIntervalForDate), y: Double(statistic.count))

            result.append(dataEntry)
        }
        
        return result
    }
}
