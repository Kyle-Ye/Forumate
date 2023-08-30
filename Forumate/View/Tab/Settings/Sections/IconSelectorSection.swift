//
//  IconSelectorSection.swift
//  Forumate
//
//  Created by Kyle on 2023/7/30.
//

import SwiftUI

#if os(iOS) || os(visionOS) || os(tvOS)
struct IconSelectorSection: View {
    @State private var currentIcon = UIApplication.shared.alternateIconName ?? Icon.primary.appIconName

    private let icons = [Icon.primary, Icon.alt1]
    
    private let columns = [GridItem(.adaptive(minimum: 125, maximum: 1024))]

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
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 6) {
            ForEach(icons, id: \.self) { icon in
                Button {
                    currentIcon = icon.appIconName
                    Task {
                        do {
                            let name = icon.rawValue == Icon.primary.rawValue ? nil : icon.appIconName
                            try await UIApplication.shared.setAlternateIconName(name)
                        } catch {
                            setAlternateIconError = IconError(error)
                            showAlert = true
                            assertionFailure("\(error.localizedDescription) - Icon name: \(icon)")
                        }
                    }
                } label: {
                    Image(uiImage: UIImage(named: icon.iconName) ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minHeight: 125, maxHeight: 1024)
                        .cornerRadius(6)
                        .shadow(radius: 3)
                        .overlay(alignment: .bottomTrailing) {
                            if icon.appIconName == currentIcon {
                                Image(systemName: "checkmark.seal.fill")
                                    .padding(4)
                                    .tint(.green)
                            }
                        }
                }
                .alert(isPresented: $showAlert, error: setAlternateIconError) {
                    Button("OK") {}
                }
            }
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
    }
}

#Preview {
    IconSelectorSection()
}
#endif
