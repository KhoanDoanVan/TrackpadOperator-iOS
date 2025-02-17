//
//  TrackpadView.swift
//  TrackpadOperator-iOS
//
//  Created by Đoàn Văn Khoan on 15/2/25.
//

import SwiftUI

struct TrackpadView: UIViewControllerRepresentable {
    
    let onHandler: (String, MethodHandle) -> Void
    
    func makeUIViewController(context: Context) -> TrackpadVC {
        return TrackpadVC(onHandler: onHandler)
    }

    func updateUIViewController(_ uiViewController: TrackpadVC, context: Context) {}
}

#Preview {
//    TrackpadView(destinationIP: "")
    TrackpadView() { message, method in
        
    }
}
