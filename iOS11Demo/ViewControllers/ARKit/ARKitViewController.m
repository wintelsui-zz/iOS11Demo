//
//  ARKitViewController.m
//  iOS11Demo
//
//  Created by wintel on 2017/10/25.
//  Copyright © 2017年 wintel. All rights reserved.
//

#import "ARKitViewController.h"
#import <ARKit/ARKit.h>
#import <SpriteKit/SpriteKit.h>

@interface ARKitViewController ()
<
ARSCNViewDelegate,
ARSessionDelegate
>
{
    SCNScene *_scene;
}

@property (weak, nonatomic) IBOutlet ARSCNView *arView;
@end

@implementation ARKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //统计栏显示
    _arView.debugOptions = SCNDebugOptionShowPhysicsShapes;
    _arView.showsStatistics = YES;
    _arView.delegate = self;
    
    _scene = [SCNScene sceneNamed:@"ship.scn" inDirectory:@"media.scnassets/ship" options:nil];
    _arView.scene = _scene;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    ARSession *session = [[ARSession alloc] init];
    session.delegate = self;
    _arView.session = session;
    
    ARWorldTrackingConfiguration *shipConfiguration = [[ARWorldTrackingConfiguration alloc] init];
//    shipConfiguration.lightEstimationEnabled = YES;
    shipConfiguration.planeDetection = ARPlaneDetectionHorizontal;
    [_arView.session runWithConfiguration:shipConfiguration options:ARSessionRunOptionResetTracking | ARSessionRunOptionRemoveExistingAnchors];
}
    
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_arView.session pause];
}

    
#pragma mark - -- ARSCNViewDelegate Start --

//- (nullable SCNNode *)renderer:(id <SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor{
//    if ([anchor isMemberOfClass:[ARPlaneAnchor class]]) {
//
//    }
//}

- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor{
    NSLog(@"添加锚点");
    if ([anchor isMemberOfClass:[ARPlaneAnchor class]]) {
        ARPlaneAnchor *planeAnchor = (ARPlaneAnchor *)anchor;
        
        SCNBox *planeBox = [SCNBox boxWithWidth:planeAnchor.extent.x*0.2
                                         height:0
                                         length:planeAnchor.extent.x*0.2
                                  chamferRadius:0];
        
        SCNNode *planeNode = [SCNNode nodeWithGeometry:planeBox];
        planeNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
        [node addChildNode:planeNode];

        SCNNode *cupNode = _scene.rootNode.childNodes[0];
        cupNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
        [node addChildNode:cupNode];
    }
}
- (void)renderer:(id <SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor{
    NSLog(@"将要更新锚点");
}
- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor{
    NSLog(@"已经更新锚点");
}
- (void)renderer:(id <SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor{
    NSLog(@"移除锚点");
}

#pragma mark - -- ARSCNViewDelegate End --

#pragma mark - -- ARSessionDelegate Start --
    
- (void)session:(ARSession *)session didUpdateFrame:(ARFrame *)frame{
    
}
- (void)session:(ARSession *)session didAddAnchors:(NSArray<ARAnchor*>*)anchors{
    
}
- (void)session:(ARSession *)session didUpdateAnchors:(NSArray<ARAnchor*>*)anchors{
    
}
- (void)session:(ARSession *)session didRemoveAnchors:(NSArray<ARAnchor*>*)anchors{
    
}
#pragma mark - -- ARSessionDelegate End --
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
