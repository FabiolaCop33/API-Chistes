//
//  ContentView.swift
//  API Frases
//
//  Created by Fabiola Correa Padilla on 13/03/23.
//

import SwiftUI

struct ContentView: View{
    
    //Agregamos una variable de estado que va a contener QuoteData
    @State private var quoteData: QuoteData?
    
    var body: some View{
        
        VStack(alignment: .trailing){
            Text(quoteData?.joke ?? " ")
            Spacer()
            Text("- \(quoteData?.category.isEmpty == false ? quoteData!.category : " ")");
            Spacer()
            Button(action: loadData){
                Image(systemName: "arrow.clockwise")
            }.font(.title2).padding(.top)
        }//:VSTACK
        .multilineTextAlignment(.trailing)
        .padding().onAppear(perform: loadData)
    } //:BodyView
    
    //Llamada al API: creación del método
    private func loadData(){
        guard let url = URL(string: "https://v2.jokeapi.dev/joke/Any?format=json") else{
            return
            }
        URLSession.shared.dataTask(with: url){data, response, error in
            guard let data = data else{
                return
            }
            if let decodedData = try? JSONDecoder().decode(QuoteData.self, from: data){
                DispatchQueue.main.async{
                    self.quoteData = decodedData
                }
            }
        }.resume()
    }
    
}


struct QuoteData: Decodable{
    //Debemos agregar una variable para cada una de las respuestas
    var category: String
    var joke: String
    var id: String
    var lang: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
