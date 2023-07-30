//
//  IconSelectorSection.swift
//  Forumate
//
//  Created by Kyle on 2023/7/30.
//

import SwiftUI

#if os(iOS) || os(tvOS)
struct IconSelectorSection: View {
    @State private var currentIcon = UIApplication.shared.alternateIconName ?? Icon.primary.appIconName

    private let icons = [Icon.primary, Icon.alt1]
    
    private let columns = [GridItem(.adaptive(minimum: 125, maximum: 1024))]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 6) {
            ForEach(icons, id: \.self) { icon in
                Button {
                    currentIcon = icon.appIconName
                    if icon.rawValue == Icon.primary.rawValue {
                        UIApplication.shared.setAlternateIconName(nil)
                    } else {
                        UIApplication.shared.setAlternateIconName(icon.appIconName) { error in
                            guard let error else { return }
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
                return "AppIcon"
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
    VStack {
        Text("1")
//        IconSelectorSection()
        Image(uiImage: UIImage(named: "icon1") ?? .add)
    }
}
#endif
