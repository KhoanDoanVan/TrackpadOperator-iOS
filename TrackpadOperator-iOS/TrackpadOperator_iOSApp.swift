//
//  TrackpadOperator_iOSApp.swift
//  TrackpadOperator-iOS
//
//  Created by Đoàn Văn Khoan on 15/2/25.
//

import SwiftUI

@main
struct TrackpadOperator_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            Home()
                .ignoresSafeArea(.all)
                .onAppear {
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
                }
        }
    }
}
