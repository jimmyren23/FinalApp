//
//  ViewController.swift
//  RecipeFinder
//
//  Created by Jimmy Ren on 12/4/20.
//

import UIKit
import Charts

class CalorieChartViewController: UIViewController {

    @IBOutlet var LineChartView: LineChartView!
    var dailyCal: [Double] = []
    
    override func viewDidLoad() {
        dailyCal = MyMealPlan.getCalsForEachDay()
        super.viewDidLoad()
        setData()
        LineChartView.noDataText = "Sad, No Data provided!"
        LineChartView.backgroundColor = .systemPink
        LineChartView.rightAxis.enabled = false
        // Do any additional setup after loading the view.

    }
    func setData() {
        var yValues: [ChartDataEntry] = []
        for i in 0...6 {
            yValues.append(ChartDataEntry.init(x: Double(i), y: dailyCal[i]))
        }
        let set1 = LineChartDataSet.init(entries: yValues, label: "Test")
        let data = LineChartData(dataSet: set1)
        LineChartView.data = data
    }

    
}

