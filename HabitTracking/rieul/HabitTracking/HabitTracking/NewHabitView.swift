//
//  NewHabitView.swift
//  HabitTracking
//
//  Created by 이지원 on 2022/10/01.
//

import SwiftUI

struct NewHabitView: View {
    @Environment(\.presentationMode) private var presentationMode

    @ObservedObject var viewModel: HabitListViewModel

    @State private var title: String = ""
    @State private var description: String = ""

//    init(viewModel: HabitListViewModel) {
//        self._viewModel = ObservedObject(initialValue: viewModel)
//    }

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("title", text: $title)
                    TextField("description", text: $description)
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        save()
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }

    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }

    private func save() {
        let habit: Habit = Habit(title: title, description: description)
        viewModel.save(habit)
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitView(viewModel: HabitListViewModel())
    }
}
