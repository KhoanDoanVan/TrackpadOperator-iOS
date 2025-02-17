//
//  TrackpadVC.swift
//  TrackpadOperator-iOS
//
//  Created by Đoàn Văn Khoan on 17/2/25.
//

import UIKit

class TrackpadVC: UIViewController {
    
    // MARK: - Properties
    let onHandler: (String) -> Void
    
    // MARK: - Initialize
    init(onHandler: @escaping (String) -> Void) {
        self.onHandler = onHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupGestures()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .gray
    }
    
    /// Full screen
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    
    // MARK: - Setup Gestures
    private func setupGestures() {
        
        /// Pan(Move Cursor)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        
        /// Single-Tap(Left Click)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        view.addGestureRecognizer(singleTap)
        
        /// Double-Tap
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
        
        /// 2 Fingers Scroll
        let twoFingersScroll = UIPanGestureRecognizer(target: self, action: #selector(handleTwoFingersScroll))
        twoFingersScroll.maximumNumberOfTouches = 2
        twoFingersScroll.minimumNumberOfTouches = 2
        view.addGestureRecognizer(twoFingersScroll)
        
        /// 4 Fingers Swipe (Switch Windows)
        let fourFingersSwipe = UIPanGestureRecognizer(target: self, action: #selector(handleFourFingersSwipe))
        fourFingersSwipe.maximumNumberOfTouches = 4
        fourFingersSwipe.minimumNumberOfTouches = 4
        view.addGestureRecognizer(fourFingersSwipe)
        
        /// Pinch(zoom in/out)
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        view.addGestureRecognizer(pinchGesture)
        
        /// 3 Fingers Drag (highlight, trigger an action)
        let threeFingersDrag = UIPanGestureRecognizer(target: self, action: #selector(handleThreeFingersDrag))
        threeFingersDrag.maximumNumberOfTouches = 3
        threeFingersDrag.minimumNumberOfTouches = 3
        view.addGestureRecognizer(threeFingersDrag)

    }
    
    // MARK: - Gestures
    
    /// Pan
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        print("Pan( x:\(location.x) - y: \(location.y) )")
        onHandler("Move cursor 🫵")
        
    }
    
    /// Single-Tap
    @objc private func handleSingleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        print("Single_Tap( x: \(location.x) - y: \(location.y) )")
        onHandler("Single Tap 🖕")
    }
    
    /// Double-Tap
    @objc private func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        print("Double_Tap( x: \(location.x) - y: \(location.y) )")
        onHandler("Double Tap ✌️")
    }
    
    /// 2 Fingers Scroll
    @objc private func handleTwoFingersScroll(_ gesture: UIPanGestureRecognizer) {
        let velocity = gesture.velocity(in: view)
        
        if gesture.state == .changed {
            
            if abs(velocity.y) > abs(velocity.x) { /// Velocity
                
                if velocity.y > 0 {
                    onHandler("Scroll Up 👆")
                } else {
                    onHandler("Scroll Down 👇")
                }
                
            }
        }
    }
    
    /// 4 Fingers Swipe
    @objc private func handleFourFingersSwipe(_ gesture: UIPanGestureRecognizer) {
        let velocity = gesture.velocity(in: view)
        
        if gesture.state == .ended {
            
            if abs(velocity.x) > abs(velocity.y) { /// Velocity
                
                if velocity.x > 0 {
                    print("➡️ 4-Finger Swipe Right")
                    onHandler("4-Finger Swipe Right 🤌👉")
                } else {
                    print("⬅️ 4-Finger Swipe Left")
                    onHandler("4-Finger Swipe Left 🤌👈")
                }
                
            } else {
                
                if velocity.y > 0 {
                    print("⬆️ 4-Finger Swipe Up")
                    onHandler("4-Finger Swipe Up 🤌👆")
                } else {
                    print("⬇️ 4-Finger Swipe Down")
                    onHandler("4-Finger Swipe Down 🤌👇")
                }
                
            }
            
        }
    }
    
    /// Pinch in/out
    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        let scale = gesture.scale
        
        if gesture.state == .changed {
            
            if scale > 1.0 {
                print("🔍 Pinch Out (Zoom In)")
                onHandler("Zoom In 🖖")
            } else {
                print("🔍 Pinch In (Zoom Out)")
                onHandler("Zoom Out 🖖")
            }
            
        }
    }
    
    /// 3 Fingers Drag
    @objc private func handleThreeFingersDrag(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        
        switch gesture.state {

        case .began:
            print("🖱️ 3-Finger Drag Started at (x: \(location.x), y: \(location.y))")
            onHandler("3-Finger Drag Started 🤟🖱️")
        case .changed:
            print("👏 3-Finger Drag Moving (x: \(location.x), y: \(location.y))")
            onHandler("3-Finger Drag Moving 🤟👏")
        case .ended:
            print("✅ 3-Finger Drag Ended at (x: \(location.x), y: \(location.y))")
            onHandler("3-Finger Drag Ended 🤟✅")
        default:
            break
        }
    }
}
