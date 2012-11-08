package  
{
	import flash.geom.Point;
	/**
	 * QuadraticBezier - Bezier
	 * Simple class for quadratic bezier ( curve define by 3 points )
	 * 
	 * @version 1.0
	 * @author David Ronai
	 */
	public class Bezier 
	{
		
		//================== VARIABLES ========================
		
		private var _p0:Point;
		private var _p1:Point;
		private var _p2:Point;	
		
		//================== CONSTRUCTOR ======================
		
		public function Bezier(p0:Point, p1:Point, p2:Point) 
		{
			this.p2 = p2;
			this.p1 = p1;
			this.p0 = p0;	
		}
		
		//================== DISPOSE ==========================
		
		public function dispose():void
		{
			this.p2 = null;
			this.p1 = null;
			this.p0 = null;
		}
		
		
		//================== PUBLIC METHODS ===================
		
		public function getBezierPoint(t:Number):Point
        {
			// Learn more about this on wikipedia
			// 
            return new Point(Math.pow(1 - t, 2)  * p0.x + 2 * t * (1 - t) * p1.x +Math.pow(t, 2)  * p2.x,
							Math.pow(1 - t, 2)  * p0.y + 2 * t * (1 - t) * p1.y +Math.pow(t, 2)  * p2.y
			)
        }
		
		public function toCubic():Vector.<Point>
        {
			var points:Vector.<Point> = new Vector.<Point>(4);
            var new1:Point = new Point( ( p1.x + p0.x ) * .5, ( p1.y + p0.y ) * .5 );
            var new2:Point = new Point( ( p2.x + p1.x ) * .5, ( p2.y + p1.y ) * .5 );
            
            points[ 0 ] = new Point(p0.x,p1.y);
            points[ 1 ] = new1;
            points[ 2 ] = new2;
            points[ 3 ] = new Point(p2.x,p2.y);
            
            return points;
        }
		
		//================== GETTERS AND SETTERS===============
		
		public function get p0():Point 
		{
			return _p0;
		}
		
		public function set p0(value:Point):void 
		{
			_p0 = value;
		}
		
		public function get p1():Point 
		{
			return _p1;
		}
		
		public function set p1(value:Point):void 
		{
			_p1 = value;
		}
		
		public function get p2():Point 
		{
			return _p2;
		}
		
		public function set p2(value:Point):void 
		{
			_p2 = value;
		}
		
	}

}