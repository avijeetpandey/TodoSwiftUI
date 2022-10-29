//
//  ContentView.swift
//  TodoSwiftUI
//
//  Created by Avijeet Pandey on 28/10/22.
//

import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    let name: String
    var isCompleted: Bool = false
}

enum Sections: String, CaseIterable {
    case pending = "Pending"
    case completed = "Completed"
}

struct HomeView: View {
    
    @State private var tasks: [Task] = [Task(name: "Buy Eggs", isCompleted: true),
                                        Task(name: "Go to gym"),
                                        Task(name: "Go to park")]
    
    var pendingTasks: [Binding<Task>] {
        $tasks.filter { !$0.isCompleted.wrappedValue}
    }
    
    var completedTasks: [Binding<Task>] {
        $tasks.filter { $0.isCompleted.wrappedValue}
    }
    
    var body: some View {
        List {
            ForEach(Sections.allCases, id: \.self) { section in
                Section {
                    let filteredTasks = section == .pending ? pendingTasks : completedTasks
                    ForEach(filteredTasks){ $task in
                        TaskViewCell(task: $task)
                    }.onDelete { indexSet in
                        indexSet.forEach { index in
                            let taskToDelete = filteredTasks[index]
                            tasks = tasks.filter { $0.id != taskToDelete.id }
                        }
                    }
                } header: {
                    Text(section.rawValue)
                }
            }
        }
    }
}
