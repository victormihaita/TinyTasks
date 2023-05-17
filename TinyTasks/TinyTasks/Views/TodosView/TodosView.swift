//
//  TodosView.swift
//  TinyTasks
//
//  Created by Victor Mihaita on 16.05.2023.
//

import SwiftUI
import CoreData

struct TodosView: View {
    @ObservedObject var viewModel : TodosViewModel

    @State private var showingCreate = false
    @State private var showingEdit = false

    @State private var updateTodo: Todo?

    @State private var taskName = ""
    @State private var isList = false

    init(for todo: Todo? = nil) {
        viewModel = TodosViewModel(parentTodo: todo)
    }

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    TextField("Task name", text: $taskName)
                        .font(.headline)
                        .padding(.leading)
                        .frame(height: 48)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(4)

                    Toggle(isOn: $isList) {
                        Text("Is List")
                    }
                }

                Button {
                    viewModel.add(taskName: taskName, isList: isList)
                    self.taskName = ""
                    self.isList = false
                } label: {
                    Text("Add")
                }
            }
            .padding()

            List {
                ForEach(viewModel.todos, id: \.id) { todo in
                    if todo.isList == true {
                        NavigationLink {
                            TodosView(for: todo)
                        } label: {
                            TodoRowView(todo)
                        }
                    } else {
                        TodoRowView(todo)
                    }
                }
                .onDelete(perform: viewModel.delete)
//                .onMove(perform: viewModel.move)
//                .alert("Edit task", isPresented: $showingEdit) {
//                    TextField("Task name", text: $taskName)
//                    Button("Save", action: viewModel.update(updateTodo, name: taskName))
//                }
            }
        }
        .navigationTitle(viewModel.parentTodo?.name ?? "Tiny Tasks")
    }

    @ViewBuilder
    func TodoRowView(_ todo: Todo) -> some View {
        HStack {
            Text(todo.name ?? "")
            Spacer()
            Image(systemName: todo.completed ? "checkmark.circle" : "circle")
                .onTapGesture {
                    viewModel.update(todo, isCompleted: !todo.completed)
                }
        }
    }
}
