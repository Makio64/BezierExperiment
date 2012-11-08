package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * Particle - Bezier
	 * @version 1.0
	 * @author David Ronai
	 */
	public class Particle extends Sprite
	{
		
		//================== VARIABLES ========================
	
		private var points:Vector.<Point>;
		private var currentPoint:Number;	
		private var bezier:Bezier;
		private var t:Number;
		private var speed:Number;
		private var radius:uint;
		private var isArrow:Boolean;
		
		//================== CONSTRUCTOR ======================
		
		public function Particle(color:uint, size:uint, points:Vector.<Point>, radius:uint, speed:Number) 
		{
			this.radius = radius;
			t = 0;
			this.speed = speed/1000;
			
			this.points = generateLine(points,radius);
			currentPoint = points.length*2;
			
			bezier = new Bezier(points[1], points[2], points[3]);
			nextCurve();
			isArrow = true;
			draw(color, size);
			cacheAsBitmap = true;
		}
		
		//================== DISPOSE ==========================
		
		public function dispose():void
		{
			points = null;
			bezier.dispose();
			bezier = null;
		}
		
		//================== PUBLIC METHODS ===================
		
		/**
		 * move the particle on his line
		 */
		public function update():void
		{
			if (t >= 1) {
				nextCurve();
				t = t - 1;
			}
			t += speed;
			
			var p:Point = bezier.getBezierPoint(t);
			if (isArrow){
				var dx:Number = p.x - x;
				var dy:Number = p.y - y;
				rotation = Math.atan2(dy,dx)/Math.PI*180-90;
			}
			x = p.x;
			y = p.y;
			
		}
		
		//================== PRIVATE METHODS ==================
		
		/**
		 * create the intermediate points to make the curve
		 * @param	controlPoints
		 * @param	radius
		 * @return
		 */
		private function generateLine(controlPoints:Vector.<Point>,radius:uint):Vector.<Point> 
		{
			var curvePoint:Vector.<Point> = new Vector.<Point>();
			
			controlPoints = jizz(controlPoints, radius);
			
			for (var i:int = 0; i < controlPoints.length-1; ++i) 
			{
				curvePoint.push(controlPoints[i]);
				var b:Bezier = new Bezier (controlPoints[i], 
										   controlPoints[(i + 1) % controlPoints.length],
										   controlPoints[(i + 2) % controlPoints.length]);
				var pts:Vector.<Point> = b.toCubic();
				curvePoint.push(new Point(pts[1].x, pts[1].y));
			}
			curvePoint.push(controlPoints[i]);
			return curvePoint;
		}
		
		/**
		 * Get the next curve on the line
		 */
		private function nextCurve():void 
		{
			currentPoint += 2;
			if (currentPoint > points.length-3){
				currentPoint = 1;
			}
			bezier.p0 = points[(currentPoint)%points.length];
			bezier.p1 = points[(currentPoint+1)%points.length];
			bezier.p2 = points[(currentPoint+2)%points.length];
		}
		
		/**
		 * Draw the particule
		 * @param	color
		 * @param	size
		 */
		private function draw(color:uint,size:uint):void
		{
			graphics.beginFill(color, 1);
			if (isArrow) {
				graphics.moveTo(-size/4, 0)
				graphics.lineTo(0, size);
				graphics.lineTo(size/4, 0);
				graphics.lineTo(-size/4, 0);
			}else {
				graphics.drawEllipse(0, 0, size, size);
			}
			graphics.endFill();
		}
		
		/**
		 * Randomize the points on the line
		 * @param	pts
		 * @param	radius
		 */
		private function jizz(pts:Vector.<Point>, radius:uint):Vector.<Point> 
		{
			for (var i:int = 0; i < pts.length; i++) {
				pts[i].x += -radius + 2 * Math.random() * radius;
				pts[i].y += -radius + 2 * Math.random() * radius;
			}
			return pts;
		}
		
	}

}