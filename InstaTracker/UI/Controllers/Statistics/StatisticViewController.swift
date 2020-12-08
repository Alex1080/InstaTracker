//
//  StatisticViewController.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 27.11.2020.
//

import Foundation
import UIKit
import Charts

class StatisticViewController: UIViewController {
    var lineChartView: LineChartView = {
        let chartView = LineChartView()

        chartView.rightAxis.enabled = false
        
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.granularity = 1.0
        
        let xAxis = chartView.xAxis
        xAxis.valueFormatter = XAxisFormatter()
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .boldSystemFont(ofSize: 12)
        xAxis.granularity = 5 * 60
        
        chartView.animate(xAxisDuration: 2.5)
        
        return chartView
    }()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        prepareDataSets()
    }
    
    private func prepareDataSets() {
        let followersDataEntries = Storage.shared.loadFollowingStatistic().toChartDataEntries()
        let followersSet = LineChartDataSet(entries: followersDataEntries, label: "Followers")
        followersSet.circleColors = [.orange]
        followersSet.mode = .cubicBezier
        followersSet.lineWidth = 3
        followersSet.setColor(.orange)
        
        let followingDataEntries = Storage.shared.loadFollowedStatistic().toChartDataEntries()
        let followingSet = LineChartDataSet(entries: followingDataEntries, label: "Following")
        followingSet.circleColors = [.systemBlue]
        followingSet.mode = .cubicBezier
        followingSet.lineWidth = 3
        followingSet.setColor(.systemBlue)
        
        let data = LineChartData(dataSets: [followersSet, followingSet])
        data.setDrawValues(false)
        
        lineChartView.data = data
    }
}
