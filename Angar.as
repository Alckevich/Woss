package {
import alternativa.engine3d.controllers.SimpleObjectController;
import alternativa.engine3d.core.Camera3D;
import alternativa.engine3d.core.Light3D;
import alternativa.engine3d.core.Object3D;
import alternativa.engine3d.core.Resource;
import alternativa.engine3d.core.View;
import alternativa.engine3d.lights.AmbientLight;
import alternativa.engine3d.lights.DirectionalLight;
import alternativa.engine3d.lights.OmniLight;
import alternativa.engine3d.lights.SpotLight;
import alternativa.engine3d.materials.FillMaterial;
import alternativa.engine3d.materials.VertexLightTextureMaterial;
import alternativa.engine3d.objects.SkyBox;
import alternativa.engine3d.primitives.Box;
import alternativa.engine3d.primitives.Plane;
import alternativa.engine3d.resources.BitmapCubeTextureResource;
import alternativa.engine3d.resources.BitmapTextureResource;
import alternativa.engine3d.shadows.DirectionalLightShadow;
import alternativa.engine3d.shadows.Shadow;
import alternativa.physics3dintegration.VertexLightMaterial;
import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.events.*;
import flash.events.MouseEvent;
import alternativa.engine3d.core.events.MouseEvent3D;
import flash.events.StatusEvent;
import flash.events.TimerEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLVariables;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.utils.Timer;
import vk.APIConnection;
import flash.net.URLRequestMethod;
 
import flash.display.Sprite;
import flash.display.Stage3D;
import flash.events.Event;
 
public class Angar extends Screen {
    private var stage3D:Stage3D;
    private var camera:Camera3D;
    private var rootContainer:Object3D;
    private var controller:SimpleObjectController;
    public var sip_1:Sip_1 = new Sip_1;
  public var sip_2:Sip_2 = new Sip_2;
	public var sip_3:Sip_3 = new Sip_3;
	public var sip_4:Sip_4 = new Sip_4;
	private var light:SpotLight
	public var main_sip:Sip;
	private var movie:MovieClip;
	private var damage:Number = 0;
	private var damage_sprite:Sprite = new Sprite;
	private var damage_text:TextField = new TextField;
	private var deffence:Number = 0;
	private var deffence_sprite:Sprite = new Sprite;
	private var deffence_text:TextField = new TextField;
	private var speed:Number = 0;
	private var speed_sprite:Sprite = new Sprite;
	private var speed_text:TextField = new TextField;
	private var rot:Number = Math.PI / 180 * 45;
	private var text_mode:TextField = new TextField;
	private var movie_mode:MovieClip = new MovieClip;
	private var plane:Plane = new Plane(60, 60, 30,30);
	private var skyBox:SkyBox;
	private var s:DirectionalLightShadow;
	private var but:MovieClip = new MovieClip;
	private var States_Y:Number = 150;
	private var States_X:Number = 20;
	private var name_table:MovieClip = new MovieClip;
	private var sip_name:TextField = new TextField;
	private var bar:MovieClip;
	private var stat_t:TextField;
	private var load_states:States = new States;
	private var load_study:Study = new Study;
	private var back:Sprite = new Sprite;
	private var gotov:TextField = new TextField;
	
	private var ToMoney_loader:URLLoader;
	private var ToMoney:URLRequest;
	private var vars:URLVariables = new URLVariables();
	private var time_for_Money:Timer = new Timer(1000, 5);
	
	private var load_sip:URLRequest = new URLRequest("http://alckevich.hut2.ru/my_sip.php");
	private var loader_sip:URLLoader = new URLLoader;
	private var  vars_sip:URLVariables = new URLVariables;
	public var my_sips:Array = [];
	public var weapons:Array = [];
	public var studens:Array = [];
	
	[Embed(source = "sip_4.png")]static private const sip_4_text:Class;
		private var sip_4_t:Bitmap = new Bitmap(new sip_4_text().bitmapData);
	[Embed(source = "sip_3.png")]static private const sip_3_text:Class;
		private var sip_3_t:Bitmap = new Bitmap(new sip_3_text().bitmapData);
	[Embed(source = "sip_2.png")]static private const sip_2_text:Class;
		private var sip_2_t:Bitmap = new Bitmap(new sip_2_text().bitmapData);
	[Embed(source="sip_1.png")]static private const sip_1_text:Class;
		private var sip_1_t:Bitmap = new Bitmap(new sip_1_text().bitmapData);
	[Embed(source="back.jpg")]static private const floor_text:Class;
		private var floor_t:BitmapTextureResource = new BitmapTextureResource(new floor_text().bitmapData);
	[Embed(source="but.png")]static private const but_text:Class;
		private var but_t:Bitmap = new Bitmap(new but_text().bitmapData);
	[Embed(source = "money.png")]static private const money_text:Class;
		private var money_t:Bitmap = new Bitmap(new money_text().bitmapData);
	[Embed(source="next.png")]static private const next_text:Class;
		private var next:Bitmap = new Bitmap(new next_text().bitmapData);
		private var next_2:Bitmap = new Bitmap(new next_text().bitmapData);
 
	public function Angar(type:Number) {
			current_name.text = "Alckevich Alexander";
			load_study.current_name.text = current_name.text;
			sip_type = type;
			if (stage) start_init();
			else addEventListener(Event.ADDED_TO_STAGE, start_init);
		}
	private function start_init(e:Event = null):void {
		call_loader_sip();
		ReLoad_money(new TimerEvent(TimerEvent.TIMER_COMPLETE, false, false));
		
		camera = new Camera3D(0.01, 10000000000);
        camera.x = -5;
        camera.y = -20;
        camera.z = 10;
		camera.lookAt(0, 0, 0);
        camera.view = new View(803, 600, false, 0xFFFFFF, 0, 4);
		camera.view.hideLogo();
        addChild(camera.view);
 
        rootContainer = new Object3D();
        rootContainer.addChild(camera);
		
		plane.setMaterialToAllSurfaces(new VertexLightMaterial(0xFFFFFF));
		plane.z = -4;
		rootContainer.addChild(plane);
		
		skyBox = new SkyBox(30000, 
				new FillMaterial(0x000000), 
				new FillMaterial(0x000000), 
				new FillMaterial(0x000000),  
				new FillMaterial(0x000000),  
				new FillMaterial(0x000000),  
				new FillMaterial(0x000000), 0.0001);
		rootContainer.addChild(skyBox);
		
		//text_mode.htmlText = '<b><font color="#FFFFFF" size="13">Дополнительные способности:</font></b> \n' + main_sip.mode_text;
		text_mode.autoSize = TextFieldAutoSize.LEFT;
		movie_mode.addChild(text_mode);
		movie_mode.x = 20;
		movie_mode.y = 60 + States_Y;
		addChild(movie_mode);
		
		speed_text.text = String("Скорость: ");
		speed_text.textColor = 0xFFFFFF;
		speed_text.autoSize = TextFieldAutoSize.LEFT;
		speed_text.y = 0 + States_Y;
		speed_text.x = 0 + States_X
		addChild(speed_text);
		addChild(speed_sprite);
		
		deffence_text.text = String("Прочность: ");
		deffence_text.textColor = 0xFFFFFF;
		deffence_text.autoSize = TextFieldAutoSize.LEFT;
		deffence_text.y = 15 +States_Y;
		deffence_text.x = 0 +States_X;
		addChild(deffence_text);
		addChild(deffence_sprite);
		
		damage_text.text = String("Урон: ");
		damage_text.textColor = 0xFFFFFF;
		damage_text.autoSize = TextFieldAutoSize.LEFT;
		damage_text.y = 30 + States_Y;
		damage_text.x = 0 + States_X;
		addChild(damage_text);
		addChild(damage_sprite);
		
		s = new DirectionalLightShadow(10, 10, -3.9, 4, 1024, 0.2);
		s.addCaster(plane);
		//s.addCaster(main_sip.Container);
		s.biasMultiplier = .98;
		
		light = new SpotLight(0xFFFFFF, 0 , 22.5, 0.3, 2.0);
		light.shadow = s;
		light.lookAt(0,0,-1);
		light.x = 0;
		light.y = 0;
		light.z = 15;
		/*light.x = -1000;
		light.y = 200;
		light.z = 1000;*/
		light.intensity = 1.7;
		rootContainer.addChild(light);
		light.shadow = s;
		//s.debug = true;
		time_for_Money.addEventListener(TimerEvent.TIMER_COMPLETE, ReLoad_money);
		time_for_Money.start();
		
		movie = new MovieClip;
		movie.addChild(money_t);
		gold.autoSize = TextFieldAutoSize.LEFT;
		gold.text = "0";
		gold.textColor = 0xFFFFFF;
		gold.x = - experiences.width;
		gold.y = 0;
		movie.addChild(gold);
		silver.autoSize = TextFieldAutoSize.LEFT;
		silver.text = "0";
		silver.textColor = 0xFFFFFF;
		silver.x = - experiences.width;
		silver.y = 25;
		movie.addChild(silver);
		experiences.autoSize = TextFieldAutoSize.LEFT;
		experiences.text = "0";
		experiences.textColor = 0xFFFFFF;
		experiences.x = - experiences.width;
		experiences.y = 51;
		movie.addChild(experiences);
		movie.buttonMode = true;
		movie.y = 20;
		movie.x = 700;
		movie.cacheAsBitmap = true;
		addChild(movie);
		
		back.graphics.beginFill(0x111111, 0.2);
		back.graphics.drawRect(0, 0, stage.width, 75);
		back.graphics.endFill();
		back.y = stage.height - back.height - 21.5;
		addChild(back);
		
		movie = new MovieClip;
		movie.addChild(next_2);
		movie.buttonMode = true;
		movie.scaleX = -1;
		movie.scaleY = 1;
		movie.y = 600 - movie.height-27;
		movie.x = movie.width+10;
		//movie.addEventListener(MouseEvent.CLICK, back);
		movie.cacheAsBitmap = true;
		addChild(movie);
		
		movie = new MovieClip;
		movie.addChild(next);
		movie.buttonMode = true;
		movie.y = 600 - movie.height-27;
		movie.x = stage.width-movie.width-10;
		//movie.addEventListener(MouseEvent.CLICK, back);
		movie.cacheAsBitmap = true;
		addChild(movie);
		
		for (var i:int = 0; i < 8; i++) {
			movie = new MovieClip;
			var a:Sprite = new Sprite;
			a.graphics.beginFill(0x333333, 0.1);
			a.graphics.lineStyle(2, 0x111111, 1);
			a.graphics.drawRect(0, 0, 130, 107);
			a.y = 10;
			a.x = -1;
			movie.addChild(a);
			movie.buttonMode = true;
			movie.scaleX = movie.scaleY = 0.6;
			movie.y = 600 - movie.height-31;
			movie.x = 50 + (movie.width + 10) * i;
			movie.cacheAsBitmap = true;
			addChild(movie);
		}
		
		but.addChild(but_t);
		but.x = 803 / 2 - but.width / 2;
		but.y = 30;
		but.buttonMode = true;
		but.addEventListener(MouseEvent.CLICK, start_game);
		addChild(but);
		
		gotov.autoSize = TextFieldAutoSize.CENTER;
		gotov.height = 20;
		gotov.htmlText = '<b><font color="#8B1A1A" size="14" face="Calibri">' + "Ангаp пуст!" + '</font></b>';
		gotov.x = stage.width / 2 - gotov.width / 2;
		gotov.y = stage.height - 130;
		addChild(gotov);
		
		bar = new MovieClip;
		stat_t = new TextField;
		stat_t.autoSize = TextFieldAutoSize.LEFT;
		stat_t.height = 20;
		stat_t.htmlText = '<b><font color="#CDB79E" size="14" face="Calibri">' + "СТАТИСТИКА" + '</font></b>';
		bar.addChild(stat_t);
		var b:Sprite = new Sprite;
		b.graphics.beginFill(0x888888, 0);
		b.graphics.drawRect(stat_t.x, 0, stat_t.width, stat_t.height);
		b.graphics.endFill();
		bar.addChild(b);
		bar.x = but.x + but.width/2 - stat_t.width/2;
		bar.y = but.y + 50;
		bar.buttonMode = true;
		bar.addEventListener(MouseEvent.CLICK, open_states);
		addChild(bar);
		
		bar = new MovieClip;
		stat_t = new TextField;
		stat_t.autoSize = TextFieldAutoSize.LEFT;
		stat_t.height = 20;
		stat_t.htmlText = '<b><font color="#CDB79E" size="14" face="Calibri">' + "ИССЛЕДОВАНИЯ" + '</font></b>';
		bar.addChild(stat_t);
		b = new Sprite;
		b.graphics.beginFill(0x888888, 0);
		b.graphics.drawRect(stat_t.x, 0, stat_t.width, stat_t.height);
		b.graphics.endFill();
		bar.addChild(b);
		bar.buttonMode = true;
		bar.addEventListener(MouseEvent.CLICK, open_study);
		addChild(bar);
		bar.x = but.x + but.width/2 - stat_t.width/2+bar.width;
		bar.y = but.y + 50;
		
		bar = new MovieClip;
		stat_t = new TextField;
		stat_t.autoSize = TextFieldAutoSize.LEFT;
		stat_t.height = 20;
		stat_t.htmlText = '<b><font color="#CDB79E" size="14" face="Calibri">' + "АНГАP" + '</font></b>';
		bar.addChild(stat_t);
		b = new Sprite;
		b.graphics.beginFill(0x888888, 0);
		b.graphics.drawRect(stat_t.x, 0, stat_t.width, stat_t.height);
		b.graphics.endFill();
		bar.addChild(b);
		bar.addChild(b);
		bar.buttonMode = true;
		bar.addEventListener(MouseEvent.CLICK, open_angar);
		addChild(bar);
		bar.x = but.x + but.width / 2 - stat_t.width / 2 - bar.width-30;
		bar.y = but.y + 50;
		
        stage3D = stage.stage3Ds[0];
        stage3D.addEventListener(Event.CONTEXT3D_CREATE, init);
        stage3D.requestContext3D();
		
		stage.addEventListener(MouseEvent.MOUSE_MOVE, mouse_move);
		stage.addEventListener(MouseEvent.MOUSE_DOWN, mouse_down);
		stage.addEventListener(MouseEvent.MOUSE_UP, mouse_up);
		
		stage.addEventListener(KeyboardEvent.KEY_DOWN, down);
		load_states.close.addEventListener(MouseEvent.CLICK, close_window);
		udalit();
    }
	private function call_loader_sip():void {
		load_sip.method = URLRequestMethod.POST;
		vars['name'] = current_name.text;
		load_sip.data = vars;
		loader_sip.load(load_sip);
		loader_sip.addEventListener(Event.COMPLETE , load_sip_complete);
	}
	private function ReLoad_money(e:TimerEvent):void {
		load_money(current_name.text);	
		time_for_Money.reset();
		time_for_Money.start();
	}
	private function load_money(name:String):void {
		ToMoney = new URLRequest('http://alckevich.hut2.ru/money.php');
		ToMoney.method = URLRequestMethod.POST;
		ToMoney_loader = new URLLoader();
		ToMoney_loader.addEventListener(Event.COMPLETE, onComplete_load_Money);
		vars['name'] = current_name.text;
		ToMoney.data = vars;
		ToMoney_loader.load(ToMoney);
	}
	private function onComplete_load_Money(e:Event):void{
			call_loader_sip();
			var str:String = new String(e.target.data);
			gold.text = new String(str.slice(0, str.indexOf("+")));
			gold.x = - gold.width;
			str = str.substring(str.indexOf("+") + 1, str.length);
			load_study.gold = gold;
			
			silver.text = new String(str.slice(0, str.indexOf("+")));
			silver.x = - silver.width;
			str = str.substring(str.indexOf("+") + 1, str.length);
			load_study.silver = silver;
			
			experiences.text = new String(str.slice(0, str.indexOf("+")));
			experiences.x = - experiences.width;
			load_study.experiences = experiences;
			for (var i:int; i < load_study.windows.length; i++) {
				load_study.windows[i].gold = gold;
				load_study.windows[i].new_money(silver, experiences);
			}
	}
	private function close_window(e:MouseEvent):void {
		if (contains(load_states)) removeChild(load_states);
	}
	private function open_states(e:MouseEvent):void {
		if (!contains(load_states)) addChild(load_states);
		load_study.next_blocks(my_sips);
	}
	private function open_study(e:MouseEvent):void {
		if (!contains(load_study)) addChild(load_study);
		load_study.y = 100;
	}
	private function open_angar(e:MouseEvent):void {
		if (contains(load_study)) removeChild(load_study);
		if (contains(load_states)) removeChild(load_states);
	}
	private function udalit():void {
			sip_name.textColor = 0xFFFFFF;
			sip_name.autoSize = TextFieldAutoSize.RIGHT;
			sip_name.height = 20;
			if(main_sip != null)sip_name.htmlText = '<b><font color="#FFFFFF" size="14">' + main_sip.sip_name + '</font></b>';
			sip_name.x = - sip_name.width - 20;
			
			name_table.addChild(sip_name);
		
			current_name.textColor = 0xFFFFFF;
			//current_name.type = TextFieldType.INPUT;
			name_table.addChild(current_name);
			
			
			name_table.x = but.x;
			name_table.y = but.y + but.height / 2 - 10;
			addChild(name_table);
			current_name.autoSize = TextFieldAutoSize.RIGHT;
			current_name.htmlText = '<b><font color="#FFFFFF" size="14">'+ current_name.text + '</font></b>';
			load_states.current_name.text = current_name.text;
			current_name.x = 145;
			current_name.height = 20;
	}
	private function onProfileLoaded(data: Object):void{
			current_name.autoSize = TextFieldAutoSize.RIGHT;
			current_name.height = 20;
			current_name.htmlText = '<b><font color="#FFFFFF" size="14">'+ data[0]['first_name'] + " " + data[0]['last_name'] + '</font></b>';
			load_states.current_name.text = current_name.text;
			load_study.current_name.text = current_name.text;
			current_name.x = 145; 
			load_money(current_name.text);
			for (var i:int; i < load_study.windows.length; i++) {
				load_study.windows[i].current_name.text= current_name.text;
			}
	}
	private function load_sip_complete(e:Event):void {
		var str:String = new String(e.target.data);
		var num:Number = new Number(int(str.slice(0, str.indexOf("+"))));
		str = str.substring(str.indexOf("+") + 1, str.length)
		for (var i:int = 0; i < num; i++) {
			if(my_sips.indexOf(int(str.slice(0, str.indexOf("-"))))<0){
				my_sips.push(int(str.slice(0, str.indexOf("-"))));
				str = str.substring(str.indexOf("-") + 1, str.length);
				weapons.push(int(str.slice(0, str.indexOf("-"))));
				str = str.substring(str.indexOf("-") + 1, str.length);
				studens.push(int(str.slice(0, str.indexOf("+"))));
			}
			str = str.substring(str.indexOf("+") + 1, str.length); 
		}
			load_study.next_blocks(my_sips);
			
		var isCont:Boolean = true;
		for (i = 0; i < my_sips.length; i++) {
			movie = new MovieClip;
			
			switch (my_sips[i]) {
				case 1:
					if (!movie.contains(sip_1_t)) {
						movie.addChild(sip_1_t);
						movie.addEventListener(MouseEvent.CLICK, to_sip_1);
						if (main_sip == null) next_sip(sip_1);
						isCont = false;
					}
					break;
				case 2:
					if (!movie.contains(sip_2_t)) {
						movie.addChild(sip_2_t);
						movie.addEventListener(MouseEvent.CLICK, to_sip_2);
						if (main_sip == null) next_sip(sip_2);
						isCont = false;
					}
					break;
				case 3:
					if (!movie.contains(sip_3_t)) {
						movie.addChild(sip_3_t);
						movie.addEventListener(MouseEvent.CLICK, to_sip_3);
						if (main_sip == null) next_sip(sip_3);
						isCont = false;
					}
					break;
				case 4:
					if (!movie.contains(sip_4_t)) {
						movie.addChild(sip_4_t);
						movie.addEventListener(MouseEvent.CLICK, to_sip_4);
						if (main_sip == null) next_sip(sip_4);
						isCont = false;
					}
					break;
				default:break;
			}
			if(!isCont){
				movie.buttonMode = true;
				movie.scaleX = movie.scaleY = 0.6;
				movie.y = 600 - movie.height - 20;
				movie.x = 50+(130*0.6+11) * i;
				movie.cacheAsBitmap = true;
				addChildAt(movie, getChildIndex(gotov));
			}
		}
	}
	public function start_game(e:MouseEvent):void {
			if(main_sip != null)dispatchEvent(new StatusEvent(StatusEvent.STATUS, false, false, "", "gotoGame"));
	}
	private function to_sip_1(e:MouseEvent):void {
		next_sip(sip_1);
	}
	private function to_sip_2(e:MouseEvent):void {
		next_sip(sip_2);
	}
	private function to_sip_3(e:MouseEvent):void {
		next_sip(sip_3);
	}
	private function to_sip_4(e:MouseEvent):void {
		next_sip(sip_4);
	}
	private function next_sip(sip:Sip):void {
		s.clearCasters();
		if(main_sip != null)_delete(main_sip.Container);
		main_sip = sip;
		s.addCaster(main_sip.Container);
		main_sip.Container.rotationZ = rot;
		add_item(main_sip.Container);
		text_mode.htmlText = '<b><font color="#FFFFFF" size="13">Дополнительные способности:</font></b> \n' + main_sip.mode_text;
		sip_name.htmlText = '<b><font color="#FFFFFF" size="14">' + main_sip.sip_name + '</font></b>';
		if (studens[my_sips.indexOf(sip.type)]== 1) {
			gotov.htmlText = '<b><font color="#556B2F" size="14" face="Calibri">' + "К бою готов!" + '</font></b>';
			if (but.alpha != 1) {
				but.addEventListener(MouseEvent.CLICK, start_game);
				but.alpha = 1;
			}
		}else if (studens[my_sips.indexOf(sip.type)] == 0) {
			gotov.htmlText = '<b><font color="#8B1A1A" size="14" face="Calibri">' + "Тpебуется экипаж" + '</font></b>';
			if (but.alpha != 0.5) {
				but.removeEventListener(MouseEvent.CLICK, start_game);
				but.alpha = 0.5;
			}
		}
	}
	private function add_item(object:Object3D):void {
		rootContainer.addChild(object);
		for each (var resource:Resource in object.getResources(true)) {
            resource.upload(stage3D.context3D);
		}
	}
	private function _delete(object:Object3D):void {
		if (rootContainer.contains(object)) {
		rootContainer.removeChild(object);
		for each (var resource:Resource in object.getResources(true)) {
					resource.dispose();
		}
		}
	}
	private var isDragging:Boolean = false;
		private var lastMouseX:Number = 0;
		private var lastMouseY:Number = 0;
		
		private function mouse_move(e:MouseEvent):void 
		{
			if (!isDragging && !load_states.isDragging_1)
				return;
				
			var deltaX:Number = e.stageX - lastMouseX;
			var deltaY:Number = e.stageY - lastMouseY;
			
			lastMouseX = e.stageX;
			lastMouseY = e.stageY;
			
			if (load_states.isDragging_1) {
				if (load_states.button.y >= 31 && load_states.button.y<=200-5/2 -1) {
					load_states.button.y += deltaY;
					load_states.Score_table.y -= deltaY * ((load_states.Score_table.height-173) / (173 - 30));
				}
			}else {
				if (load_states.drag == true) {
				load_states.table.x += deltaX;
				load_states.table.y += deltaY;
			}else {
				localCamera(deltaX, deltaY);
			}
			}
			/*camera.z+=0.5;
			camera.x++;*/
		}
		
		private function localCamera(deltaX:Number, deltaY:Number):void 
		{
			rot += deltaX / 2 * Math.PI / 180;
			if(!contains(load_study))main_sip.Container.rotationZ = rot;
			//camera.rotationX -= deltaY / 2 * Math.PI / 180;
		}
		
		private function mouse_up(e:MouseEvent):void 
		{
			isDragging = false;
			load_states.isDragging_1 = false;
		}
		
		private function mouse_down(e:MouseEvent):void 
		{
			isDragging = true;
			lastMouseX = e.stageX;
			lastMouseY = e.stageY;
		}
    private function init(event:Event):void {
        for each (var resource:Resource in rootContainer.getResources(true)) {
            resource.upload(stage3D.context3D);
        }
        addEventListener(Event.ENTER_FRAME, enterFrameHandler)
    }
 
    private function enterFrameHandler(event:Event):void {
		if (current_name.text == "") {
			var flashVars:Object = stage.loaderInfo.parameters as Object;
			var VK:APIConnection = new APIConnection(flashVars);
			// Example of API request
			VK.api('getProfiles', { uids: flashVars['viewer_id'] }, onProfileLoaded, function():void { } );
		}
		if(main_sip != null){
		if (main_sip.max> speed) {
			speed += 0.1;
			speed_sprite.graphics.clear();
			speed_sprite.graphics.beginFill(0x000FF0);
			speed_sprite.graphics.drawRect(0, 0, speed*10, 10);
			speed_sprite.y = 5 + States_Y;
			speed_sprite.x = 70 + States_X;
		}
		 if (main_sip.max < speed) {
			speed -= 0.1;
			speed_sprite.graphics.clear();
			speed_sprite.graphics.beginFill(0x000FF0);
			speed_sprite.graphics.drawRect(0, 0, speed * 10, 10);
			speed_sprite.y = 5 + States_Y;
			speed_sprite.x = 70 + States_X;
		}
		
		if (main_sip.deffence> deffence) {
			deffence += 0.01;
			deffence_sprite.graphics.clear();
			deffence_sprite.graphics.beginFill(0x000FF0);
			deffence_sprite.graphics.drawRect(0, 0, deffence*100, 10);
			deffence_sprite.y = 20 + States_Y;
			deffence_sprite.x = 70 + States_X;
		}
		if (main_sip.deffence < deffence) {
			deffence -= 0.01;
			deffence_sprite.graphics.clear();
			deffence_sprite.graphics.beginFill(0x000FF0);
			deffence_sprite.graphics.drawRect(0, 0, deffence*100, 10);
			deffence_sprite.y = 20 + States_Y;
			deffence_sprite.x = 70 + States_X;
		}
		
		if (main_sip.damage> damage) {
			damage += 0.01;
			damage_sprite.graphics.clear();
			damage_sprite.graphics.beginFill(0x000FF0);
			damage_sprite.graphics.drawRect(0, 0, damage * 100, 10);
			damage_sprite.y = 35 + States_Y;
			damage_sprite.x = 70 + States_X;
			
		}
		 if (main_sip.damage < damage) {
			damage -= 0.01;
			damage_sprite.graphics.clear();
			damage_sprite.graphics.beginFill(0x000FF0);
			damage_sprite.graphics.drawRect(0, 0, damage * 100, 10);
			damage_sprite.y = 35 + States_Y;
			damage_sprite.x = 70 + States_X;
		}
		}
		
		camera.render(stage3D);
		if (isDragging == false) load_states.drag = false;
    }
	private function down(e:KeyboardEvent):void {
			if (e.keyCode == 81 && main_sip!=null) {
				if (main_sip.mode == true && main_sip.pos > 14) {
					main_sip.mode = false;
				}else main_sip.mode = true;
			}
	}
}
}
