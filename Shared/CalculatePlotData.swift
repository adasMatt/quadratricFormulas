//
//  CalculatePlotData.swift
//  SwiftUICorePlotExample
//
//  Created by Matt Adas.
//

//search "trying to plot just xPlusDiff part instead of the entire tuple now"

import Foundation
import SwiftUI
import CorePlot

class CalculatePlotData: ObservableObject {
    
    var plotDataModel: PlotDataClass? = nil
    
    //resultsTuple is only one tuple with one value for each variable in it. It is calculated in a for loop w/ n = 1,2,3,...
    var resultsTuple: (n: Double, xplus: Double, xPrimePlus: Double, xPlusDiff: Double, xsub: Double, xPrimeSub: Double, xSubDiff: Double) = (n: 0.0, xplus: 0.0, xPrimePlus: 0.0, xPlusDiff: 0.0, xsub: 0.0, xPrimeSub: 0.0, xSubDiff: 0.0)
    
    //arrayOfResults is appended with each individual resultsTuple
    var arrayOfResults: [(n: Double, xplus: Double, xPrimePlus: Double, xPlusDiff: Double, xsub: Double, xPrimeSub: Double, xSubDiff: Double)] = []
    
    //this function calculates all variations of the quadratic formula and takes the difference of x and x'
    func quadraticFormulas(a: Double, b: Double, c: Double) -> (xplus: Double, xPrimePlus: Double, xPlusDiff: Double, xsub: Double, xPrimeSub: Double, xSubDiff: Double){
                
        //the square root term is the same in all equations
        let xSqrtTerm = b * b - 4.0 * a * c
        
        //the traditional quadratic formula, positive and negative sqrt
        let xplus = (-b + xSqrtTerm.squareRoot()) / (2.0 * a)
        let xsub = (-b - xSqrtTerm.squareRoot()) / (2.0 * a)
        
        //xp for x prime
        let xPrimePlus = (-2.0 * c) / (b + xSqrtTerm.squareRoot())
        let xPrimeSub = (-2.0 * c) / (b - xSqrtTerm.squareRoot())
        
        //calculate difference between the two methods and store into array
        let plusDifference = abs(xplus-xPrimePlus)
        let subDifference = abs(xsub-xPrimeSub)
        
        //this return becomes returnTuple
        return (xplus: xplus, xPrimePlus: xPrimePlus, xPlusDiff: plusDifference, xsub: xsub, xPrimeSub: xPrimeSub, xSubDiff: subDifference)
    }
    
    func PlotPlus() {
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 0.50
        plotDataModel!.changingPlotParameters.yMin = -0.50
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
        plotDataModel!.changingPlotParameters.xLabel = "n"
        plotDataModel!.changingPlotParameters.yLabel = "x-x'"
        plotDataModel!.changingPlotParameters.lineColor = .red()
        plotDataModel!.changingPlotParameters.title = "plus sqrt term"
        plotDataModel!.zeroData()
        
        var plotData :[plotDataType] =  []
        
        for n in 1..<11 {
        
            let cInLoop = pow(10.0, -Double(n))

            //returnTuple just gives one value for each variable to the resultsTuple
            let returnTuple: (xplus: Double, xPrimePlus: Double, xPlusDiff: Double, xsub: Double, xPrimeSub: Double, xSubDiff: Double) = quadraticFormulas(a: 1.0, b: 1.0, c: cInLoop)
            
            //could I not skip resultsTuple completely and just append returnTuple to arrayOfResults?
            resultsTuple.n = Double(n)
            resultsTuple.xplus = returnTuple.xplus
            resultsTuple.xPrimePlus = returnTuple.xPrimePlus
            resultsTuple.xPlusDiff = returnTuple.xPlusDiff
            resultsTuple.xsub = returnTuple.xsub
            resultsTuple.xPrimeSub = returnTuple.xPrimeSub
            resultsTuple.xSubDiff = returnTuple.xSubDiff
            
            arrayOfResults.append(resultsTuple)
    
            //ok this should plot x - x' for the positive square root
            //trying to plot just xPlusDiff part instead of the entire tuple now
            
            //what if I scale xPlusDiff by e17 since the values are on the order of e-17 and smaller?
            let dataPoint: plotDataType = [.X: Double(n), .Y: resultsTuple.xPlusDiff * pow(10.0, 17.0)]
            plotData.append(contentsOf: [dataPoint])
        
            plotDataModel!.calculatedText += "\(Double(n))\t\(arrayOfResults[n-1])\n"
        
            //print("I'm so cool and I should be plotting y = \(resultsTuple.xPlusDiff * pow(10.0, 17.0)) (scaled by 10^17) and x = \(n)")
        }
        
        //print(arrayOfResults)
    }
    
    func PlotSub() {
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 10.0
        plotDataModel!.changingPlotParameters.yMin = -5.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
        plotDataModel!.changingPlotParameters.xLabel = "n"
        plotDataModel!.changingPlotParameters.yLabel = "x-x'"
        plotDataModel!.changingPlotParameters.lineColor = .red()
        plotDataModel!.changingPlotParameters.title = "subtract sqrt term"
        plotDataModel!.zeroData()
        
        var plotData :[plotDataType] =  []
        
        for n in 1..<11 {
        
            //let cInLoop = pow(10.0, -Double(n))

            //quadraticFormulas(a: 1.0, b: 1.0, c: cInLoop)
    
            //ok this should plot x - x' for the positive square root
            let dataPoint: plotDataType = [.X: Double(n), .Y: 1.0]
            plotData.append(contentsOf: [dataPoint])
        
            plotDataModel!.calculatedText += "\(Double(n))\t\(arrayOfResults[1])\n"
        
        }
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
        
        return
        } */
    
}



