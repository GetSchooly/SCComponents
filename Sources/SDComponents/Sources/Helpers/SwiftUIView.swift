import UIKit
import SwiftUI

/******** Usage ************
 
 // SwiftUI
 struct SomeView: View {
   
     var body: some View {
         Text("Hello World!")
     }
 }

 // UIKit
 class RootViewController: UIViewController {

     override func viewDidLoad() {
         super.viewDidLoad()

         // SwiftUI View -> UIView
         let someView = SomeView()
         let uiView = SwiftUIView(someView)
     }
 }
 */

public class SwiftUIView<T: View>: UIView {
    private(set) var hostingViewContrller: UIHostingController<T>
    
    var rootView: T {
        get { hostingViewContrller.rootView }
        set { hostingViewContrller.rootView = newValue }
    }
    
    public init(_ rootView: T, frame: CGRect = .zero) {
        self.hostingViewContrller = UIHostingController(rootView: rootView)
        
        super.init(frame: frame)
        
        backgroundColor = .clear
        hostingViewContrller.view.backgroundColor = .clear
        hostingViewContrller.view.frame = bounds
        hostingViewContrller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(hostingViewContrller.view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
