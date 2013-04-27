package 
{
  import flash.display.*;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLVariables;
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
	public class Buy_tank extends Screen 
	{
		public var type:Sip;
		public var img:Bitmap;
		private var user:String;
		
		private var back:Sprite = new Sprite;
		private var back_0:Sprite = new Sprite;
		private var back_01:Sprite = new Sprite;
		private var back_1:Sprite = new Sprite;
		private var back_2:Sprite;
		
		private var t_for_up:TextField = new TextField;
		private var info:TextField = new TextField;
		private var my_point:TextField = new TextField;
		
		public var for_move:Sprite = new Sprite;
		public var table:MovieClip = new MovieClip;
		
		public var drag:Boolean = false;
		public var close:MovieClip = new MovieClip;
		
		public var buy_m:MovieClip = new MovieClip;
		public var otmena_m:MovieClip = new MovieClip;
		
		private var load_buy_sip:URLRequest = new URLRequest("http://alckevich.hut2.ru/buy_new_tank.php");
		private var loader:URLLoader = new URLLoader;
		private var vars:URLVariables = new URLVariables;
		
		private var box:Sprite = new Sprite;
		private var box_2:Sprite = new Sprite;
		private var box_text:TextField = new TextField;
		private var box_2_text:TextField = new TextField;
		
		private var line:Shape;
		
		private var glow:GlowFilter = new GlowFilter(0x000000);
		
		private var total_count:int = 0;
		private var total_experiences:int = 0;
		private var total_ammunition:int = 0;
		private var count_text:TextField = new TextField;
		private var silver_text:TextField = new TextField;
		private var star_text:TextField = new TextField;
		
		private var was_buy:Boolean = false;
		
		[Embed(source = "buy.png")]static private const buy_text:Class;
		private var buy_t:Bitmap = new Bitmap(new buy_text().bitmapData);
		[Embed(source = "otmena.png")]static private const otmena_text:Class;
		private var otmena_t:Bitmap = new Bitmap(new otmena_text().bitmapData);
		[Embed(source = "boxic.png")]static private const boxic_text:Class;
		private var boxic_t:Bitmap = new Bitmap(new boxic_text().bitmapData);
		private var boxic_2_t:Bitmap = new Bitmap(new boxic_text().bitmapData);
		[Embed(source = "star.png")]static private const star_texture:Class;
		private var star:Bitmap = new Bitmap(new star_texture().bitmapData);
		[Embed(source = "silver.png")]static private const silver_texture:Class;
		private var silver_t:Bitmap = new Bitmap(new silver_texture().bitmapData);
	//испавить закытие акон нажимая ангаp
	public function Buy_tank(_type:Sip, _img:Bitmap) {
			img = _img;
			type = _type
			if (stage) start_init();
			else addEventListener(Event.ADDED_TO_STAGE, start_init);
		}
	private function start_init(e:Event = null):void {	
			info.autoSize = TextFieldAutoSize.LEFT;
			info.htmlText = '<b><font color="#FFFFFF" size="12" face="Calibri">' + type.sip_info + '</font></b>';
			info.y = 100;
			info.x = 5;
			
			boxic_t.scaleX = boxic_t.scaleY = 1;
			boxic_2_t.scaleX = boxic_2_t.scaleY = 1;
			
			back.graphics.beginFill(0xCCCCCC, 1);
			back.graphics.drawRect(0, 0, info.width+10, info.height+180+5/2);
			back.graphics.endFill();
			table.addChild(back);
			
			back_0.graphics.beginFill(0x000000, 1);
			back_0.graphics.drawRect(5/2, 15+15, info.width+5, info.height+165-15);
			back_0.graphics.endFill();
			table.addChild(back_0);
			back_01.graphics.beginFill(0x000000, 1);
			back_01.graphics.drawRect(5/2, 15, info.width+5, info.height+165);
			back_01.graphics.endFill();
			table.addChild(back_01);
					
			t_for_up.autoSize = TextFieldAutoSize.LEFT;
			t_for_up.htmlText = '<b><font color="#000000" size="12" face="Calibri">' + "Покупка: "+ type.name + '</font></b>';
			table.addChild(t_for_up);
			
			my_point.autoSize = TextFieldAutoSize.LEFT;
			my_point.textColor = 0xFFFFFF;
			my_point.x = 5;
			my_point.y = back_1.y+back_1.height;
			table.addChild(my_point);
			
			for_move.graphics.beginFill(0x8B0000, 0);
			for_move.graphics.drawRect(0, 0, info.width+5, 10+5/2);
			for_move.graphics.endFill();
			for_move.addEventListener(MouseEvent.MOUSE_DOWN, move_bar);
			table.addChild(for_move);
			
			back_2 = new Sprite;
			back_2.graphics.beginFill(0x222222, 1);
			back_2.graphics.drawRect(-5, -3/2, 10, 3);
			back_2.rotation = 45;
			back_2.graphics.endFill();
			close.addChild(back_2);
			
			back_2 = new Sprite;
			back_2.graphics.beginFill(0x222222, 1);
			back_2.graphics.drawRect(-5, -3/2, 10, 3);
			back_2.rotation = -45;
			back_2.graphics.endFill();
			close.addChild(back_2);
			close.x = info.width;
			close.y = 7;
			close.buttonMode = true;
			table.addChild(close);
			
			type.sip_img.scaleX = type.sip_img.scaleY = 0.8;
			type.sip_img.x = table.width / 2 - type.sip_img.width / 2;
			type.sip_img.y = 10;
			table.addChild(type.sip_img);
			
			table.addChild(info);
			
			var line:Shape = new Shape;
			line.graphics.lineStyle(1.2, 0xCCCCCC, 0.9);
			line.graphics.moveTo(info.width - 15, 0);
			line.graphics.lineTo(20, 0);
			line.y = info.height + 105;
			table.addChild(line);
			
			box.graphics.beginFill(0x222222, 0.8);
			box.graphics.lineStyle(1, 0x999999, 0.5);
			box.graphics.drawRect(0, 0, 10, 10);
			box.x = info.x+2;
			box.y = info.height + 102 + box.height;
			box.buttonMode = true;
			box.addEventListener(MouseEvent.CLICK, click_box);
			table.addChild(box);
			
			box_text.autoSize = TextFieldAutoSize.LEFT;
			box_text.htmlText = '<b><font color="#FFFFFF" size="12" face="Calibri">' + "Обучение экипажа" + '</font></b>';
			box_text.y = box.y - box.height/2+1;
			box_text.x = box.x + box.width + 5;
			table.addChild(box_text);
			
			box_2.graphics.beginFill(0x222222, 0.8);
			box_2.graphics.lineStyle(1, 0x999999, 0.5);
			box_2.graphics.drawRect(0, 0, 10, 10);
			box_2.x = info.x+2;
			box_2.y = info.height + 105 + box.height*2;
			box_2.buttonMode = true;
			box_2.addEventListener(MouseEvent.CLICK, click_box_2);
			table.addChild(box_2);
			
			box_2_text.autoSize = TextFieldAutoSize.LEFT;
			box_2_text.htmlText = '<b><font color="#FFFFFF" size="12" face="Calibri">' + "Загpузить базовый боекомплект" + '</font></b>';
			box_2_text.y = box_2.y - box_2.height/2+1;
			box_2_text.x = box_2.x + box_2.width + 5;
			table.addChild(box_2_text);
			
			line = new Shape;
			line.graphics.lineStyle(1.2, 0xCCCCCC, 0.9);
			line.graphics.moveTo(info.width - 15, 0);
			line.graphics.lineTo(20, 0);
			line.y = info.height + 145;
			table.addChild(line);
			
			total_count = type.cost;
			count_text.autoSize = TextFieldAutoSize.LEFT;
			count_text.htmlText = '<b><font color="#FFFFFF" size="12" face="Calibri">' + "Итого:" + '</font></b>';
			count_text.y = info.height + 145;
			count_text.x = box_2.x;
			table.addChild(count_text);
			
			star_text.autoSize = TextFieldAutoSize.LEFT;
			star_text.htmlText = '<b><font color="#FFFFFF" size="12" face="Calibri">' + "0" + '</font></b>';
			star_text.y = count_text.y;
			star_text.x = info.x + count_text.width +10;
			table.addChild(star_text);
			
			star.x = star_text.x+star_text.width;
			star.y = count_text.y+3;
			table.addChild(star);
			
			silver_text.autoSize = TextFieldAutoSize.LEFT;
			silver_text.htmlText = '<b><font color="#FFFFFF" size="12" face="Calibri">' + type.cost + '</font></b>';
			silver_text.y = count_text.y;
			silver_text.x = info.x + count_text.width + star_text.width + star.width + 15;
			table.addChild(silver_text);
			
			silver_t.x = silver_text.x + silver_text.width;
			silver_t.y = count_text.y+silver_t.height/2;
			table.addChild(silver_t);
			
			buy_m.addChild(buy_t);
			buy_m.y = info.height+163;
			buy_m.scaleX = 1.2;
			buy_m.x = info.width - buy_m.width * 2 -10;
			buy_m.alpha = 0.5;
			table.addChild(buy_m);
			
			otmena_m.addChild(otmena_t);
			otmena_m.y = info.height + 163;
			otmena_m.scaleX = 1.2;
			otmena_m.x = info.width - otmena_m.width;
			otmena_m.buttonMode = true;
			table.addChild(otmena_m);
			
			addChild(table);
			
			table.filters = [glow];
		}
		private function click_box(e:MouseEvent):void {
			if (!table.contains(boxic_t)) {
				boxic_t.x = box.x-1;
				boxic_t.y = box.y-3;
				table.addChild(boxic_t);
				total_experiences += type.experiences;
				total_ammunition += type.ammunition;
				star_text.htmlText = '<b><font color="#FFFFFF" size="12" face="Calibri">' + total_experiences + '</font></b>';
				star.x = star_text.x + star_text.width;
				silver_text.x = info.x + count_text.width + star_text.width + star.width + 15;
				silver_t.x = silver_text.x + silver_text.width;
			}else if(table.contains(boxic_t)){
				table.removeChild(boxic_t);
				total_experiences -= type.experiences;
				total_ammunition -= type.ammunition;
				star_text.htmlText = '<b><font color="#FFFFFF" size="12" face="Calibri">' + total_experiences + '</font></b>';
				star.x = star_text.x + star_text.width;
				silver_text.x = info.x + count_text.width + star_text.width + star.width + 15;
				silver_t.x = silver_text.x + silver_text.width;
			}
			new_total();
		}
		private function click_box_2(e:MouseEvent):void {
			if (!table.contains(boxic_2_t)) {
				boxic_2_t.x = box_2.x-1;
				boxic_2_t.y = box_2.y-3;
				table.addChild(boxic_2_t);
				total_count += type.ammunition;
				silver_text.htmlText = '<b><font color="#FFFFFF" size="12" face="Calibri">' + total_count + '</font></b>';
				silver_t.x = silver_text.x + silver_text.width;
			}else if(table.contains(boxic_2_t) && !was_buy){
				table.removeChild(boxic_2_t);
				total_count -= type.ammunition;
				silver_text.htmlText = '<b><font color="#FFFFFF" size="12" face="Calibri">' + total_count + '</font></b>';
				silver_t.x = silver_text.x + silver_text.width;
			}
			new_total();
		}
		private function move_bar(e:MouseEvent):void {
			drag = true;
		}
		private function new_total():void {
			if ((int(silver.text) < total_count || int(experiences.text) < total_experiences) && buy_m.alpha == 1) {
				buy_m.buttonMode = false;
				buy_m.removeEventListener(MouseEvent.MOUSE_DOWN, buy_new_sip);
				buy_m.alpha = 0.5;
			}else if(buy_m.alpha!=1 && int(silver.text) >= total_count && int(experiences.text)>=total_experiences  && !was_buy){
				buy_m.buttonMode = true;
				buy_m.addEventListener(MouseEvent.MOUSE_DOWN, buy_new_sip);
				buy_m.alpha = 1;
			}
		}
		public function new_money(_silver:TextField, _experiences:TextField):void {
			silver = _silver;
			experiences = _experiences;
			if ((int(silver.text) < type.cost || int(experiences.text)<type.experiences) && buy_m.alpha==1) {
				buy_m.buttonMode = false;
				buy_m.removeEventListener(MouseEvent.MOUSE_DOWN, buy_new_sip);
				buy_m.alpha = 0.5;
			}else if(buy_m.alpha!=1 && int(silver.text) >= type.cost && int(experiences.text)>=type.experiences  && !was_buy){
				buy_m.buttonMode = true;
				buy_m.addEventListener(MouseEvent.MOUSE_DOWN, buy_new_sip);
				buy_m.alpha = 1;
			}
		}
		private function buy_new_sip(e:MouseEvent):void {
			if (int(silver.text) >= total_count) {
				load_buy_sip.method = URLRequestMethod.POST;
				vars['name'] = current_name.text;//current_name.text;
				vars['cost'] = total_count;
				vars['experiences'] = total_experiences;
				vars['type'] = type.type;
				vars['ammunition'] = total_ammunition;
				load_buy_sip.data = vars;
				loader.load(load_buy_sip);
				buy_m.removeEventListener(MouseEvent.MOUSE_DOWN, buy_new_sip);
				buy_m.buttonMode = false;
				buy_m.alpha = 0.5;
				was_buy = true;
			}
		}
	}
	
}
