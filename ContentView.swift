//
// ContentView.swift
//
// Created by Speedyfriend67 on 19.06.24
//
 
import SwiftUI
import Photos

extension View {
    func asImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

struct ContentView: View {
    @State private var red1: Double = 1.0
    @State private var green1: Double = 0.0
    @State private var blue1: Double = 0.0
    @State private var red2: Double = 0.0
    @State private var green2: Double = 0.0
    @State private var blue2: Double = 1.0
    @State private var isRadial: Bool = false
    @State private var startX: Double = 0.0
    @State private var startY: Double = 0.0
    @State private var endX: Double = 1.0
    @State private var endY: Double = 1.0
    @State private var isExpandedColor: Bool = true
    @State private var isExpandedStart: Bool = false
    @State private var isExpandedEnd: Bool = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                GradientView(
                    startColor: .constant(UIColor(red: red1, green: green1, blue: blue1, alpha: 1)),
                    endColor: .constant(UIColor(red: red2, green: green2, blue: blue2, alpha: 1)),
                    isRadial: $isRadial,
                    startPoint: .constant(CGPoint(x: startX, y: startY)),
                    endPoint: .constant(CGPoint(x: endX, y: endY))
                )
                .frame(height: 300)
                .cornerRadius(20)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(20)
                .shadow(radius: 10)
                
                Toggle(isOn: $isRadial) {
                    Text("Radial Gradient")
                        .font(.headline)
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .shadow(radius: 5)
                
                DisclosureGroup("Adjust Colors", isExpanded: $isExpandedColor) {
                    VStack(spacing: 10) {
                        ColorSlider(value: $red1, textColor: .red, label: "Red 1")
                        ColorSlider(value: $green1, textColor: .green, label: "Green 1")
                        ColorSlider(value: $blue1, textColor: .blue, label: "Blue 1")
                        
                        ColorSlider(value: $red2, textColor: .red, label: "Red 2")
                        ColorSlider(value: $green2, textColor: .green, label: "Green 2")
                        ColorSlider(value: $blue2, textColor: .blue, label: "Blue 2")
                    }
                    .padding()
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .shadow(radius: 5)
                
                DisclosureGroup("Adjust Start Point", isExpanded: $isExpandedStart) {
                    VStack(spacing: 10) {
                        HStack {
                            Text("X: \(String(format: "%.2f", startX))")
                                .font(.headline)
                            Slider(value: $startX, in: 0...1)
                                .accentColor(.blue)
                        }
                        HStack {
                            Text("Y: \(String(format: "%.2f", startY))")
                                .font(.headline)
                            Slider(value: $startY, in: 0...1)
                                .accentColor(.blue)
                        }
                    }
                    .padding()
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .shadow(radius: 5)
                
                DisclosureGroup("Adjust End Point", isExpanded: $isExpandedEnd) {
                    VStack(spacing: 10) {
                        HStack {
                            Text("X: \(String(format: "%.2f", endX))")
                                .font(.headline)
                            Slider(value: $endX, in: 0...1)
                                .accentColor(.blue)
                        }
                        HStack {
                            Text("Y: \(String(format: "%.2f", endY))")
                                .font(.headline)
                            Slider(value: $endY, in: 0...1)
                                .accentColor(.blue)
                        }
                    }
                    .padding()
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .shadow(radius: 5)
                
                Button(action: saveGradient) {
                    Text("Save Gradient")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()
            }
            .padding()
            .background(Color(UIColor.systemBackground))
        }
        .edgesIgnoringSafeArea(.bottom)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Save Gradient"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func saveGradient() {
        let image = self.body.asImage()
        requestPhotoLibraryAccess { granted in
            if granted {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                alertMessage = "Gradient saved to Photos."
            } else {
                alertMessage = "Access to Photos denied."
            }
            showAlert = true
        }
    }
    
    func requestPhotoLibraryAccess(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            completion(true)
        case .denied, .restricted:
            completion(false)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                completion(newStatus == .authorized)
            }
        case .limited:
            completion(true)
        @unknown default:
            completion(false)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}