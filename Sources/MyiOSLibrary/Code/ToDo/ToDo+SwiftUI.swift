//
//  ToDo+SwiftUI.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 5/29/25.
//

extension ToDo{
    class SwiftUI{
        func main(){
            let _="""
                ------------------------------SwiftUI Preview ------------------------------    
                                        *** This is not working **
                #Preview {
                    TestPreviewView()
                }
                                            *** This is working **
                
                struct MyView_Previews: PreviewProvider {
                    static var previews: some View {
                        TestPreviewView()
                    }
                }
                """
        }
    }
}
