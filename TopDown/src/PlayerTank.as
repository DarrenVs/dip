package  
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Darren Vanstaen
	 */
	public class PlayerTank extends BaseTank
	{
		//Values
		//  Turret
		private var turret:DisplayObject;
		private var rotateSpeed:Number = .2;
		private var currentTurretRotation:Number = 0
		
		//  Tank
		private var moveSpeed:Number = .2;
		private var currentSpeed:Point = new Point();
		private var currentRotateSpeed:Number = 0;
		public var health:Number = 100;
		
		//  Kogel
		static public var bulletNockback:Number = 10;
		private var fireAccuracy:Number = 20;
		
		//  Functions
		public function PlayerTank() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//Index
			addChild(new TankBodyArt());
			
			turret = addChild(new TankTurretArt());
			turret.x = -22.5;
			
			//Events
			addEventListener(Event.ENTER_FRAME, updateOnFrame);
			stage.addEventListener(MouseEvent.CLICK, onMouseDown);
		}
		
		//Events
		private function onMouseDown(e:Event):void 
		{
			if (!this.parent)
			{
				removeEventListener(Event.ENTER_FRAME, onMouseDown);
			} else {
				currentSpeed.y += Math.sin( turret.rotation * Math.PI / 180  - 90 ) * bulletNockback;
				currentRotateSpeed = turret.rotation / 20;
				stage.addChild(BaseTank.fireBullet(this, turret, fireAccuracy));
			}
		}
		
		private function updateOnFrame(e:Event):void 
		{
			if (!this.parent)
			{
				removeEventListener(Event.ENTER_FRAME, updateOnFrame);
			} else {
				if (health <= 0)
				{
					Main.playerTanks.pop();
					removeEventListener(Event.ENTER_FRAME, updateOnFrame);
				} else {
					//Update Resistance
					currentRotateSpeed += Main.input.x;
					currentSpeed.x = currentSpeed.y += Main.input.y;
					
					//Update Tank Position and Rotation
					var pos:Point = Main.getPosFromAngle(rotation);
					
					//Check for hitbox
					var newRotation:Number = rotation + currentRotateSpeed * rotateSpeed;
					var newPosition:Point = new Point(x + currentSpeed.x * pos.x * moveSpeed, y + currentSpeed.x * pos.y * moveSpeed)
					
					if ( ! Main.checkForHitbox( Main.hitBoxes, this, newPosition, newRotation, new Point(width * scaleX, 50 * scaleY) ) )
					{
						rotation = newRotation;
						x = newPosition.x;
						y = newPosition.y;
					} else {
						
						//Update Tank Position and Rotation for a boucne effect
						newPosition = new Point(x + -currentSpeed.x * pos.x * moveSpeed, y + -currentSpeed.x * pos.y * moveSpeed)
					}
					
					//Update Turret Rotation
					turret.rotation = -Main.getAngleFromPos(new Point(turret.x, turret.y), new Point(mouseX, mouseY)) - 90;
					
					//Apply ground Resistance
					currentRotateSpeed -= currentRotateSpeed / 10;
					currentSpeed.x -= currentSpeed.x / 10;
					currentSpeed.y -= currentSpeed.y / 10;
					
					if (currentSpeed.x < .01 && currentSpeed.x > -.01 && currentSpeed.y < .01 && currentSpeed.y > -.01)
					{
						currentSpeed.x = currentSpeed.y = 0
					}
				}
			}
		}
		
	}

}