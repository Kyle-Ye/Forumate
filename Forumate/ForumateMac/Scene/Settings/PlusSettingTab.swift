//
//  PlusSettingTab.swift
//  ForumateMac
//
//  Created by Kyle on 2023/11/24.
//

import SwiftUI

struct PlusSettingTab: View {
    var body: some View {
        NavigationStack {
            ForumatePlusSection()
        }
    }
}

#Preview {
    @State var plusManager = PlusManager()
    return PlusSettingTab()
        .environment(plusManager)
}
