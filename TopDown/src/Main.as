package 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.events.KeyboardEvent;
	import flash.text.engine.FontPosture;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Darren Vanstaen
	 */
	public class Main extends Sprite 
	{
		//Values
		static public var playerTank:DisplayObject;
		static public var bullets:Vector.<Object>
		static public var input:Point = new Point();
		static public var destroyedTanks:Number;
		private var myTimer:Timer = new Timer(0, 1);
		
		/** DataTypes:
			0 = Air
			1 = Wall
			2 = Crate
			3 = Player
			4 = Enemy
		*/
		static public var levels:Array = [
			[
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 4, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 2, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 3, 0, 1],
				[1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 0, 1],
				[1, 1, 2, 2, 2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 2, 1, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 1, 1, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 1, 1, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1],
				[1, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
				[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
			],
		];
		
		static public var hitBoxes:Vector.<Object>
		static public var playerTanks:Vector.<Object>
		static public var enemyTanks:Vector.<Object>
		
		
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
			//loadMap(levels[0]);
			
			//Events
			myTimer.addEventListener(TimerEvent.TIMER, runOnce);
			myTimer.start();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function runOnce(event:TimerEvent):void {
			loadMap(levels[0])
		}
		
		private function updateOnFrame(e:Event):void 
		{
			if (!myTimer.running && stage.numChildren > 1 && (destroyedTanks <= 0 || Main.playerTanks.length <= 0))
			{
				myTimer.addEventListener(TimerEvent.TIMER, runOnce);
				myTimer.start();
			}
			var i:String
			for (i in bullets)
			{
				bullets[i].updateOnFrame(Number(i));
			}
		}
		
		static public function checkForHitbox( hitboxes:Vector.<Object>, object:Object, newObjectPos:Point, newObjectRotation:Number, objectSize:Point ):Boolean
		{
			var i:String;
			var hit:Point = new Point(0, 0)
			
			for (i in hitboxes)
			{
				if (object != hitboxes[i])
				{
					if ((hitboxes[i].x + hitboxes[i].width/2 >= newObjectPos.x + objectSize.x/2 && hitboxes[i].x - hitboxes[i].width/2 <= newObjectPos.x + objectSize.x/2
					|| hitboxes[i].x + hitboxes[i].width/2 >= newObjectPos.x - objectSize.x/2 && hitboxes[i].x - hitboxes[i].width/2 <= newObjectPos.x - objectSize.x/2)
					&& (hitboxes[i].y + hitboxes[i].height/2 >= newObjectPos.y + objectSize.y/2 && hitboxes[i].y - hitboxes[i].height/2 <= newObjectPos.y + objectSize.y/2
					|| hitboxes[i].y + hitboxes[i].height / 2 >= newObjectPos.y - objectSize.y / 2 && hitboxes[i].y - hitboxes[i].height / 2 <= newObjectPos.y - objectSize.y / 2))
					{
						if (hitboxes[i].health) {
							if (hitboxes[i].health <= 0)
							{
								hitboxes[i].parent.removeChild(hitboxes[i]);
								hitboxes.splice(Number(i), 1);
							}
							hitboxes[i].health -= 20
						}
						return true
					}
				}
			}
			return false
		}
		
		private function loadMap(map:Array):void
		{
			stage.addEventListener(Event.ENTER_FRAME, updateOnFrame);
			hitBoxes = new Vector.<Object>;
			playerTanks = new Vector.<Object>;
			enemyTanks = new Vector.<Object>;
			bullets = new Vector.<Object>;
			destroyedTanks = 0;
			myTimer = new Timer(3000, 1);
			
			while (numChildren > 0) {
				removeChildAt(0);
			}
			while (stage && stage.numChildren > 1) {
				stage.removeChildAt(1);
			}
			
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
						
						Main.hitBoxes.push(wall);
						break
					case 2:
						var crate:DisplayObject = addChild(new Crate())
						Main.getScaleAndPosFromSpace(
							crate,
							new Point(stage.stageWidth, stage.stageHeight),
							new Point(map[0].length, map.length),
							new Point(Number(x), Number(y))
						);
						
						Main.hitBoxes.push(crate);
						break
					case 3:
						Main.playerTank = stage.addChild(new PlayerTank());
						Main.getScaleAndPosFromSpace(
							playerTank,
							new Point(stage.stageWidth, stage.stageHeight),
							new Point(map[0].length, map.length),
							new Point(Number(x), Number(y))
						);
						
						Main.hitBoxes.push(playerTank);
						Main.playerTanks.push(playerTank);
						break
					case 4:
						var enemyTank:DisplayObject = addChild(new EnemyTank(enemyTanks.length-1));
						Main.getScaleAndPosFromSpace(
							enemyTank,
							new Point(stage.stageWidth, stage.stageHeight),
							new Point(map[0].length, map.length),
							new Point(Number(x), Number(y))
						);
						
						destroyedTanks++
						
						Main.hitBoxes.push(enemyTank);
						Main.enemyTanks.push(enemyTank);
						break
					}
				}
			}
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