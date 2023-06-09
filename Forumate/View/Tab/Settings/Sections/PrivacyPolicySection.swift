//
//  PrivacyPolicySection.swift
//  Forumate
//
//  Created by Kyle on 2023/6/6.
//

import SwiftUI

struct PrivacyPolicySection: View {
    var body: some View {
        Text("We do not collect any infomation from you and your device".uppercased())
            .font(.system(.largeTitle, design: .monospaced, weight: .bold))
            .padding()
    }
}

struct PrivacyPolicySection_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicySection()
    }
}
