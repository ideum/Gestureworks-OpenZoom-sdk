////////////////////////////////////////////////////////////////////////////////
//
//  OpenZoom
//
//  Copyright (c) 2007–2008, Daniel Gasienica <daniel@gasienica.ch>
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
package org.openzoom.flash.viewport
{

import flash.geom.Point;
import flash.geom.Rectangle;	

/**
 * Defines the interface that classes which represent a viewport transform must implement.
 */
public interface IViewportTransform
{  
    //--------------------------------------------------------------------------
    //
    //  Properties: Coordinates
    //
    //--------------------------------------------------------------------------
     
    //----------------------------------
    //  x
    //----------------------------------
    
    /**
     * Horizontal coordinate of the viewport.
     */
    function get x() : Number
    function set x( value : Number ) : void
    
    //----------------------------------
    //  y
    //----------------------------------
    
    /**
     * Vertical coordinate of the viewport.
     */
    function get y() : Number
    function set y( value : Number ) : void
    
    //----------------------------------
    //  width
    //----------------------------------
    
    /**
     * Horizontal dimension of the viewport.
     */
    function get width() : Number
    function set width( value : Number ) : void
    
    //----------------------------------
    //  height
    //----------------------------------
    
    /**
     * Vertical dimension of the viewport.
     */
    function get height() : Number
    function set height( value : Number ) : void
     
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    
    //----------------------------------
    //  viewportWidth
    //----------------------------------
    
    /**
     * @copy org.openzoom.flash.viewport.IViewport#viewportWidth
     */ 
    function get viewportWidth() : Number
    
    //----------------------------------
    //  viewportHeight
    //----------------------------------
    
    /**
     * @copy org.openzoom.flash.viewport.IViewport#viewportHeight
     */
    function get viewportHeight() : Number
    
    //----------------------------------
    //  sceneWidth
    //----------------------------------
    
    /**
     * @copy org.openzoom.flash.scene.IMultiScaleScene#sceneWidth
     */
    function get sceneWidth() : Number
    
    //----------------------------------
    //  sceneHeight
    //----------------------------------
    
    /**
     * @copy org.openzoom.flash.scene.IMultiScaleScene#sceneHeight
     */
    function get sceneHeight() : Number
     
    //----------------------------------
    //  scale
    //----------------------------------
    
    /**
     * Scale of the scene.
     */ 
    function get scale() : Number
    function set scale( value : Number ) : void
      
    //----------------------------------
    //  zoom
    //----------------------------------
    
    /**
     * Zoom level of the viewport.
     * Scene fits exactly into viewport at value 1.
     */
    function get zoom() : Number
    function set zoom( value : Number ) : void

    //--------------------------------------------------------------------------
    //
    //  Methods: Zooming
    //
    //--------------------------------------------------------------------------
    
    /**
     * Zoom the viewport to the given zoom level.
     * @param zoom Zoom level
     * @param transformX Horizontal coordinate of the zooming center
     * @param transformY Vertical coordinate of the zooming center
     */
    function zoomTo( zoom : Number,
                     transformX : Number = 0.5,
                     transformY : Number = 0.5 ) : void
    
    /**
     * Zoom the viewport by a factor.
     * @param factor Scale factor for the zoom.
     * @param transformX Horizontal coordinate of the zooming center
     * @param transformY Vertical coordinate of the zooming center
     */
    function zoomBy( factor : Number,
                     transformX : Number = 0.5,
                     transformY : Number = 0.5 ) : void
    
    //--------------------------------------------------------------------------
    //
    //  Methods: Panning
    //
    //--------------------------------------------------------------------------
    
    /**
     * Move the viewport.
     * @param x Horizontal coordinate
     * @param y Vertical coordinate
     */
    function moveTo( x : Number, y : Number ) : void
    
    /**
     * Move the viewport.
     * @param dx Horizontal translation delta
     * @param dy Vertical translation delta
     */
    function moveBy( dx : Number, dy : Number ) : void
    
    /**
     * Move the viewport center.
     * @param x Horizontal coordinate
     * @param y Vertical coordinate
     */                 
    function moveCenterTo( x : Number, y : Number ) : void
    
    //--------------------------------------------------------------------------
    //
    //  Methods: Navigation
    //
    //--------------------------------------------------------------------------
                   
    /**
     * Show an area of the scene inside the viewport.
     * 
     * @param rect Rectangular area to be shown in the viewport.
     * @param scale Scale at which the area is beeing displayed.
     */             
    function showRect( rect : Rectangle, scale : Number = 1.0 ) : void
                     
    /**
     * Fit entire scene into the viewport.
     */ 
    function showAll() : void
    
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------
    
    /**
     * Returns a new IViewportTransform object with the same values for the
     * x, y, width, height and zoom properties as the original IViewportTransform object.
     */
    function clone() : IViewportTransform
    
    /**
     * Copy values from other to this instance of IViewportTransform.
     */
    function copy( other : IViewportTransform ) : void
    
    /**
     * Determines whether the object specified in the
     * other parameter is equal to this Rectangle object.
     */
    function equals( other : IViewportTransform ) : Boolean
    
    //--------------------------------------------------------------------------
    //
    //  Properties: flash.geom.Rectangle
    //
    //--------------------------------------------------------------------------
    
    //----------------------------------
    //  top
    //----------------------------------
    
    /**
     * Coordinate of the upper boundary of the viewport transform.
     */
    function get top() : Number
    
    //----------------------------------
    //  right
    //----------------------------------
    
    /**
     * @copy org.openzoom.flash.viewport.IViewport#right
     */    
    function get right() : Number
    
    //----------------------------------
    //  bottom
    //----------------------------------
    
    /**
     * @copy org.openzoom.flash.viewport.IViewport#bottom
     */ 
    function get bottom() : Number
    
    //----------------------------------
    //  left
    //----------------------------------
    
    /**
     * @copy org.openzoom.flash.viewport.IViewport#left
     */ 
    function get left() : Number

    //----------------------------------
    //  topLeft
    //----------------------------------
    
    /**
     * @copy org.openzoom.flash.viewport.IViewport#topLeft
     */ 
    function get topLeft() : Point

    //----------------------------------
    //  bottomRight
    //----------------------------------
    
    /**
     * @copy org.openzoom.flash.viewport.IViewport#bottomRight
     */ 
    function get bottomRight() : Point
}

}