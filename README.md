# GradientGen2

GradientGen2 is an iOS application that allows users to create and save beautiful gradient backgrounds. Users can customize the gradient colors, direction, and type (linear or radial). The created gradients can be saved to the photo library.

## Features

- Create custom gradients with adjustable start and end colors.
- Switch between linear and radial gradients.
- Adjust the start and end points of the gradient.
- Save the created gradient to the photo library.

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.3+

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/GradientGen2.git
    ```
2. Open the project in Xcode:
    ```sh
    cd GradientGen2
    open GradientGen2.xcodeproj
    ```
3. Build and run the project on a simulator or a physical device.

## Usage

1. Customize the gradient by adjusting the sliders for the start and end colors.
2. Use the toggle to switch between linear and radial gradients.
3. Adjust the start and end points of the gradient using the provided sliders.
4. Tap the "Save Gradient" button to save the created gradient to your photo library.

## Permissions

The app requires access to the photo library to save the gradient images. Please ensure to add the following key to your `Info.plist` file:
```xml
<key>NSPhotoLibraryAddUsageDescription</key>
<string>We need access to your photo library to save the gradient image.</string>
```

## Screenshots

![Screenshot 1](screenshots/screenshot1.png)
![Screenshot 2](screenshots/screenshot2.png)

## Contributing

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a pull request.

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

[@speedyfriend433](https://twitter.com/speedyfriend433) - speedyfriend433@gmail.com

Project Link: [https://github.com/speedyfriend433/GradientGen2](https://github.com/speedyfriend433/GradientGen2)
