//
//  addView.swift
//  Notas
//
//  Created by Alondra García Morales on 13/10/23.
//

import SwiftUI

struct addView: View {
    
    @ObservedObject var model : ViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack{
            Text(model.updateItem != nil ? "Edit Note" : "Add Note").font(.title2).bold()
            Spacer()
            
            TextEditor(text: $model.nota)
            Divider()
            DatePicker("Select Date", selection: $model.fecha)
            Spacer()
            Spacer()
            Button(action:{
                
                if model.updateItem != nil {
                    model.editData(context: context)
                }else{
                    model.saveData(context: context)
                }
                
            }){
                Label(title: {Text("Save").foregroundStyle(.white).bold()}, icon: {Image(systemName: "plus").foregroundStyle(.white)})
            }.padding()
                .frame(width: UIScreen.main.bounds.width - 30, height: 45)
                .background(model.nota == "" ? Color("Color") : Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .disabled(model.nota == "" ? true : false)
            
        }.padding()
    }
}


