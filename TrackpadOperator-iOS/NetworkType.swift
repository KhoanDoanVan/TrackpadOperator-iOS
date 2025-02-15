//
//  NetworkType.swift
//  TrackpadOperator-iOS
//
//  Created by Đoàn Văn Khoan on 15/2/25.
//

import SwiftUI
import Foundation

enum TypeNetwork {
    case wifi
    case cellular
    case notConnection
    
    /// Title
    var title: String {
        switch self {
        case .wifi:
            return "Wifi"
        case .cellular:
            return "Cellular Data"
        case .notConnection:
            return "Not Connection"
        }
    }
    
    /// Icon
    var icon: String {
        switch self {
        case .wifi:
            return "wifi"
        case .cellular:
            return "chart.bar.fill"
        case .notConnection:
            return "wifi.slash"
        }
    }
    
    /// Color
    var color: Color {
        switch self {
        case .wifi:
            return .blue
        case .cellular:
            return .green
        case .notConnection:
            return .red
        }
    }
}
