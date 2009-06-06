////////////////////////////////////////////////////////////////////////////////
//
//  OpenZoom
//
//  Copyright (c) 2007-2009, Daniel Gasienica <daniel@gasienica.ch>
//
//  OpenZoom is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  OpenZoom is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with OpenZoom. If not, see <http://www.gnu.org/licenses/>.
//
////////////////////////////////////////////////////////////////////////////////
package
{

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.geom.Rectangle;

import org.openzoom.flash.components.MemoryMonitor;
import org.openzoom.flash.components.MultiScaleContainer;
import org.openzoom.flash.descriptors.IImagePyramidDescriptor;
import org.openzoom.flash.descriptors.virtualearth.VirtualEarthDescriptor;
import org.openzoom.flash.events.ViewportEvent;
import org.openzoom.flash.renderers.images.ImagePyramidRenderManager;
import org.openzoom.flash.renderers.images.ImagePyramidRenderer;
import org.openzoom.flash.utils.ExternalMouseWheel;
import org.openzoom.flash.viewport.IViewportTransform;
import org.openzoom.flash.viewport.constraints.CompositeConstraint;
import org.openzoom.flash.viewport.constraints.MappingConstraint;
import org.openzoom.flash.viewport.constraints.ScaleConstraint;
import org.openzoom.flash.viewport.constraints.VisibilityConstraint;
import org.openzoom.flash.viewport.controllers.ContextMenuController;
import org.openzoom.flash.viewport.controllers.KeyboardController;
import org.openzoom.flash.viewport.controllers.MouseController;
import org.openzoom.flash.viewport.transformers.SmoothTransformer;
import org.openzoom.flash.viewport.transformers.TweenerTransformer;

[SWF(width="960", height="600", frameRate="60", backgroundColor="#000000")]
public class SmoothTransformerTest extends Sprite
{
    public function SmoothTransformerTest()
    {
        stage.align = StageAlign.TOP_LEFT
        stage.scaleMode = StageScaleMode.NO_SCALE
        stage.addEventListener(Event.RESIZE,
                               stage_resizeHandler,
                               false, 0, true)

        ExternalMouseWheel.initialize(stage)

        container = new MultiScaleContainer()
        transformer = new SmoothTransformer()
        transformer.viewport = container.viewport
        
//        container.transformer = new TweenerTransformer()

        var mouseController:MouseController = new MouseController()
        var keyboardController:KeyboardController = new KeyboardController()
        var contextMenuController:ContextMenuController = new ContextMenuController()
        container.controllers = [mouseController,
                                 keyboardController,
                                 contextMenuController]

        renderManager = new ImagePyramidRenderManager(container,
                                                      container.scene,
                                                      container.viewport,
                                                      container.loader)

        var source:IImagePyramidDescriptor
        var numRenderers:int
        var numColumns:int
        var width:Number
        var height:Number
        var path:String
        var aspectRatio:Number

        // Deep Zoom: Carina Nebula
//        path = "http://seadragon.com/content/images/CarinaNebula.dzi"
//        source = new DeepZoomImageDescriptor(path, 29566, 14321, 254,  1, "jpg")
//        numRenderers = 1
//        numColumns = 1
//        aspectRatio = source.width / source.height
//        width = 16384
//        height = 16384 / aspectRatio
//        

        // Virtual Earth
        source = new VirtualEarthDescriptor()
        numRenderers = 1
        numColumns = 1
        width = 16384
        height = 16384

        var padding:Number = width * 0.1

        var maxRight:Number = 0
        var maxBottom:Number = 0

        for (var i:int = 0; i < numRenderers; i++)
        {
            var renderer:ImagePyramidRenderer = new ImagePyramidRenderer()
            renderer.x = (i % numColumns) * (width + padding)
            renderer.y = Math.floor(i / numColumns) * (height + padding)
            renderer.width = width
            renderer.height = height
            
            renderer.source = source

            container.addChild(renderer)
            renderManager.addRenderer(renderer)

            maxRight = Math.max(maxRight, renderer.x + renderer.width)
            maxBottom = Math.max(maxBottom, renderer.y + renderer.height)
        }

        container.sceneWidth = maxRight
        container.sceneHeight = maxBottom

        var scaleConstraint:ScaleConstraint = new ScaleConstraint()
        scaleConstraint.maxScale = source.width / container.sceneWidth * numColumns * 4

        var mappingConstraint:MappingConstraint = new MappingConstraint()
        var visibilityContraint:VisibilityConstraint = new VisibilityConstraint()

//        var centerConstraint:CenterConstraint = new CenterConstraint()

        var compositeContraint:CompositeConstraint = new CompositeConstraint()
        compositeContraint.constraints = [scaleConstraint,
                                          //centerConstraint,
                                          visibilityContraint]
//        compositeContraint.constraints = [scaleConstraint,
//                                          mappingConstraint]
//        compositeContraint.constraints = [scaleConstraint,
//                                          visibilityContraint,
//                                          mappingConstraint]
//        container.constraint = compositeContraint

        addChild(container)

        memoryMonitor = new MemoryMonitor()
        addChild(memoryMonitor)

        layout()
        
        container.viewport.addEventListener(ViewportEvent.TARGET_UPDATE,
                                            viewport_targetUpdateHandler,
                                            false, 0, true)
                           
        stage.addEventListener(KeyboardEvent.KEY_DOWN,
                               keyDownHandler,
                               false, 0, true)
    }

    private var container:MultiScaleContainer
    private var memoryMonitor:MemoryMonitor
    private var renderManager:ImagePyramidRenderManager

    private var transformer:SmoothTransformer

    private function stage_resizeHandler(event:Event):void
    {
        layout()
    }

    private function layout():void
    {
        if (container)
        {
            container.width = stage.stageWidth
            container.height = stage.stageHeight
        }

        if (memoryMonitor)
        {
            memoryMonitor.x = stage.stageWidth - memoryMonitor.width - 10
            memoryMonitor.y = stage.stageHeight - memoryMonitor.height - 10
        }
    }
    
    private function keyDownHandler(event:KeyboardEvent):void
    {
        if (event.keyCode != 76) // L
            return
        
        var target:IViewportTransform = container.viewport.transform
        
//        var w:Number = Math.random()
//        var center:Point = new Point(w - Math.random(), w - Math.random())
//        target.panCenterTo(center.x, center.y)
//        target.width = w
        
        target.fitToBounds(new Rectangle(0.5 + Math.random() * 0.4,
                                         0.3 + Math.random() * 0.4,
                                         0.00004,
                                         0.00004))
//        target.fitToBounds(new Rectangle(0.5234956109333568,
//                                         0.35019891395599395,
//                                         0.00004,
//                                         0.00004))
        
        transformer.transform(target)
    }
    
    private function viewport_targetUpdateHandler(event:ViewportEvent):void
    {
        transformer.stop()   
    }
}

}