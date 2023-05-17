//
//  TodosViewModel.swift
//  TinyTasks
//
//  Created by Victor Mihaita on 17.05.2023.
//

import Foundation
import CoreData

class TodosViewModel: ObservableObject {
    private let viewContext = DataManager.shared.viewContext

    @Published var todos: [Todo] = []

    public var parentTodo: Todo?

    init(parentTodo: Todo?=nil) {
        self.parentTodo = parentTodo
        fetchTodos()
    }

    func fetchTodos() {
        let request = NSFetchRequest<Todo>(entityName: "Todo")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Todo.index, ascending: false)]

        var predicate: NSPredicate? {
            guard let parentTodo else { return nil }
            return NSPredicate(format: "ANY todos.id = %@", parentTodo.id ?? "")
        }
        request.predicate = predicate

        do {
            todos = try viewContext.fetch(request)
        } catch {
            print("DEBUG: Some error occured while fetching data")
        }
    }

    func add(taskName: String, isList: Bool) {
        let todo = Todo(context: viewContext)
        todo.id = UUID().uuidString
        todo.index = Int16(todos.count)
        todo.name = taskName
        todo.completed = false
        todo.isList = isList

        parentTodo?.addToTodos(todo)

        save()
        fetchTodos()
    }

    func update(_ todo: Todo, name: String?=nil, isCompleted: Bool?=nil) {
        if let name {
            todo.name = name
        }
        if let isCompleted {
            todo.completed = isCompleted
        }
        save()
    }

    func delete(offsets: IndexSet) {
        offsets.map { todos[$0] }.forEach(viewContext.delete)
        save()
    }

    func move(from source: IndexSet, to destination: Int) {
        var revisedTodos: [Todo] = todos.map{ $0 }
        revisedTodos.move(fromOffsets: source, toOffset: destination )
        for reverseIndex in stride(from: revisedTodos.count - 1, through: 0, by: -1) {
            revisedTodos[ reverseIndex ].index = Int16(reverseIndex)
        }
        save()
    }

    func save() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context")
        }
    }
}
