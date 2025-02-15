//
//  TrackpadView.swift
//  TrackpadOperator-iOS
//
//  Created by Đoàn Văn Khoan on 15/2/25.
//

import SwiftUI

struct TrackpadView: View {
    
    let destinationIP: String
    @State private var udpSender: UDPSender?
    @State private var errorMessage: String?
    @State private var showErrorAlert: Bool = false
    
    var body: some View {
        VStack {
            Color.blue.opacity(0.3).edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            udpSender = UDPSender(destinationIP: destinationIP, errorHandler: { error in
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.showErrorAlert = true
                }
            })
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("UDP Error"), message: Text(errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    TrackpadView(destinationIP: "")
}
