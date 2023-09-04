//
//  SettingsTabRoot.swift
//  Forumate
//
//  Created by Kyle on 2023/5/21.
//

import Observation
import SwiftUI

struct SettingsTabRoot: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var tabState: SettingsTabState
    @State private var showStarterIntro = false
    #if os(iOS) || os(visionOS) || os(macOS)
    @State private var showPasteToast = false
    #endif
    func navigationItem(destination: SettingsTabDestination.ID, text: LocalizedStringKey, @ViewBuilder icon: () -> some View) -> some View {
        NavigationLink(value: SettingsTabDestination(title: text, id: destination)) {
            Label {
                Text(text)
            } icon: {
                icon()
            }
        }
    }

    var body: some View {
        List(selection: $tabState.destination) {
            Section {
                #if DEBUG
                navigationItem(destination: .subscription, text: "Forumate+") {
                    SettingIcon(icon: "star.circle.fill", style: .yellow)
                }
                #endif
                #if os(iOS) || os(tvOS) || os(macOS)
                navigationItem(destination: .iconSelector, text: "App Icon") {
                    #if os(macOS)
                    let appIconName = IconSelectorSection.Icon.primary.appIconName
                    #else
                    let appIconName = UIApplication.shared.alternateIconName ?? IconSelectorSection.Icon.primary.appIconName
                    #endif
                    let icon = IconSelectorSection.Icon(string: appIconName)
                    Image(platformNamed: icon.iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                        .cornerRadius(5)
                }
                #endif
                #if os(iOS) || os(macOS)
                navigationItem(destination: .theme, text: "Theme") {
                    SettingIcon(icon: "globe", style: .blue)
                }
                #endif
            }
            Section {
                navigationItem(destination: .general, text: "General") {
                    SettingIcon(icon: "gear", style: .gray)
                }
                #if DEBUG
                navigationItem(destination: .notification, text: "Notifications") {
                    SettingIcon(icon: "bell.badge.fill", style: .red)
                }
                #endif
            }
            Section {
                navigationItem(destination: .support, text: "Support") {
                    SettingIcon(icon: "megaphone.fill", style: .blue)
                }
                navigationItem(destination: .privacy, text: "Privacy Policy") {
                    SettingIcon(icon: "lock.fill", style: .purple)
                }
                navigationItem(destination: .acknowledgement, text: "Acknowledgement") {
                    SettingIcon(icon: "heart.fill", style: .pink)
                }
            } footer: {
                Text(verbatim: """
                \(AppInfo.name) v\(AppInfo.version)-beta Build \(AppInfo.buildNumber)
                \(AppInfo.OSVersion)
                """)
                .multilineTextAlignment(.leading)
                #if os(iOS) || os(visionOS) || os(macOS)
                    .onTapGesture(count: 2) {
                        showPasteToast.toggle()
                        let content = "\(AppInfo.name) v\(AppInfo.version) Build \(AppInfo.buildNumber) · \(AppInfo.OSVersion)"
                        #if os(macOS)
                        NSPasteboard.general.setString(content, forType: .string)
                        #else
                        UIPasteboard.general.string = content
                        #endif
                    }
                #endif
            }
        }
        #if os(iOS) || os(visionOS)
        .listStyle(.insetGrouped)
        #endif
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showStarterIntro = true
                } label: {
                    Label("Starter Intro", systemImage: "info.circle")
                        .symbolRenderingMode(.hierarchical)
                }
            }
        }
        .sheet(isPresented: $showStarterIntro) {
            appState.updateStarterIntro()
        } content: {
            StarterIntro()
        }
        .navigationTitle("Settings")
        #if os(iOS) || os(visionOS) || os(macOS)
            .toast(isPresented: $showPasteToast) {
                Label("Copied into clipboard", systemImage: "doc.on.clipboard")
                    .foregroundStyle(.white)
                    .tint(Color.accentColor.opacity(0.8))
            }
        #endif
    }
}

struct SettingsTabRoot_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsTabRoot()
        }
        .environmentObject(SettingsTabState())
        .environmentObject(AppState())
    }
}
