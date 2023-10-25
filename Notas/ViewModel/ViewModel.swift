//
//  ViewModel.swift
//  Notas
//
//  Created by Alondra García Morales on 13/10/23.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel : ObservableObject{
    @Published var nota = ""
    @Published var fecha = Date()
    @Published var show = false
    @Published var updateItem : Notas!
    
    //CoreData
    
    //Funcion de guardar 
    func saveData(context: NSManagedObjectContext){
        let newNota = Notas(context: context)
        newNota.nota = nota
        newNota.fecha = fecha
        
        do {
            try context.save()
            print("It is save it")
            show.toggle()
        } catch let error as NSError {
            //alerta al usuario
            print("It is not save it", error.localizedDescription)
            
        }
    }
    
    //Funcion Borrar
    func deleteData(item:Notas,context: NSManagedObjectContext){
        context.delete(item)
        do {
            try context.save()
            print("Se elimino")
        } catch let error as NSError {
            print("No se elimino", error.localizedDescription)
        }
    }
    
    //Funcion buscar datos
    func sendData(item:Notas){
        updateItem = item
        nota = item.nota ?? ""
        fecha = item.fecha ?? Date()
        show.toggle()
    }
    
    // Funcion para guardar lo editado
    func editData(context: NSManagedObjectContext){
        updateItem.fecha = fecha
        updateItem.nota = nota
        do {
            try context.save()
            print("edito")
            show.toggle()
        } catch let error as NSError {
            print("no edito", error.localizedDescription)
        }
    }
}
