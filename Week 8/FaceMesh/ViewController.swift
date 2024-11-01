import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var faceLabel: UILabel!
    @IBOutlet weak var labelView: UIView!
    var analysis = ""
    var reportChange: (() -> Void)!
    var node: SCNNode?  // Reference to the face mesh node for visual feedback

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewController viewDidLoad")
        
        labelView.layer.cornerRadius = 10
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        guard ARFaceTrackingConfiguration.isSupported else {
            print("Face tracking is not supported on this device")
            return
        }
        
        labelView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let faceMesh = ARSCNFaceGeometry(device: sceneView.device!)
        node = SCNNode(geometry: faceMesh)
        
        node?.geometry?.firstMaterial?.fillMode = .fill
        node?.geometry?.firstMaterial?.diffuse.contents = UIColor.clear  //Transparent to start
        
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry {
            faceGeometry.update(from: faceAnchor.geometry)
            expression(anchor: faceAnchor)
            
            DispatchQueue.main.async {
                self.reportChange()
                print(self.analysis)
            }
        }
    }
    
    func expression(anchor: ARFaceAnchor) {
        //Retrieve blend shapes
        let smileLeft = Double(truncating: anchor.blendShapes[.mouthSmileLeft] ?? 0)
        let smileRight = Double(truncating: anchor.blendShapes[.mouthSmileRight] ?? 0)
        let cheekPuff = Double(truncating: anchor.blendShapes[.cheekPuff] ?? 0)
        let tongueOut = Double(truncating: anchor.blendShapes[.tongueOut] ?? 0)
        let browDownLeft = Double(truncating: anchor.blendShapes[.browDownLeft] ?? 0)
        let browDownRight = Double(truncating: anchor.blendShapes[.browDownRight] ?? 0)
        let mouthFrownLeft = Double(truncating: anchor.blendShapes[.mouthFrownLeft] ?? 0)
        let mouthFrownRight = Double(truncating: anchor.blendShapes[.mouthFrownRight] ?? 0)
        let jawOpen = Double(truncating: anchor.blendShapes[.jawOpen] ?? 0)
        let browInnerUp = Double(truncating: anchor.blendShapes[.browInnerUp] ?? 0)
        let eyeSquintLeft = Double(truncating: anchor.blendShapes[.eyeSquintLeft] ?? 0)
        let eyeSquintRight = Double(truncating: anchor.blendShapes[.eyeSquintRight] ?? 0)

        //Reset analysis text and node color
        self.analysis = ""
        node?.geometry?.firstMaterial?.diffuse.contents = UIColor.clear

        //Define thresholds for significant expressions
        let smileThreshold = 0.5
        let cheekPuffThreshold = 0.5
        let tongueOutThreshold = 0.5
        let browDownThreshold = 0.3
        let mouthFrownThreshold = 0.5
        let jawOpenThreshold = 0.7
        let browInnerUpThreshold = 0.7
        let eyeSquintThreshold = 0.3

        //checking for emotions based on priority
        // 1. Shocked
        if (jawOpen > jawOpenThreshold) && (browInnerUp > browInnerUpThreshold) {
            self.analysis = "You look shocked!"
            displayEmojis(for: self.analysis)
//            changeBackgroundColor(for: self.analysis)
            node?.geometry?.firstMaterial?.diffuse.contents = UIColor.blue.withAlphaComponent(0.5)
        }
        // 2. Angry
        else if (browDownLeft > browDownThreshold) && (browDownRight > browDownThreshold) &&
                 (eyeSquintLeft > eyeSquintThreshold) && (eyeSquintRight > eyeSquintThreshold) {
            self.analysis = "You look angry!"
            displayEmojis(for: self.analysis)
//            changeBackgroundColor(for: self.analysis)
            node?.geometry?.firstMaterial?.diffuse.contents = UIColor.red.withAlphaComponent(0.5)
        }
        // 3. Sad
        else if (mouthFrownLeft > mouthFrownThreshold) && (mouthFrownRight > mouthFrownThreshold) &&
                 (browInnerUp < 0.2) {
            self.analysis = "You look sad."
            displayEmojis(for: self.analysis)
//            changeBackgroundColor(for: self.analysis)
            node?.geometry?.firstMaterial?.diffuse.contents = UIColor.gray.withAlphaComponent(0.5)
        }
        // 4. Happy (Smiling)
        else if (smileLeft + smileRight) > smileThreshold {
            self.analysis = "You are smiling."
            displayEmojis(for: self.analysis)
//            changeBackgroundColor(for: self.analysis)
            node?.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow.withAlphaComponent(0.5)
        }
        // 5. Cheeks Puffed
        else if cheekPuff > cheekPuffThreshold {
            self.analysis = "Your cheeks are puffed."
            displayEmojis(for: self.analysis)
//            changeBackgroundColor(for: self.analysis)
            node?.geometry?.firstMaterial?.diffuse.contents = UIColor.green.withAlphaComponent(0.5)
        }
        // 6. Tongue Out
        else if tongueOut > tongueOutThreshold {
            self.analysis = "Don't stick your tongue out!"
            displayEmojis(for: self.analysis)
//            changeBackgroundColor(for: self.analysis)
            node?.geometry?.firstMaterial?.diffuse.contents = UIColor.purple.withAlphaComponent(0.5)
        }
        else {
            self.analysis = ""
        }
    }
    
    
    var displayedEmojis: Set<UILabel> = []

    func displayEmojis(for emotion: String) {
        DispatchQueue.main.async {
            guard self.displayedEmojis.count < 15 else { return }

            var emoji: String
            switch emotion {
            case "You look shocked!":
                emoji = "😱"
            case "You look angry!":
                emoji = "😡"
            case "You look sad.":
                emoji = "😢"
            case "You are smiling.":
                emoji = "😄"
            case "Your cheeks are puffed.":
                emoji = "🎈"
            case "Don't stick your tongue out!":
                emoji = "😜"
            default:
                return
            }

            
            let emojisToAdd = min(5, 15 - self.displayedEmojis.count)

            for _ in 0..<emojisToAdd {
                let emojiLabel = UILabel()
                emojiLabel.text = emoji
                emojiLabel.font = UIFont.systemFont(ofSize: 50)
                emojiLabel.alpha = 0

                
                let startX = CGFloat.random(in: 0...self.view.bounds.width - 50)
                let startY = self.view.bounds.height - 50
                emojiLabel.frame = CGRect(x: startX, y: startY, width: 50, height: 50)
                
                
                self.view.addSubview(emojiLabel)
                self.displayedEmojis.insert(emojiLabel)

                
                let randomDelay = Double.random(in: 0...1.5)

                
                UIView.animate(withDuration: 3.0, delay: randomDelay, options: [.curveEaseOut], animations: {
                    emojiLabel.alpha = 1
                    emojiLabel.frame.origin.y -= self.view.bounds.height + 50
                    emojiLabel.alpha = 0
                }) { _ in
                    emojiLabel.removeFromSuperview()
                    self.displayedEmojis.remove(emojiLabel)
                }
            }
        }
    }

    func clearEmojis() {
        DispatchQueue.main.async {
            self.displayedEmojis.forEach { label in
                label.removeFromSuperview()
            }
            self.displayedEmojis.removeAll()
        }
    }
    
    
    
    
//    func changeBackgroundColor(for emotion: String) {
//        var color: UIColor
//        switch emotion {
//        case "You are smiling.":
//            color = UIColor.yellow.withAlphaComponent(0.3)
//        case "You look sad.":
//            color = UIColor.blue.withAlphaComponent(0.3)
//        case "You look angry!":
//            color = UIColor.red.withAlphaComponent(0.3)
//        case "You look shocked!":
//            color = UIColor.purple.withAlphaComponent(0.3)
//        default:
//            color = UIColor.white
//        }
//
//        DispatchQueue.main.async {
//            UIView.animate(withDuration: 1.5) {
//                self.view.backgroundColor = color
//            }
//        }
//    }


}
