package  
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Darren Vanstaen
	 */
	public class Bullet extends MovieClip 
	{
		private var bounces:Number = 1;
		
		public function Bullet() 
		{
			addChild(new TankBulletArt);
		}
		
		public function updateOnFrame():void
		{
			var pos:Point = Main.getPosFromAngle(rotation);
			x += pos.x * PlayerTank.bulletNockback;
			y += pos.y * PlayerTank.bulletNockback;
		}
		
	}

}