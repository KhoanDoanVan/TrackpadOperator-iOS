//
//  HomeViewModel.swift
//  TrackpadOperator-iOS
//
//  Created by Đoàn Văn Khoan on 15/2/25.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var openNetworkSheet: Bool = false
    @Published var openConnection: Bool = false
    @Published var scannedIP: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Close the connection screen when an IP is scanned
        $scannedIP
            .compactMap { $0 } // Ignore nil values
            .sink { _ in
                self.openConnection = false
            }
            .store(in: &cancellables)
    }
}
