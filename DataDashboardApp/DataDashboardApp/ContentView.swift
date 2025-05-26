//
//  ContentView.swift
//  DataDashboardApp
//
//  Created by Sanjay Nelagadde on 26/5/25.
//

import SwiftUI
import Charts

struct ContentView: View {
    var body: some View {
        TabView {
            LineChartView()
                .tabItem {
                    Label("Trends", systemImage: "chart.xyaxis.line")
                }
            
            BarChartView()
                .tabItem {
                    Label("Comparison", systemImage: "chart.bar")
                }
            
            PieChartView()
                .tabItem {
                    Label("Distribution", systemImage: "chart.pie")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
