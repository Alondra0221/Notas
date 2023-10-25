//
//  Home.swift
//  Notas
//
//  Created by Alondra García Morales on 13/10/23.
//

import SwiftUI

struct Home: View {
    
    @StateObject var model = ViewModel()
    @Environment(\.managedObjectContext) var context
    //@FetchRequest(entity: Notas.entity(), sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: true)], animation: .spring) var results : FetchedResults <Notas>
    
    @FetchRequest(entity: Notas.entity(), sortDescriptors: [],
                  predicate: NSPredicate(format: "fecha >= %@", Date() as CVarArg),
                  animation:.spring()) var results : FetchedResults <Notas>
    
    var body: some View {
        NavigationView{
            List{
                ForEach(results){item in
                    VStack(alignment: .leading){
                        Text(item.nota ?? "No note").font(.title2).bold()
                        Text(item.fecha ?? Date(), style: .date)
                    }.contextMenu(ContextMenu(menuItems: {
                        Button(action:{
                            model.sendData(item: item)
                        }){
                            Label(title:{
                                Text("Edit")
                            },icon:{
                                Image(systemName: "pencil")
                            })
                        }
                        Button(role:.destructive,action:{
                            model.deleteData(item: item, context: context)
                        }){
                            Label(title:{
                                Text("Delete")
                            },icon:{
                                Image(systemName: "trash")
                            })
                        }
                    }))
                }
            }.navigationTitle("Notes")
                .toolbar{
                    Button(action:
                            {model.show.toggle()}
                    )
                    {Image(systemName: "plus").font(.title2).foregroundStyle(.blue)}
                }.sheet(isPresented: $model.show, content: {
                    addView(model:model)
                })
        }
    }
}

