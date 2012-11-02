package  
{
	import com.bit101.components.NumericStepper;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * NumericStepperFix - Bezier
	 * @version 1.0
	 * @author David Ronai
	 */
	public class NumericStepperFix extends NumericStepper 
	{
		
		//================== VARIABLES ========================
		
		
		
		//================== CONSTRUCTOR ======================
		
		public function NumericStepperFix(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, defaultHandler:Function=null) 
		{
			super(parent, xpos, ypos, defaultHandler);
			addEventListener(MouseEvent.CLICK,onClick);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			e.stopImmediatePropagation();
		}
		
		//================== PUBLIC METHODS ===================
		
		
		
		//================== PRIVATE METHODS ==================
		
		override protected function onMinus(event:MouseEvent):void 
		{
			event.stopImmediatePropagation();
			super.onMinus(event);
		}
		
		override protected function onPlus(event:MouseEvent):void 
		{
			event.stopImmediatePropagation();
			super.onPlus(event);
		}
		
		//================== LISTENERS ========================
		
		
		
		//================== GETTERS AND SETTERS===============
		
		
	}

}