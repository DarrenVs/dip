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
	public class EnemyTank extends MovieClip 
	{
		public var health:Number = 100;
		public var turret:DisplayObject;
		public var index:Number;
		
		public function EnemyTank( i:Number )
		{
			index = i;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//Index
			addChild(new EnemyTankBodyArt());
			
			turret = addChild(new TankTurretArt());
			turret.x = -22.5;
			
			addEventListener(Event.ENTER_FRAME, updateOnFrame);
		}
		
		private function updateOnFrame(e:Event):void 
		{
			if (!this.parent)
			{
				removeEventListener(Event.ENTER_FRAME, updateOnFrame);
			} else {
				if (health <= 0)
				{
					addChild(new ExplosionArt());
					Main.destroyedTanks -= 1;
					removeEventListener(Event.ENTER_FRAME, updateOnFrame);
				}
				
				turret.rotation = -90 + -Main.getAngleFromPos(new Point(x, y), new Point(Main.playerTank.x, Main.playerTank.y))
				if (stage && Math.ceil(Math.random() * 30) == 1)
				{
					stage.addChild(BaseTank.fireBullet(this, turret, 10));
				}
			}
		}
	}

}