package 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Darren Vanstaen
	 */
	public class Main extends Sprite 
	{
		//Values
		private var playerTank:PlayerTank;
		static public var bullets:Vector.<Bullet> = new Vector.<Bullet>;
		static public var input:Point = new Point();
		
		/** DataTypes:
			0 = Air
			1 = Wall
			2 = Crate
			3 = Player
			4 = Enemy
		*/
		private var levels:Array = [
			[
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
			],
		];
		
		static public var hitBoxes:Array;
		
		
		//Functions
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//Index
			playerTank = new PlayerTank();
			createTank();
			
			loadMap(levels[0]);
			
			//Events
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(Event.ENTER_FRAME, updateOnFrame);
		}
		
		private function updateOnFrame(e:Event):void 
		{
			for (var i:String in bullets)
			{
				bullets[i].updateOnFrame();
			}
		}
		
		private function loadMap(map:Array):void
		{
			for (var y:String in map) {
				for (var x:String in map[y]) {
					
					switch (map[y][x]) {
					case 1:
						var wall:DisplayObject = addChild(new StoneWallArt())
						Main.getScaleAndPosFromSpace(
							wall,
							new Point(stage.stageWidth, stage.stageHeight),
							new Point(map[0].length, map.length),
							new Point(Number(x), Number(y))
						);
						break
					case 2:
						var crate:DisplayObject = addChild(new CrateArt())
						Main.getScaleAndPosFromSpace(
							crate,
							new Point(stage.stageWidth, stage.stageHeight),
							new Point(map[0].length, map.length),
							new Point(Number(x), Number(y))
						);
						break
					}
				}
			}
		}
		
		private function createTank():void
		{
			addChild(playerTank);
		}
		
		static private function getScaleAndPosFromSpace(object:Object, space:Point, scale:Point, posInSpace:Point):void
		{
			// berekening x * (stage / scale)
			object.x = posInSpace.x * (space.x / scale.x);
			object.y = posInSpace.y * (space.y / scale.y);
			// Berekening (stage / map) / (Art-1)
			object.scaleX = (space.x / scale.x) / 99;
			object.scaleY = (space.y / scale.y) / 99;
		}
		
		static public function getPosFromAngle(angle:Number):Point
		{
			return new Point(
				Math.cos( angle * Math.PI / 180 ),
				Math.sin( angle * Math.PI / 180 )
			)
		}
		
		static public function getAngleFromPos(pos1:Point, pos2:Point):Number
		{
			return Math.atan2( pos1.x - pos2.x, pos1.y - pos2.y ) * 180 / Math.PI
		}
		
		//Events
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			switch (e.keyCode) {
			case Keyboard.W:
				input.y = 1;
				break;
			case Keyboard.S:
				input.y = -1;
				break;
			case Keyboard.D:
				input.x = 1;
				break;
			case Keyboard.A:
				input.x = -1;
				break;
			}
			
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.W || e.keyCode == Keyboard.S)
				input.y = 0;
			else if (e.keyCode == Keyboard.A || e.keyCode == Keyboard.D)
				input.x = 0;
			
		}
		
	}
	
}