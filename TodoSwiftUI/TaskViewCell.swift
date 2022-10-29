//
//  TaskViewCell.swift
//  TodoSwiftUI
//
//  Created by Avijeet Pandey on 28/10/22.
//

import Foundation
import SwiftUI

struct TaskViewCell: View {
    
    @Binding var task: Task
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.square" : "square").onTapGesture {
                task.isCompleted.toggle()
            }
            Text(task.name)
        }
    }
}
