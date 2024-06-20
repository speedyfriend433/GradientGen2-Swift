//
// ColorSlider.swift
//
// Created by Speedyfriend67 on 20.06.24
//
 
import SwiftUI

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    var label: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(label): \(Int(value * 255))")
                .foregroundColor(textColor)
                .font(.headline)
            Slider(value: $value)
                .accentColor(textColor)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ColorSlider_Previews: PreviewProvider {
    static var previews: some View {
        ColorSlider(value: .constant(0.5), textColor: .blue, label: "Preview")
            .previewLayout(.sizeThatFits)
    }
}