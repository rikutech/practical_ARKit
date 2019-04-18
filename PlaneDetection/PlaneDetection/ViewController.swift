//
//  ViewController.swift
//  PlaneDetection
//
//  Created by 今陸成 on 2019/04/18.
//  Copyright © 2019 今陸成. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSessionDelegate, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.session.delegate = self
        sceneView.delegate = self
        sceneView.scene = SCNScene()
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
}

extension ViewController {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
    }
    
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
    }
}

extension ViewController {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { fatalError() }
        let geometry = SCNPlane(width: CGFloat(planeAnchor.extent.x),
                                height: CGFloat(planeAnchor.extent.z))
        geometry.materials.first?.diffuse.contents = UIColor.yellow
        let planeNode = SCNNode(geometry: geometry)
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1, 0, 0)
        
        DispatchQueue.main.async {
            //検出したアンカーに対応するノードに子コードとしてもたせる
            node.addChildNode(planeNode)
        }
    }
}
