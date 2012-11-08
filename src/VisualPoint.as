package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * VisualPoint - Bezier
	 * @version 1.0
	 * @author David Ronai
	 */
	public class VisualPoint extends Sprite 
	{
		
		//================== CONSTRUCTOR ======================
		
		public function VisualPoint(x:Number, y:Number, alpha:Number=1) 
		{
			this.x = x;
			this.y = y;
			this.alpha = alpha;
			draw(alpha);
		}
		
		//================== DISPOSE ==========================
		
		public function dispose():void
		{
			
		}
		
		//================== PUBLIC METHODS ===================
		
		public function toPoint():Point
		{
			return new Point(x, y);
		}
		
		//================== PRIVATE METHODS ==================
		
		private function draw(alpha:Number):void
		{
			graphics.lineStyle(1, 0);
			graphics.beginFill(0xFAFAFA, 1);
			graphics.drawEllipse(-5, -5, 10, 10);
			graphics.endFill();
			
		}
		
	}
	
}