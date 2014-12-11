package  
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Darren Vanstaen
	 */
	public class BaseTank extends MovieClip 
	{
		private var health:Number = 0;
		
		public function BaseTank() 
		{
			
		}
		
		static public function fireBullet(tank:Object, turret:Object, accuracy:Number):DisplayObject
		{
			
			//Index
			var shell:Bullet = new Bullet;
			
			//Values
			var tankPos:Point = Main.getPosFromAngle(tank.rotation);
			var turretPos:Point = Main.getPosFromAngle(tank.rotation + turret.rotation);
			
			//Properties
			//  Berekening voor X en Y: tank + (TankTurretArt.width + TankBulletArt.width/2) * turretPosFromAngle - turretOffset * tankPosFromAngle
			shell.x = tank.x + 115 * tank.scaleX * turretPos.x + (turret.x * tank.scaleX) * tankPos.x;
			shell.y = tank.y + 115 * tank.scaleX * turretPos.y + (turret.x * tank.scaleX) * tankPos.y;
			shell.scaleX = shell.scaleY = tank.scaleX;
			shell.rotation = tank.rotation + turret.rotation + (Math.random() - .5) * accuracy;
			
			Main.bullets.push(shell);
			return shell
		}
	}

}