//
//  XAxisFormatter.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 27.11.2020.
//

import Foundation
import Charts

class XAxisFormatter: IAxisValueFormatter {
    private let formatter = DateFormatter()

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if axis?.entryCount ?? 0 < 5 {
            formatter.dateFormat = "dd.MM.yyyy\nHH:mm"
        } else {
            formatter.dateFormat = "dd.MM\nHH:mm"
        }
        
        let date = Date(timeIntervalSince1970: value)
        
        return formatter.string(from: date)
    }
}
