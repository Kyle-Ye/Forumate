//
//  IconSelectorSection.swift
//  Forumate
//
//  Created by Kyle on 2023/7/30.
//

#if os(iOS) || os(tvOS) || os(macOS)
import os.log
import SwiftUI

struct IconSelectorSection: View {
    #if os(macOS)
    @State private var currentIcon = Icon.primary.appIconName
    #else
    @State private var currentIcon = UIApplication.shared.alternateIconName ?? Icon.primary.appIconName
    #endif
    private let icons = [Icon.primary, Icon.alt1]

    #if os(tvOS)
    private let columns = [GridItem(.adaptive(minimum: 450, maximum: 500))]
    #else
    private let columns = [GridItem(.adaptive(minimum: 125, maximum: 1024))]
    #endif
    #if canImport(AppKit)
    @State private var showAlert = false
    @State private var message: LocalizedStringKey = ""
    #else
    @State private var showAlert = false
    @State private var setAlternateIconError: IconError?
    private struct IconError: LocalizedError {
        private let error: Error

        init(_ error: Error) {
            self.error = error
        }

        var errorDescription: String? {
            error.localizedDescription
        }
    }
    #endif

    private static let logger = Logger(subsystem: Logger.subsystem, category: "IconSelectorSection")
    @Environment(PlusManager.self) private var plusManager
    @State private var presentSubscription = false

    var body: some View {
        VStack {
            #if canImport(AppKit)
            Text("Update App Icon is not supported on macOS. But you can click to save the icon and manully update it via Finder.")
            Link(destination: URL(string: "https://support.apple.com/guide/mac-help/change-icons-for-files-or-folders-on-mac-mchlp2313/mac")!) {
                Text("See Apple's macOS manual for more information.")
            }
            #endif
            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(icons, id: \.self) { icon in
                    item(for: icon)
                }
            }
        }
    }

    @ViewBuilder
    private func item(for icon: Icon) -> some View {
        let action = {
            #if canImport(AppKit)
            let fileManager = FileManager.default
            #if os(macOS)
            let data = NSImage(named: icon.iconName)?.tiffRepresentation
            let extensionName = "tiff"
            #else
            let data = UIImage(named: icon.iconName)?.pngData()
            let extensionName = "png"
            #endif
            if let data,
               let downloadsDirectory = fileManager.urls(for: .downloadsDirectory, in: .userDomainMask).first {
                var destinationURL = downloadsDirectory.appendingPathComponent(icon.iconName).appendingPathExtension(extensionName)
                if fileManager.fileExists(atPath: destinationURL.path) {
                    destinationURL = downloadsDirectory.appendingPathComponent(icon.iconName + "_" + UUID().uuidString).appendingPathExtension(extensionName)
                }
                if fileManager.createFile(atPath: destinationURL.path(), contents: data) {
                    message = "Successfully saved the icon to the Downloads folder."
                    IconSelectorSection.logger.info("Successfully saved the icon to the Downloads folder.")
                } else {
                    message = "Error saving icon to Downloads folder."
                    IconSelectorSection.logger.error("Error saving icon to Downloads folder.")
                }
                showAlert = true
            }
            #else
            _ = Task { @MainActor in
                do {
                    let name = icon.rawValue == Icon.primary.rawValue ? nil : icon.appIconName
                    if plusManager.plusEntitlement {
                        try await UIApplication.shared.setAlternateIconName(name)
                    } else {
                        throw IconError(PlusError.plusOnlyFeature)
                    }
                    currentIcon = icon.appIconName
                } catch {
                    setAlternateIconError = IconError(error)
                    showAlert = true
                    IconSelectorSection.logger.error("\(error.localizedDescription, privacy: .public) - Icon name: \(icon.iconName, privacy: .public)")
                }
            }
            #endif
        }
        let label = {
            VStack {
                Image(platformNamed: icon.iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minHeight: 125, maxHeight: 1024)
                #if !canImport(AppKit)
                    .cornerRadius(6)
                    .shadow(radius: 3)
                    .overlay(alignment: .bottomTrailing) {
                        if icon.appIconName == currentIcon {
                            Image(systemName: "checkmark.seal.fill")
                                .padding(4)
                                .tint(.green)
                        }
                    }
                #endif
                #if !os(tvOS)
                ContributorView(info: icon.author)
                #endif
            }
        }
        Group {
            #if os(iOS)
            if UIDevice.current.userInterfaceIdiom == .mac {
                label().onTapGesture {
                    action()
                }
            } else {
                Button {
                    action()
                } label: {
                    label()
                }
            }
            #elseif os(tvOS)
            VStack {
                Button {
                    action()
                } label: {
                    label()
                }
                ContributorView(info: icon.author)
            }
            #elseif os(macOS)
            Button {
                action()
            } label: {
                label()
            }
            #endif
        }
        #if canImport(AppKit)
        .alert(message, isPresented: $showAlert) {
            Button("OK") {}
        }
        #else
        .alert(isPresented: $showAlert, error: setAlternateIconError) {
                Button("OK") {}
                Button("Learn more about Forumate+") {
                    presentSubscription.toggle()
                }
                .tint(Color.accentColor)
            }
        #endif
            .sheet(isPresented: $presentSubscription) {
                ForumatePlusSectionSheet()
            }
    }
}

extension IconSelectorSection {
    enum Icon: Int, CaseIterable, Identifiable {
        var id: String {
            "\(rawValue)"
        }

        init(string: String) {
            if string == Icon.primary.appIconName {
                self = .primary
            } else {
                self = .init(rawValue: Int(String(string.replacing("AppIconAlternate", with: "")))!)!
            }
        }

        case primary = 0
        case alt1

        var appIconName: String {
            switch self {
            case .primary:
                #if os(tvOS)
                return "App Icon"
                #else
                return "AppIcon"
                #endif
            default:
                return "AppIconAlternate\(rawValue)"
            }
        }

        var iconName: String {
            "icon\(rawValue)"
        }
        
        var author: ContributorInfo {
            switch self {
            case .primary: .frad
            case .alt1: .kyle
            }
        }
    }
}

#Preview {
    @State var plusManager = PlusManager()
    return IconSelectorSection()
        .environment(plusManager)
}
#endif
