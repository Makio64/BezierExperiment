package  
{
	import flash.geom.Point;
	/**
	 * BezierJizzer - Bezier
	 * Create a variation of the bezier curve 
	 * @version 1.0
	 * @author David Ronai
	 */
	public class BezierJizzer extends Bezier 
	{
		
		//================== VARIABLES ========================
		
		private var radius:uint;
		
		
		//================== CONSTRUCTOR ======================
		
		public function BezierJizzer(p0:Point, p1:Point, p2:Point, radius:uint) 
		{
			this.radius = radius;
			p2 = p2.clone().add(getRandomPoint());
			p1 = p1.clone().add(getRandomPoint());
			p0 = p0.clone().add(getRandomPoint());
			super(p0, p1, p2);
		}
		
		//================== PRIVATE METHODS ==================
		
		private function getRandomPoint():Point 
		{
			return new Point( -radius + radius * 2 * Math.random(), -radius + radius * 2 * Math.random());
		}
		
		//================== GETTERS AND SETTERS===============
		
		public function set p0random(value:Point):void 
		{
			super.p0 = value.clone().add(getRandomPoint());
		}
		
		override public function set p1(value:Point):void 
		{
			super.p1 = value.clone().add(getRandomPoint());
		}
		
		override public function set p2(value:Point):void 
		{
			super.p2 = value.clone().add(getRandomPoint());
		}
		
	}

}