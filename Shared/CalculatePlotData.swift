//
//  CalculatePlotData.swift
//  SwiftUICorePlotExample
//
//  Created by Jeff Terry on 12/22/20.
//

import Foundation
import SwiftUI
import CorePlot

class CalculatePlotData: ObservableObject {
    
    var plotDataModel: PlotDataClass? = nil
    
    var differences = [Double]()
    //i think these two may not be useful where they currently are in quadraticFormulas
    var arrayXplusComparison = [String]()
    var arrayXsubComparison = [String]()
    

    func quadraticFormulas(a: Double, b: Double, c: Double) {
                
        //the square root term is the same in all equations
        let xSqrtTerm = b * b - 4.0 * a * c
        
        //the traditional quadratic formula, positive and negative sqrt
        let xplus = (-b + xSqrtTerm.squareRoot()) / (2.0 * a)
        let xsub = (-b - xSqrtTerm.squareRoot()) / (2.0 * a)
        
        //xp for x prime
        let xpplus = (-2.0 * c) / (b + xSqrtTerm.squareRoot())
        let xpsub = (-2.0 * c) / (b - xSqrtTerm.squareRoot())
        
        //calculate difference between the two methods and store into array
        differences = [abs(xplus-xpplus), abs(xsub-xpsub)]
        
        //I think these may not be useful
        arrayXplusComparison.append(String(differences[0]))
        arrayXsubComparison.append(String(differences[1]))
        
    }
    
    func PlotPlus() {
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 10.0
        plotDataModel!.changingPlotParameters.yMin = -5.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
        plotDataModel!.changingPlotParameters.xLabel = "n"
        plotDataModel!.changingPlotParameters.yLabel = "x-x'"
        plotDataModel!.changingPlotParameters.lineColor = .red()
        plotDataModel!.changingPlotParameters.title = "quadratic formula"
        
        plotDataModel!.zeroData()
        var plotData :[plotDataType] =  []
        
        for n in 1..<11 {
        
            let cInLoop = pow(10.0, -Double(n))

            quadraticFormulas(a: 1.0, b: 1.0, c: cInLoop)
    
            //ok this should plot x - x' for the positive square root
            let dataPoint: plotDataType = [.X: Double(n), .Y: differences[0]]
            plotData.append(contentsOf: [dataPoint])
        
            plotDataModel!.calculatedText += "\(Double(n))\t\(differences[0])\n"
        
        }
    
    /*
    //going to delete this after I figure out how to plot in other function
    func plotYEqualsX()
    {
        
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 10.0
        plotDataModel!.changingPlotParameters.yMin = -5.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
        plotDataModel!.changingPlotParameters.xLabel = "x"
        plotDataModel!.changingPlotParameters.yLabel = "y"
        plotDataModel!.changingPlotParameters.lineColor = .red()
        plotDataModel!.changingPlotParameters.title = " y = x"
        
        plotDataModel!.zeroData()
        var plotData :[plotDataType] =  []
        
        
        for i in 0 ..< 120 {

            //create x values here

            let x = -2.0 + Double(i) * 0.2

            //create y values here

            let y = x


            let dataPoint: plotDataType = [.X: x, .Y: y]
            plotData.append(contentsOf: [dataPoint])
            
            plotDataModel!.calculatedText += "\(x)\t\(y)\n"
        
        }
        
        plotDataModel!.appendData(dataPoint: plotData)
        
    }
    
    
    func ploteToTheMinusX()
    {
        
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 10
        plotDataModel!.changingPlotParameters.yMin = -3.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -3.0
        plotDataModel!.changingPlotParameters.xLabel = "x"
        plotDataModel!.changingPlotParameters.yLabel = "y = exp(-x)"
        plotDataModel!.changingPlotParameters.lineColor = .blue()
        plotDataModel!.changingPlotParameters.title = "exp(-x)"

        plotDataModel!.zeroData()
        var plotData :[plotDataType] =  []
        for i in 0 ..< 60 {

            //create x values here

            let x = -2.0 + Double(i) * 0.2

        //create y values here

        let y = exp(-x)
            
            let dataPoint: plotDataType = [.X: x, .Y: y]
            plotData.append(contentsOf: [dataPoint])
            
            plotDataModel!.calculatedText += "\(x)\t\(y)\n"
            
        }
        
        plotDataModel!.appendData(dataPoint: plotData)
        
        return*/
    }
    
}



