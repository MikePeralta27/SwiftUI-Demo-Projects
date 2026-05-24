//
//  ContentView.swift
//  Instafilter
//
//  Created by Michael Peralta on 5/16/26.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    enum FilterKeys {
        case intensity, radius, scale
    }
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilters = false

    @State private var filterPicker: FilterKeys = .intensity

    var isImagePresented: Bool { processedImage != nil }

    @AppStorage("filterCount") private var filterCount = 0
    @Environment(\.requestReview) var requestReview

    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView(
                            "No picture",
                            systemImage: "photo.badge.plus",
                            description: Text("Tap to import a photo")
                        )
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)

                Spacer()

                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity, applyProccesing)
                        .disabled(
                            !isImagePresented || filterPicker != .intensity
                        )

                }
                HStack {
                    Text("Radius")
                    Slider(value: $filterRadius)
                        .onChange(of: filterRadius, applyProccesing)
                        .disabled(!isImagePresented || filterPicker != .radius)
                }
                HStack {
                    Text("Scale")
                    Slider(value: $filterScale)
                        .onChange(of: filterScale, applyProccesing)
                        .disabled(!isImagePresented || filterPicker != .scale)
                }

                HStack {
                    Button("Change Filter ", action: changeFilter)
                        .disabled(!isImagePresented)

                    Spacer()

                    if let processedImage {
                        ShareLink(
                            item: processedImage,
                            preview: SharePreview(
                                "Instafilter image",
                                image: processedImage
                            )
                        )
                    }
                }

            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters)
            {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Box Blur") { setFilter(CIFilter.boxBlur()) }
                Button("Bump Distortion Linear") {
                    setFilter(CIFilter.bumpDistortionLinear())
                }
                Button("Bloom") { setFilter(CIFilter.bloom()) }
                Button("Cancel", role: .cancel) {}

            }
        }
    }

    func changeFilter() {
        showingFilters.toggle()
    }

    func loadImage() {
        Task {
            guard
                let imageData = try await selectedItem?.loadTransferable(
                    type: Data.self
                )
            else { return }
            guard let inputImage = UIImage(data: imageData) else { return }

            let beingImage = CIImage(image: inputImage)
            currentFilter.setValue(beingImage, forKey: kCIInputImageKey)
            applyProccesing()
        }
    }

    func applyProccesing() {

        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(
                filterIntensity,
                forKey: kCIInputIntensityKey
            )
            filterPicker = .intensity
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(
                filterRadius * 200,
                forKey: kCIInputRadiusKey
            )
            filterPicker = .radius
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(
                filterScale * 10,
                forKey: kCIInputScaleKey
            )
            filterPicker = .scale
        }
        if inputKeys.contains(kCIInputCenterKey) {

        }

        guard let outputImage = currentFilter.outputImage else { return }
        guard
            let cgimage = context.createCGImage(
                outputImage,
                from: outputImage.extent
            )
        else { return }

        let uiImage = UIImage(cgImage: cgimage)
        processedImage = Image(uiImage: uiImage)
    }

    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        filterCount += 1
        if filterCount == 3 {
            requestReview()
        }
    }

}

#Preview {
    ContentView()
}
