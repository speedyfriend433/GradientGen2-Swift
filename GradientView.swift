//
// GradientView.swift
//
// Created by Speedyfriend67 on 20.06.24
//
 
import SwiftUI
import UIKit

class CoreGraphicsGradientView: UIView {
    var startColor: UIColor = .red
    var endColor: UIColor = .blue
    var isRadial: Bool = false
    var startPoint: CGPoint = .zero
    var endPoint: CGPoint = CGPoint(x: 1, y: 1)
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let colors = [startColor.cgColor, endColor.cgColor] as CFArray
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: colorLocations) else { return }
        
        if isRadial {
            let center = CGPoint(x: bounds.midX, y: bounds.midY)
            let radius = min(bounds.width, bounds.height) / 2
            context.drawRadialGradient(gradient, startCenter: center, startRadius: 0, endCenter: center, endRadius: radius, options: [])
        } else {
            let adjustedStartPoint = CGPoint(x: startPoint.x * bounds.width, y: startPoint.y * bounds.height)
            let adjustedEndPoint = CGPoint(x: endPoint.x * bounds.width, y: endPoint.y * bounds.height)
            context.drawLinearGradient(gradient, start: adjustedStartPoint, end: adjustedEndPoint, options: [])
        }
    }
}

struct GradientView: UIViewRepresentable {
    @Binding var startColor: UIColor
    @Binding var endColor: UIColor
    @Binding var isRadial: Bool
    @Binding var startPoint: CGPoint
    @Binding var endPoint: CGPoint
    
    func makeUIView(context: Context) -> CoreGraphicsGradientView {
        let view = CoreGraphicsGradientView()
        return view
    }
    
    func updateUIView(_ uiView: CoreGraphicsGradientView, context: Context) {
        uiView.startColor = startColor
        uiView.endColor = endColor
        uiView.isRadial = isRadial
        uiView.startPoint = startPoint
        uiView.endPoint = endPoint
        uiView.setNeedsDisplay()
    }
    
    func snapshot() -> UIImage? {
        let view = CoreGraphicsGradientView()
        view.startColor = startColor
        view.endColor = endColor
        view.isRadial = isRadial
        view.startPoint = startPoint
        view.endPoint = endPoint
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        return renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
    }
}

struct GradientView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView(
            startColor: .constant(UIColor.red),
            endColor: .constant(UIColor.blue),
            isRadial: .constant(false),
            startPoint: .constant(CGPoint(x: 0, y: 0)),
            endPoint: .constant(CGPoint(x: 1, y: 1))
        )
        .frame(height: 300)
    }
}
