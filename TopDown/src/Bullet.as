package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Darren Vanstaen
	 */
	public class Bullet extends MovieClip 
	{
		public function Bullet() 
		{
			addChild(new TankBulletArt);
		}
		
		public function updateOnFrame(i:Number):void
		{
			var pos:Point = Main.getPosFromAngle(rotation);
			x += pos.x * PlayerTank.bulletNockback;
			y += pos.y * PlayerTank.bulletNockback;
			
			if ( Main.checkForHitbox( Main.hitBoxes, this, new Point(x, y), rotation, new Point(width, height)) )
			{
				
				stage.removeChild(this);
				Main.bullets.splice(i, 1);
			}
		}
		
	}

}