//
//  ControlView.swift
//  TrackpadOperator-iOS
//
//  Created by Đoàn Văn Khoan on 17/2/25.
//

import SwiftUI

struct ControlView: View {
    
    let destinationIP: String
    @State private var udpSender: UDPSender?
    @State private var errorMessage: String?
    @State private var showErrorAlert: Bool = false
    
    /// TCP
    @StateObject private var client = TCPBonjourClient()
    
    var body: some View {
        
        TrackpadView() { message in
            if client.connection != nil {
                client.sendMessage(message)
            }
        }
        .onAppear {
            /// UDP Sender
            udpSender = UDPSender(destinationIP: destinationIP, errorHandler: { error in
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.showErrorAlert = true
                }
            })
            
            /// TCP Client
            client.startBrowsing()
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("UDP Error"), message: Text(errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
        }
        
    }
}
