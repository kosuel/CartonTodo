//
//  UserDefaults.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 29/7/2022.
//

import Foundation
//
//enum AppSettingsKey: String {
//    case changeTodoItems
//}
//
//extension UserDefaults {
//
//    typealias TodoId = [String:Bool]
//    /// user changed todo items [todo id : bool]
//    var changeTodoItems: [String:Bool]? {
//
//        get{
//            object(forKey: AppSettingsKey.changeTodoItems.rawValue) as? [String:Bool]
//        }
//        set{
//            if let _ = newValue {
//                set(newValue, forKey: AppSettingsKey.changeTodoItems.rawValue)
//            }
//            else{
//                removeObject(forKey: AppSettingsKey.changeTodoItems.rawValue)
//            }
//        }
//    }
//}
//
//extension UserDefaults: DataStorage{
//
//    func saveChange(of todoItem: TodoItem) {
//        var dic = changeTodoItems ?? [String:Bool]()
//        dic[todoItem.id] = todoItem.completed
//
//        UserDefaults.standard.changeTodoItems = dic
//    }
//
//    func loadChanges() -> [String:Bool]
//}
