import SwiftUI
import Foundation 
import Combine

struct Task: Identifiable
{
    var id = String()
    var toDoItem = String()
}

class TaskStore : ObservableObject
{
    //Bind tasks to list here
    @Published var tasks = [Task]()
}
