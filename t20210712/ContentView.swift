//
//  ContentView.swift
//  t20210712
//
//  Created by 有本淳吾 on 2021/07/12.
//

import SwiftUI
import RealityKit
import Combine

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
//        // Load the "Box" scene from the "Experience" Reality File
//        let boxAnchor = try! Experience.loadBox()
//
//        // Add the box anchor to the scene
//        arView.scene.anchors.append(boxAnchor)

        let anchor = AnchorEntity()
        arView.scene.anchors.append(anchor)
        
        let planeModel = ModelEntity(
            mesh: .generatePlane(width: 0.5, height: 1.0), materials: [SimpleMaterial(color: .red, isMetallic: false)]
        )
//        let planeModel = ModelEntity(
//            mesh: .generatePlane(width: 1.0, height: 1.0), materials: [SimpleMaterial(color: .red, isMetallic: false)]
//        )

        let mtlLibrary = MTLCreateSystemDefaultDevice()!
          .makeDefaultLibrary()!

        do {
            let surfaceShader = CustomMaterial.SurfaceShader(
                named: "simpleSurface", in: mtlLibrary
            )
            try planeModel.modifyMaterials {
                var mat = try CustomMaterial(from: $0, surfaceShader: surfaceShader)
//                let tex = try TextureResource.load(named: "number1234.png")
                let tex = try TextureResource.load(named: "number13.png")
                mat.custom.texture = .init(tex)
                //try! MaterialColorParameter.texture(
//                    TextureResource.load(named: "number.png"))
                return mat
            }
        } catch {
            assertionFailure("Failed to set a custom shader \(error)")
        }
        
        planeModel.position = SIMD3<Float>(0.0, 0.0, -1.0)
        anchor.addChild(planeModel)
        
        // Billboardやる？
        arView.scene.subscribe(to: SceneEvents.Update.self) { [self] _ in
            planeModel.billboard(targetPosition: arView.cameraTransform.translation)
        } //.store(in: &cancellables)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
//        planeModel.billboard(targetPosition: uiView.cameraTransform.translation)
    }
    
}
    

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
