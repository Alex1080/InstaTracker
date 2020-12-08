//
//  StatisticViewController+SetupViews.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 27.11.2020.
//

import Foundation
import UIKit

extension StatisticViewController {
    func setupViews() {
        addViews()
        constraintSubviews()
    }

    fileprivate func addViews() {
        view.addSubview(lineChartView)
    }

    fileprivate func constraintSubviews() {
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineChartView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            lineChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            lineChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            lineChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
}
