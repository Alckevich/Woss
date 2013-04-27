package 
{
  import flash.display.*;
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLVariables;
	import flash.text.engine.TextBlock;
	import flash.text.TextField;
	import flash.text.*;
	import flash.utils.Timer;
	import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	import vk.APIConnection;
	
	/**
	 * ...
	 * @author alex
	 */
	public class Study extends Screen {
		private var back:Sprite = new Sprite;
		public var windows:Array = [];
		public var blocks:Array = [];
		private var count:TextField;
		private var block:Block;
		private var buy_tank:Buy_tank;
		private var creat_window:Boolean = true;
		private var sip1:Sip_1 = new Sip_1;
		private var sip2:Sip_2 = new Sip_2;
		private var sip3:Sip_3 = new Sip_3;
		private var sip4:Sip_4 = new Sip_4;
		
		[Embed(source = "republic.png")]static private const republic_text:Class;
		private var republic:Bitmap = new Bitmap(new republic_text().bitmapData);
		[Embed(source = "sit.png")]static private const sit_text:Class;
		private var sit:Bitmap = new Bitmap(new sit_text().bitmapData);
		
		[Embed(source = "for_sip1.png")]static private const sip_1_text:Class;
		private var sip_1:Bitmap = new Bitmap(new sip_1_text().bitmapData);
		[Embed(source = "for_sip2.png")]static private const sip_2_text:Class;
		private var sip_2:Bitmap = new Bitmap(new sip_2_text().bitmapData);
		[Embed(source = "for_sip3.png")]static private const sip_3_text:Class;
		private var sip_3:Bitmap = new Bitmap(new sip_3_text().bitmapData);
		[Embed(source = "for_sip4.png")]static private const sip_4_text:Class;
		private var sip_4:Bitmap = new Bitmap(new sip_4_text().bitmapData);
		
	public function Study() {
			if (stage) start_init();
			else addEventListener(Event.ADDED_TO_STAGE, start_init);
		}
	private function start_init(e:Event = null):void {	
		back.graphics.clear();
		back.graphics.beginFill(0x000000, 0.9);
		back.graphics.drawRect(0, 0, 803, 600);
		back.graphics.endFill();
		addChild(back);
		
		sit.scaleY = 1.1;
		sit.x = 803 / 4 - sit.width / 2;
		sit.y = 20;
		addChild(sit);
		republic.x = 803 / 4 * 3 - republic.width / 2;
		republic.y = 20; 
		addChild(republic);
		
		block = new Block(sip_1, sip1);
		addChild(block);
		block.y = sit.y + 100;
		block.x = sit.x - block.width / 2 + sit.width / 2;
		block.gold = gold;
		block.silver = silver;
		block.experiences = experiences;
		blocks.push(block);
		
		block = new Block(sip_2, sip2);
		addChild(block);
		block.y = sit.y + 150;
		block.x = sit.x - block.width / 2 + sit.width / 2;
		block.gold = gold;
		block.silver = silver;
		block.experiences = experiences;
		blocks.push(block);
		
		block = new Block(sip_3, sip3);
		addChild(block);
		block.y = republic.y + 100;
		block.x = republic.x - block.width / 2  + republic.width / 2 + 80;
		block.gold = gold;
		block.silver = silver;
		block.experiences = experiences;
		blocks.push(block);
		
		block = new Block(sip_4, sip4);
		addChild(block);
		block.y = republic.y + 100;
		block.x = republic.x - block.width / 2  + republic.width / 2 - 80;
		block.gold = gold;
		block.silver = silver;
		block.experiences = experiences;
		blocks.push(block);
		
		stage.addEventListener(MouseEvent.MOUSE_MOVE, mouse_move);
		stage.addEventListener(MouseEvent.MOUSE_DOWN, mouse_down);
		stage.addEventListener(MouseEvent.MOUSE_UP, mouse_up);
		}
		public function next_blocks(my_sips:Array):void {
			for (var i:int = 0; i < blocks.length; i++) {
				if (my_sips.indexOf(blocks[i].type.type) >= 0) {
					blocks[i].removeEventListener(MouseEvent.CLICK, open);
					blocks[i].movie.buttonMode = false;
					blocks[i].movie.alpha = 0.5;
					if(blocks[i].movie.contains(blocks[i].count_t))blocks[i].movie.removeChild(blocks[i].count_t);
				}else if (!blocks[i].movie.contains(blocks[i].count_t)) {
					blocks[i].addEventListener(MouseEvent.CLICK, open);
					blocks[i].movie.buttonMode = true;
					blocks[i].movie.alpha = 1;
					if(!blocks[i].movie.contains(blocks[i].count_t))blocks[i].movie.addChild(blocks[i].count_t);
				}
			}
		}
		private function open(e:MouseEvent):void {
			for (var i:int = 0; i < windows.length; i++) {
				if (e.currentTarget.type == windows[i].type) {
					creat_window = false;
				}
			}
			if (creat_window) {
				buy_tank = new Buy_tank(e.currentTarget.type, e.currentTarget.type.sip_img);
				addChild(buy_tank);
				buy_tank.gold = gold;
				buy_tank.current_name = current_name;
				buy_tank.new_money(silver, experiences);
				buy_tank.close.addEventListener(MouseEvent.CLICK, close_window);
				buy_tank.otmena_m.addEventListener(MouseEvent.CLICK, close_window);
				buy_tank.addEventListener(MouseEvent.MOUSE_DOWN, goal);
				windows.push(buy_tank);
			}
			creat_window = true;
		}
		private function close_window(e:MouseEvent):void {
			for (var i:int = 0; i < windows.length; i++) {
				if (windows[i].close == e.currentTarget || windows[i].otmena_m == e.currentTarget) {
					removeChild(windows[i]);
					windows[i].close.addEventListener(MouseEvent.CLICK, close_window);
					windows.splice(i, 1);
				}
			}
		}
		private var isDragging:Boolean = false;
		private var lastMouseX:Number = 0;
		private var lastMouseY:Number = 0;
		
		private function mouse_move(e:MouseEvent):void 
		{
			if (!isDragging)
				return;
				
			var deltaX:Number = e.stageX - lastMouseX;
			var deltaY:Number = e.stageY - lastMouseY;
			
			lastMouseX = e.stageX;
			lastMouseY = e.stageY;
			
			for (var i:int = 0; i < windows.length; i++) {
				if (windows[i].drag == true) {
					windows[i].x += deltaX;
					windows[i].y += deltaY;
				}
			}
		}
		private function mouse_up(e:MouseEvent):void 
		{
			for (var i:int = 0; i < windows.length; i++) {
				windows[i].drag = false;
			}
			isDragging = false;
		}
		
		private function mouse_down(e:MouseEvent):void 
		{
			isDragging = true;
			lastMouseX = e.stageX;
			lastMouseY = e.stageY;
		}
		private function goal(e:MouseEvent):void 
		{
			for (var i:int = 0; i < windows.length; i++) {
				if (windows[i] == e.currentTarget) {
					setChildIndex(windows[i] , getChildIndex(windows[windows.length - 1]));
					var for_win:Buy_tank = windows[i];
					windows[i] = windows[windows.length - 1];
					windows[windows.length - 1] = for_win;
					
				}
			}
		}
	}
	
}
