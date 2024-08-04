//
//  ContentView.swift
//  SwiftDataPractise
//
//  Created by Göksu Bayram on 30.07.2024.
//

import SwiftUI
import SwiftData
import PhotosUI

struct ContentView: View {

    @State private var newTodoTitle = ""
    @State private var showAddTodoSheet = false

    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: [.init(\Todo.isCompleted) ,.init(\Todo.addedDate, order: .reverse), .init(\Todo.title)], animation: .bouncy) private var todos: [Todo]
    

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(todos) { todo in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(todo.title)
                                    .strikethrough(todo.isCompleted, color: .black)
                                Text("Added: \(todo.addedDate, formatter: itemFormatter)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                if todo.isCompleted {
                                    Text("Completed: \(todo.completeDate!, formatter: itemFormatter)")
                                        .font(.caption)
                                        .foregroundColor(.green)
                                }
                            }
                            Spacer()
                            Button(action: {
                                toggleCompletion(of: todo)
                            }) {
                                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(todo.isCompleted ? .green : .gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                    .onTapGesture(perform: {
                        showAddTodoSheet.toggle()
                    })
                }
            }
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddTodoSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddTodoSheet) {
                AddTodoView(newTodoTitle: $newTodoTitle, addAction: {
                    modelContext.insert(Todo(title: newTodoTitle))
                    newTodoTitle = ""
                    showAddTodoSheet.toggle()
                })
            }
        }
    }
    
    func toggleCompletion(of todo: Todo) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isCompleted.toggle()
            todos[index].completeDate = Date()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
            for index in offsets {
                modelContext.delete(todos[index])
            }
        }
}



private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()


import SwiftUI

struct AddTodoView: View {
    @Binding var newTodoTitle: String
    var addAction: () -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("New Todo", text: $newTodoTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Spacer()

                Button(action: addAction) {
                    Text("Done")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationTitle("Add Todo")
            .navigationBarItems(trailing: Button("Cancel") {
                newTodoTitle = ""
            })
        }
    }
}



#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

extension Bool: Comparable {
    public static func <(lhs: Self, rhs: Self) -> Bool {
        return !lhs && rhs
    }
}
