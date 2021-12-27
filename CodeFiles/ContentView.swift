import SwiftUI
import Combine
import Foundation
import UIKit

struct ContentView: View {
    
    @ObservedObject var taskStore = TaskStore()
    @State var newToDo : String = ""
    
    var searchBar : some View
    {
        HStack
        {
            TextField("   Enter a new item", text: self.$newToDo)
            
            //binding string means as string is entered, it will bind w the associated variable
            //.background(RoundedRectangle(cornerRadius: 100).fill(Color.blue))
            //.background(.teal)
            //.clipShape(Capsule())
            //.cornerRadius(5)
            //.RoundedRectangle(cornerRadius: 60)
            .foregroundColor(Color.black)    //search font color
            //.background(Color.black)
                
            
            Button(action: self.addNewToDo, label: {
                Text("+")
                    .font(.title)
                    .foregroundColor(.black)
            })
        }
        .background(Color.gray)
        //.foregroundColor(Color.red)
        
        //RoundedRectangle(cornerRadius: 10)
        //.stroke(.blue, lineWidth: 10)
        //.frame(width: 200, height: 50)
    }
    
    func addNewToDo()
    {
        taskStore.tasks.append(Task(id: String(taskStore.tasks.count + 1), toDoItem: newToDo))
        self.newToDo = ""
    }
    
    var body: some View {
        NavigationView
        {
            VStack {
                searchBar
                    .padding()
                
                HStack
                {
                    //Text("MY FIRST APP:")
                    //.font(.headline)
                    //Text("a grocery list")
                    //.font(.headline)
                }
                
                List()
                { 
                    ForEach(self.taskStore.tasks)
                    {
                        task in
                        Text(task.toDoItem)
                        //.font(.system(.body, design: serif))
                    }
                    //Below are actions to take on Edit button click
                    .onMove(perform: self.move)        //move tasks around
                    .onDelete(perform: self.delete)      //delete items
                    
                }.navigationBarTitle("Tasks")
                    .padding()
                    .navigationBarItems(trailing: EditButton())
                //.font(.caption)
                //.foregroundColor(.black)
                //Make line above trailing/leading for right/left side edit btn
            }
            //.clipShape(Capsule())
            .cornerRadius(63)
            .background(Color.black)
        }
    }
    
    func delete(at offsets : IndexSet)
    {
        taskStore.tasks.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination : Int)
    {
        taskStore.tasks.move(fromOffsets: source, toOffset: destination)
    }
}
