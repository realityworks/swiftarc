//
//  DropDownSelectable.swift
//

import SwiftUI

struct DropDownSelectable<T: SimpleModeSelectable> : View {
    var title: String {
        selected.wrappedValue.title
    }
    var selectable: [T]
    var selected: Binding<T>

    var body: some View {
        Menu {
            Picker(
                selection: selected,
                label: EmptyView()
            ) {
                ForEach(selectable) { mode in
                    Text(mode.title)
                        .tag(mode)
                }
            }
        } label: {
            pickerLabel
        }
    }

    var pickerLabel: some View {
        ZStack {
            HStack {
                TitleText(title)
            }
            .padding(.vertical, Constants.Padding.medium)

            HStack {
                Spacer()
                Image(systemName: "chevron.down")
                    .font(.appTitle)
                    .foregroundColor(.AppColors.text)
                    .padding([.trailing], Constants.Padding.medium)
            }
        }
        .cornerRadius(3)
        .background(Color.black)
    }
}
