package  
{
	import flash.geom.Point;
	/**
	 * CubicBezier - Bezier
	 * @version 1.0
	 * @author David Ronai
	 */
	public class CubicBezier 
	{
		
		//================== VARIABLES ========================
		
		private var _p0:Point;
		private var _p1:Point;
		private var _p2:Point;
		private var _p3:Point;
		
		//================== CONSTRUCTOR ======================
		
		public function CubicBezier(p0:Point,p1:Point,p2:Point,p3:Point) 
		{
			this.p0 = p0;
			this.p1 = p1;
			this.p2 = p2;
			this.p3 = p3;
		}
		
		//================== DISPOSE ==========================
		
		public function dispose():void
		{
			this.p0 = null;
			this.p1 = null;
			this.p2 = null;
			this.p3 = null;
		}
		
		//================== PUBLIC METHODS ===================
		
		
        public function getBezierPoint(t:Number):Point
        {
            return new Point(Math.pow(1 - t, 3)  * p0.x + 3 * t * Math.pow(1 - t, 2) * p1.x
                       + 3 * t * t * (1 - t) * p2.x + t * t * t * p3.x,
                         Math.pow(1 - t, 3)  * p0.y + 3 * t * Math.pow(1 - t, 2) * p1.y
                       + 3 * t * t * (1 - t) * p2.y + t * t * t * p3.y);
        }
		
		//================== PRIVATE METHODS ==================
		
		
		
		//================== LISTENERS ========================
		
		
		
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
		
		public function get p3():Point 
		{
			return _p3;
		}
		
		public function set p3(value:Point):void 
		{
			_p3 = value;
		}
		
	}

}