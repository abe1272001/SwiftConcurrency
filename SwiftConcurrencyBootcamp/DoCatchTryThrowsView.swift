//
//  ContentView.swift
//  SwiftConcurrencyBootcamp
//
//  Created by abe chen on 2022/9/30.
//

import SwiftUI

// do catch
// try
// throw

class DoCatchTryThrowsDataManager {
    let isActive: Bool = true
    
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("New text!!", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("New text!!")
        } else {
            return .failure(URLError(.appTransportSecurityRequiresSecureConnection))
        }
    }
    
    func getTitle3() throws -> String {
//        if isActive {
//            return "Next Text"
//        } else {
            throw URLError(.badServerResponse)
//        }s
    }
    
    func getTitle4() throws -> String {
        if isActive {
            return "Final Text"
        } else {
            throw URLError(.badServerResponse)
        }
    }
}

class DoCatchTryThrowsViewModel: ObservableObject {
    @Published var text: String = "Starting Text"
    let manager = DoCatchTryThrowsDataManager()
    
    func fetchTitle() {
        /*
        let returnedValue = manager.getTitle()
        
        if let newTitle = returnedValue.title {
            self.text = newTitle
        } else if let error = returnedValue.error {
            self.text = error.localizedDescription
        }
         */
        /*let result = manager.getTitle2()
        switch result {
        case .success(let newTitle):
            self.text = newTitle
        case .failure(let error):
            self.text = error.localizedDescription
        }*/
        
//        let newTitle = try! manager.getTitle3()
//        self.text = newTitle
        
        // if don't care error method
        /* let newTitle = try? manager.getTitle3()
        if let newTitle = newTitle {
            self.text = newTitle
        } */
        
        /* if one try fail, immediately go into catch block
        加了 try?, 可以不用 do catch block (try optional) */
        do {
            let newTitle = try? manager.getTitle3()
            if let newTitle = newTitle {
                self.text = newTitle

            }
            let finalTitle = try manager.getTitle4()
            self.text = finalTitle

        } catch let error {
            self.text = error.localizedDescription
        }
    }
}

struct DoCatchTryThrowsView: View {
    @StateObject var vm = DoCatchTryThrowsViewModel()
    
    
    var body: some View {
        Text(vm.text)
            .frame(width: 300, height: 300)
            .background(.blue)
            .onTapGesture {
                vm.fetchTitle()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DoCatchTryThrowsView()
    }
}
