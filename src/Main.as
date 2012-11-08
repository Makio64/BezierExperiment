package 
{
	import com.bit101.components.CheckBox;
	import com.bit101.components.Label;
	import com.bit101.components.NumericStepper;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * Main
	 * @author David Ronai
	 */
	public class Main extends Sprite 
	{
		
		//=========================== VARIABLES ================================
		
		private var particles:Vector.<Particle>;
		private var pointsUser:Vector.<VisualPoint>;
		private var points:Vector.<Point>;
		private var container:Sprite;
		private var drawLine:CheckBox;
		private var drawCurve:CheckBox;
		private var sortPointButton:CheckBox;
		private var particlesNumber:NumericStepper;
		private var particlesSpace:NumericStepperFix;
		private var lastParticleSpawn:int;
		private var drawVisualPoint:CheckBox;
		private var spawnByPack:CheckBox;
		private var speed:NumericStepperFix;
		private var radiusBtn:NumericStepperFix;
		
		//=========================== CONSTRUCTOR ==============================
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			particles = new Vector.<Particle>();
			points = new Vector.<Point>();
			pointsUser = new Vector.<VisualPoint>();
			
			// UI
			
			drawLine = new CheckBox(this, 10, 10, "drawLine", onUIChange);
			drawLine.selected = true;
			drawCurve = new CheckBox(this, 10, 30, "drawCurve", onUIChange);
			drawCurve.selected = true;
			sortPointButton = new CheckBox(this, 10, 50, "sortPoint", onChange);
			drawVisualPoint = new CheckBox(this, 10, 70, "see intermedierePoint", onChange);
			drawVisualPoint.selected = true;
			spawnByPack = new CheckBox(this, 10, 90, "spawn by pack", onChange);

			new Label(this, 10, 110, "particles");
			new Label(this, 10, 130, "space");
			new Label(this, 10, 150, "speed");
			new Label(this, 10, 170, "radius");
			particlesNumber = new NumericStepperFix(this, 60, 110, onChange);
			particlesNumber.value = 40;
			particlesSpace = new NumericStepperFix(this, 60, 130, onChange);
			speed = new NumericStepperFix(this, 60, 150, onChange);
			speed.value = 25;
			radiusBtn = new NumericStepperFix(this, 60, 170, onChange);
			radiusBtn.value=30;
			lastParticleSpawn = 0;
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			draw();
		}
		
		private function getColor():uint 
		{
			//var colors:Array = [0,0x111111,0x222222,0x333333];
			var colors:Array = [0x690011,0xCC2738,0xBF0426];
			return colors[Math.floor(colors.length*Math.random())];
		}
		
		private function visual2abstract(visuals:Vector.<VisualPoint>):Vector.<Point> 
		{
			var points:Vector.<Point> = new Vector.<Point>();
			for (var i:int = 0; i < visuals.length; i++) {
				points.push(visuals[i].toPoint());
			}
			return points;
		}
		
		/**
		 * Transform quadratic line to cubic line
		 */
		private function generatePoint():void 
		{
			if (pointsUser.length < 2)
				return;
				
			if (container)
				removeChild(container);
			container = new Sprite();
			addChild(container);
			
			points.splice(0, points.length);
			
			for (var i:int = 0; i < pointsUser.length-1; ++i) 
			{
				points.push(pointsUser[i].toPoint());
				var b:Bezier = new Bezier (pointsUser[i].toPoint(), 
										   pointsUser[(i + 1) % pointsUser.length].toPoint(),
										   pointsUser[(i + 2) % pointsUser.length].toPoint());
				
				var pts:Vector.<Point> = b.toCubic();
				var middlePoint:VisualPoint = new VisualPoint(pts[1].x, pts[1].y, .5);
				container.addChild(middlePoint);
				points.push(middlePoint.toPoint());
			}
			points.push(pointsUser[i].toPoint());
		}
		
		private function draw():void 
		{
			graphics.clear();

			//Cubic draw
			if (points.length >= 3 && drawCurve.selected){
				graphics.lineStyle(1, 0x0000FF,.3);
				var division:int = 30;
				for (var i:int = 1; i < points.length - 3; i +=2) 
				{
					var b:Bezier = new Bezier(points[i], points[i + 1], points[i + 2]);
					graphics.moveTo(points[i].x, points[i].y);
					for (var j:int = 0; j < division; j++) {
						var p:Point = b.getBezierPoint(j*(1 / division));
						graphics.lineTo(p.x, p.y);
						if (j == division - 1) {
							var dx:Number = p.x - b.getBezierPoint(j*(1 / (division-1))).x;
							var dy:Number = p.y - b.getBezierPoint(j*(1 / (division-1))).y;
							var rotation:Number = Math.atan2(dy, dx)+Math.PI/2 /// Math.PI * 180;
							
							//draw the tangent of the curve
							
							graphics.lineStyle(1, 0xFF0000,.8);
							graphics.moveTo(p.x+Math.cos(rotation)*25, p.y+Math.sin(rotation)*25);
							graphics.lineTo(p.x-Math.cos(rotation)*25, p.y-Math.sin(rotation)*25);
							graphics.moveTo(p.x, p.y);
							graphics.lineStyle(1, 0x0000FF,.3);
						}
					}
				}
				graphics.endFill();
			}
			
			//2D Draw Line
			if (points.length >= 2 && drawLine.selected){
				graphics.lineStyle(1, 0x00FF00, .7);
				for (i = 0; i < points.length-1; i++) {
					graphics.moveTo(points[i].x, points[i].y);
					graphics.lineTo(points[i+1].x, points[i+1].y);
				}
				graphics.endFill();
			}
			
			if (drawVisualPoint.selected) {
				if(container)container.visible = true;
			} else {
				if(container)container.visible = false;
			}
		}
		
		private function sortVisualPoint(v1:VisualPoint, v2:VisualPoint):Number
		{
			if (v1.x < v2.x) return -1;
			if (v1.x == v2.x) return 0;
			return 1;
		}
		
		private function sortPoint(v1:Point, v2:Point):Number
		{
			if (v1.x < v2.x) return -1;
			if (v1.x == v2.x) return 0;
			return 1;
		}
		
		
		//======================== LISTENER =================================
		
		private function onUIChange(e:Event):void 
		{
			draw();
			e.stopImmediatePropagation();
		}
		
		private function onEnterFrame(e:Event):void 
		{
			var i:int;
			var particle:Particle;
			if ( points.length >= 6 ) {
				if ( particlesNumber.value > particles.length ) {
					if (spawnByPack.selected) {
						for (i = 0; i < particlesNumber.value; i++) {
							particle = new Particle(getColor() , 5 + Math.random() * 10, visual2abstract(pointsUser), radiusBtn.value,speed.value);
							addChild(particle);
							particles.push(particle);
							lastParticleSpawn = 0;
						}
					}
					else if (lastParticleSpawn >= particlesSpace.value)
					{
						particle = new Particle(getColor() , 5 + Math.random() * 10, visual2abstract(pointsUser), radiusBtn.value,speed.value );
						addChild(particle);
						particles.push(particle);
						lastParticleSpawn = 0;
					} else {
						lastParticleSpawn++;
					}
				} else if (particlesNumber.value >= 0 && particlesNumber.value < particles.length) {
					var p:Particle = particles.pop();
					removeChild(p);
					p.dispose();
					p = null;
				}
			}
			for (i = 0; i < particles.length; i++) {
				particles[i].update();
			}
		}
		
		/**
		 * Add a point where the user clicked
		 * @param	e
		 */
		private function onClick(e:MouseEvent):void 
		{
			var p:VisualPoint =  new VisualPoint(e.stageX, e.stageY);
			addChild( p );
			pointsUser.push( p );
			onChange(null);
		}
		
		private function onChange(e:Event):void 
		{
			if (e != null)
				e.stopImmediatePropagation();
				
			if(sortPointButton.selected)
				pointsUser.sort(sortVisualPoint);
				
			generatePoint();
			
			if(sortPointButton.selected)
				points.sort(sortPoint);
			
			while (particles.length > 0){
				var p:Particle = particles.pop();
				p.dispose();
				removeChild(p);
			}
			
			draw();
		}
	}
}