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
		static public var turret:DisplayObject;
		static public var rotateSpeed:Number = .2;
		private var currentTurretRotation:Number = 0
		
		//  Tank
		static public var moveSpeed:Number = .2;
		static public var currentSpeed:Point = new Point();
		static public var currentRotateSpeed:Number = 0;
		
		//  Kogel
		static public var bulletNockback:Number = 10;
		static public var fireAccuracy:Number = 20;
		
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
			x = Math.random() * 800;
			y = Math.random() * 300;
			scaleX = scaleY = .3;
			
			turret = addChild(new TankTurretArt());
			turret.x = -22.5;
			
			//Events
			addEventListener(Event.ENTER_FRAME, updateOnFrame);
			stage.addEventListener(MouseEvent.CLICK, onMouseDown);
		}
		
		//Events
		private function onMouseDown(e:Event):void 
		{
			currentSpeed.y += Math.sin( turret.rotation * Math.PI / 180  - 90 ) * bulletNockback;
			currentRotateSpeed = turret.rotation / 20;
			fireBullet(this, turret, fireAccuracy)
		}
		
		private function updateOnFrame(e:Event):void 
		{
			//Update Resistance
			currentRotateSpeed += Main.input.x;
			currentSpeed.x = currentSpeed.y += Main.input.y;
			
			//Update Tank Position and Rotation
			rotation += currentRotateSpeed * rotateSpeed;
			var pos:Point = Main.getPosFromAngle(rotation);
			x += currentSpeed.x * pos.x * moveSpeed;
			y += currentSpeed.x * pos.y * moveSpeed;
			
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