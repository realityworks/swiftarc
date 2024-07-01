//
//  SimpleModeSelectorView.swift
//

import SwiftUI

protocol SimpleModeSelectable: Identifiable, Hashable {
    static var selectableModes: [Self] { get }
    var title: String { get }
    var id: ID { get }
}

struct SimpleModeSelectorView<T: SimpleModeSelectable>: View {
    var title: String?
    @Binding var selected: T

    var body: some View {
        VStack {
            if let title {
                SubtitleText(title)
            }
            Picker("Modes", selection: $selected) {
                ForEach(T.selectableModes) { mode in
                    TitleText(mode.title)
                        .tag(mode)
                }
            }
        }
    }
}

struct SimpleModeSelectorView_Previews: PreviewProvider {
    struct TestSelectable: SimpleModeSelectable {
        static var selectableModes: [TestSelectable] = [
            TestSelectable(title: "MODE 1", id: "1"),
            TestSelectable(title: "MODE 2", id: "2"),
            TestSelectable(title: "MODE 3", id: "3")
        ]

        var title: String
        var id: String
    }

    static var previews: some View {
        SimpleModeSelectorView(
            title: "MODE",
            selected: .constant(TestSelectable(title: "MODE 1", id: "1"))
        )
        .pickerStyle(.wheel)
        .background(Color.black)

        SimpleModeSelectorView(
            selected: .constant(TestSelectable(title: "MODE 1", id: "1"))
        )
        .background(Color.black)
    }
}
