package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Darren Vanstaen
	 */
	public class Crate extends MovieClip 
	{
		public var health:Number = 50;
		
		public function Crate() 
		{
			addChild(new CrateArt())
			addEventListener(Event.ENTER_FRAME, updateOnFrame);
		}
		
		private function updateOnFrame(e:Event):void 
		{
			if (!this.parent)
			{
				removeEventListener(Event.ENTER_FRAME, updateOnFrame);
			} else {
			}
		}
		
	}

}