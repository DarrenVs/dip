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
		}
		
	}

}