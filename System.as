package {
  import alternativa.engine3d.collisions.EllipsoidCollider;
	import alternativa.engine3d.controllers.SimpleObjectController;
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.events.MouseEvent3D;
	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.core.View;
	import alternativa.engine3d.lights.DirectionalLight;
	import alternativa.engine3d.lights.OmniLight;
	import alternativa.engine3d.lights.SpotLight;
	import alternativa.engine3d.loaders.Parser3DS;
	import alternativa.engine3d.loaders.TexturesLoader;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.materials.Material;
	import alternativa.engine3d.materials.VertexLightTextureMaterial;
	import alternativa.engine3d.objects.AnimSprite;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.objects.SkyBox;
	import alternativa.engine3d.primitives.GeoSphere;
	import alternativa.engine3d.resources.BitmapCubeTextureResource;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import alternativa.engine3d.resources.ExternalTextureResource;
	import alternativa.engine3d.shadows.OmniLightShadow;
	import alternativa.physics3dintegration.VertexLightMaterial;
	import alternativa.physicsengine.math.Vector3;
	import flash.display.*;
	import flash.events.*;
	import alternativa.engine3d.primitives.Box;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.core.RayIntersectionData;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.geom.Point;
	import alternativa.engine3d.core.Object3D;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.text.*;
	import flash.utils.Timer;
	import alternativa.engine3d.primitives.Plane;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import alternativa.engine3d.objects.Sprite3D;
	import flash.geom.Matrix;
	import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	import vk.APIConnection;
	
	[Frame(factoryClass="Preloader")]
	public class System extends Screen{
		private var slow:Number = 0.1;
		private var stage3D:Stage3D;
		private var camera:Camera3D;
		private var rootContainer:Object3D=new Object3D;
		private var CameraContainer:Object3D = new Object3D; 
		private var Textures:Object3D=new Object3D;
		private var controller:SimpleObjectController;
		private var box:Box;
		private var sun:GeoSphere = new GeoSphere(695.500*1.2, 8);
		private var saturn:Saturn = new Saturn;
		private var upiter:Upiter = new Upiter;
		private var mars:Mars = new Mars;
		private var earth:Earth = new Earth;
		private var venera:Venera = new Venera;
		private var mercury:Mercury = new Mercury;
		private var G:Number = 0.00007;
		private var omniLight:OmniLight;
		private var skyBox:SkyBox;
		private var A_E:Number = 1500 + 695.500;
		private var D:Number = 0;
		private var sky:GeoSphere = new GeoSphere(2500, 50, true);
		private var speed:Number = 2, go1:Boolean = false, go2:Boolean = false, go3:Boolean = false, go4:Boolean = false, Z:Number = 0, speedZ:Number = 0, Z_a:Number = 0.001, X:Number = 0, speedX:Number = 0, X_a:Number = 0.001, fire:Boolean = false, Y_1:Number=0, Y_a:Number = 0.02, speedY:Number = 0;
		private var collider:EllipsoidCollider = new EllipsoidCollider(5, 5, 10);
		private var ball:Ball;
		private var Balls:Array = [];
		private var Bots:Array = [];
		private var n:Number = 0;
		private var textureMaterial:TextureMaterial;
		private var materials:Vector.<Material> = new Vector.<Material>();
		private var load_m:Vector.<BitmapData> = new Vector.<BitmapData>();
		private var Expl:Array = [];
		private var life:Sprite = new Sprite;
		private var l_1:Shape = new Shape;
		private var l_2:Shape = new Shape;
		private var p:TextField;
		private var p_1:Sprite;
		private var but:Sprite = new Sprite;
		private var creat_timer:Timer = new Timer(2000);
		private var total_bots:Number = 10;
		private var VZ:AnimSprite;
		public var sip:Sip = new Sip;
		private var total_damage:Number = 0;
		private var aster:Asteroid;
		private var Ast:Array = [];
		private var time_w:Number = 0;
		private var d_star:D_star = new D_star;
		
		
		//private var blaster:Sound = new Sound(new URLRequest("star_wars/fire.mp3"));
		//private var back_music:Sound = new Sound(new URLRequest("star_wars/back_music.mp3"));
		//private var back_music_1:Sound = new Sound(new URLRequest("star_wars/back_music_1.mp3"));
		
		private var ToScore:URLRequest;
		private var my_score:URLRequest = new URLRequest('http://alckevich.hut2.ru/my_score.php');
		
		private var ToScore_loader:URLLoader;
		private var my_score_loader:URLLoader = new URLLoader();
		
		private var vars:URLVariables = new URLVariables();
		
		
		private var My_name:String = new String("User");
		private var total_score:Number = new Number(0);
		
		private var aut:TextField = new TextField;
		private var aut_m:MovieClip = new MovieClip;
		
		private var score_t:TextField = new TextField;
		
		private var table:Sprite = new Sprite();
		
		
		[SWF (backgroundColor="0x000000", frameRate="60")]
		
		[Embed(source = "sun.gif")] static private const sun_texture:Class;
		private var sun_t:BitmapTextureResource = new BitmapTextureResource(new sun_texture().bitmapData);
		
		
		
		[Embed(source = "explosion.png")] static private const VZ_texture:Class;
		private var phases:BitmapData = new VZ_texture().bitmapData;
		
		[Embed(source = "left.jpg")] static private const left_t_c:Class;
		private var left_t:BitmapTextureResource = new BitmapTextureResource(new left_t_c().bitmapData);
		[Embed(source = "right.jpg")] static private const right_t_c:Class;
		private var right_t:BitmapTextureResource = new BitmapTextureResource(new right_t_c().bitmapData);
		[Embed(source = "top.jpg")] static private const top_t_c:Class;
		private var top_t:BitmapTextureResource = new BitmapTextureResource(new top_t_c().bitmapData);
		[Embed(source = "bot.jpg")] static private const bottom_t_c:Class;
		private var bottom_t:BitmapTextureResource = new BitmapTextureResource(new bottom_t_c().bitmapData);
		[Embed(source = "front.jpg")] static private const front_t_c:Class;
		private var front_t:BitmapTextureResource = new BitmapTextureResource(new front_t_c().bitmapData);
	[	Embed(source = "back.jpg")] static private const back_t_c:Class;
		private var back_t:BitmapTextureResource = new BitmapTextureResource(new back_t_c().bitmapData);
		[Embed(source = "star_wars/fire.mp3")] static private const fire_muse:Class;
		private var blaster:Sound = new fire_muse() as Sound;
		
		
		public function System(name:String) {
			current_name.text = name;
			if (stage) start_init();
			else addEventListener(Event.ADDED_TO_STAGE, start_init);
		}
		private function start_init(e:Event = null):void{
			total_score = 0;
			my_score.method = URLRequestMethod.POST;
			first_level();
		}
		private function to_site(e:MouseEvent):void 
		{
			var URL:URLRequest=new URLRequest("http://flashaction.ucoz.ru/");
			navigateToURL(URL);
		}
		
		private function creat_bots(e:TimerEvent):void 
		{
			if (Bots.length < total_bots){
				var vrag:Sip_1 = new Sip_1;
				vrag.Container.x = d_star.Container.x-d_star.R - 50;
				vrag.Container.y = d_star.Container.y-d_star.R - 50;
				vrag.addEventListener(Event.ENTER_FRAME, move_vrag);
				rootContainer.addChild(vrag.Container);
				Bots.push(vrag);
				for each (var resource:Resource in vrag.Container.getResources(true)){
					resource.upload(stage3D.context3D);
				}
			}
		}
		private function first_level():void {
			//creat_timer.start();
			creat_timer.addEventListener(TimerEvent.TIMER, creat_bots);
			
			var p_1:Sprite = new Sprite;
			p_1.graphics.beginFill(0x000000);
			p_1.graphics.drawRect(-2.5, -2.5, 105, 15);
			p_1.x = 807 / 2 -50;
			p_1.y = 30;
			addChild(p_1);
			p_1 = new Sprite;
			p_1.graphics.beginFill(0x888888);
			p_1.graphics.drawRect(0, 0, 100, 10);
			//p_1.x = 700;
			p_1.x = 807 / 2 -50;
			p_1.y = 30;
			addChild(p_1);
			
			life.scaleX = 1;
			life.graphics.beginFill(0xFF0000);
			life.graphics.drawRect(0, 0, 100, 10);
			//life.x = 700;
			life.x = 807 / 2 -50;
			life.y = 30;
			addChild(life);
			for (var j:int = 0; j < phases.width; j += 32){ //в цикле режем картинку
				var bmp:BitmapData = new BitmapData(32, 32, true, 0); //на картинки размером 128x128
				bmp.copyPixels(phases, new Rectangle(j, 0, 128, 128), new Point());
				textureMaterial = new TextureMaterial(new BitmapTextureResource(bmp));
				materials.push(textureMaterial); //добавляем в вектор текстуру
			}	
				skyBox = new SkyBox(30000, 
				new TextureMaterial(left_t), 
				new TextureMaterial(right_t), 
				new TextureMaterial(back_t), 
				new TextureMaterial(front_t), 
				new TextureMaterial(bottom_t), 
				new TextureMaterial(top_t), 0.0001);
		add_item(skyBox, 2);
			
		omniLight = new OmniLight(0xFFFCCC, 695.500/10 ,100000);
		omniLight.intensity = 1;
		omniLight.z = 50;
		add_item(omniLight, 2);
			
		camera = new Camera3D(1, 100000);
		camera.x = 20;
        camera.y = 0;
        camera.z = 10;
		camera.rotationX = -1.8;
		camera.rotationZ = 1.57;
        //camera.view = new View(stage.fullScreenWidth, stage.fullScreenHeight, false, 0x000000, 1, 0);
		//camera.view.x = -stage.fullScreenWidth / 2 + 400;
		//camera.view.y = 400 * 2 - stage.fullScreenHeight / 2 - 550;
		camera.view = new View(807, 730, false, 0x000000, 1, 0);
		camera.view.x = -807 / 2 + 400;
		camera.view.y = 400 * 2 - 730 / 2 - 550;
		addChild(camera.diagram);
		camera.view.hideLogo();
		addChild(camera.view);
		sip.Container.rotationZ = 0;
		CameraContainer.addChild(sip.Container);
		CameraContainer.addChild(camera);
		
		CameraContainer.x = CameraContainer.y = 900;
		add_item(CameraContainer, 2);
		
		d_star.Container.x = -(A_E*2 + 695.500);
		d_star.Container.y = (A_E*2 + 695.500);
		d_star.slow = slow;
		Textures.addChild(d_star.Container);
		//mercury.addEventListener(Event.ENTER_FRAME, move);
		
		for (var i:int = 0; i < 5;i++){
		var vrag:Sip_1 = new Sip_1;
		vrag.Container.x = -(A_E*2 + 695.500)+ (d_star.R + 20*(i+1))*Math.cos(Math.random()*2-1);
		vrag.Container.y = (A_E*2 + 695.500)-(d_star.R - 20*(i+1))*Math.sin(Math.random()*2-1);
		vrag.addEventListener(Event.ENTER_FRAME, move_vrag);
		add_item(vrag.Container, 2);
		Bots.push(vrag);
		}
		
		sun.setMaterialToAllSurfaces(new TextureMaterial(sun_t));
		sun.x = 0;
		sun.y = 0;
		Textures.addChild(sun);
		sun.addEventListener(Event.ENTER_FRAME, move);
		
		saturn.Container.x = 0;
		saturn.Container.y = A_E*9.54 + 695.500;
		saturn.slow = slow;
		Textures.addChild(saturn.Container);
		saturn.addEventListener(Event.ENTER_FRAME, move);
		
		upiter.Container.x = 0;
		upiter.Container.y = A_E*5.20 + 695.500;
		upiter.slow = slow;
		Textures.addChild(upiter.Container);
		upiter.addEventListener(Event.ENTER_FRAME, move);
		
		mars.Container.x = 0;
		mars.Container.y = A_E*1.52 + 695.500;
		mars.slow = slow;
		Textures.addChild(mars.Container);
		mars.addEventListener(Event.ENTER_FRAME, move);
		
		earth.Container.x = 0;
		earth.Container.y = A_E + 695.500;
		earth.slow = slow;
		Textures.addChild(earth.Container);
		earth.addEventListener(Event.ENTER_FRAME, move);
		
		venera.Container.x = 0;
		venera.Container.y = A_E*0.72 + 695.500;
		venera.slow = slow;
		Textures.addChild(venera.Container);
		venera.addEventListener(Event.ENTER_FRAME, move);
		
		mercury.Container.x = 0;
		mercury.Container.y = A_E*0.39 + 695.500;
		mercury.slow = slow;
		Textures.addChild(mercury.Container);
		mercury.addEventListener(Event.ENTER_FRAME, move);
		
		for (i = 0; i < 250; i++) {
			aster = new Asteroid(Math.random() * 4 + 1, Math.random() * 1000);
			aster.Container.x = Math.random() * 10000-5000;
			aster.Container.y = Math.random() * 10000 - 5000;
			aster.Container.z = Math.random() * 400 - 200;
			aster.R = Math.sqrt((aster.Container.x * aster.Container.x) + (aster.Container.y * aster.Container.y));
			aster.f = Math.atan2( aster.Container.y, aster.Container.x);
			aster.w = - Math.sqrt(198892000*0.00007/(aster.R*aster.R*aster.R + 695.500))*100;
			Textures.addChild(aster.Container);
			aster.addEventListener(Event.ENTER_FRAME, move_Aster);
			Ast.push(aster);
		}
		
		add_item(Textures, 2);
		
		stage3D = stage.stage3Ds[0];
        stage3D.addEventListener(Event.CONTEXT3D_CREATE, init);
        stage3D.requestContext3D();
		/*stage.addEventListener(MouseEvent.MOUSE_MOVE, mouse_move);
		stage.addEventListener(MouseEvent.MOUSE_DOWN, mouse_down);
		stage.addEventListener(MouseEvent.MOUSE_UP, mouse_up);*/
		stage.addEventListener(MouseEvent.MOUSE_WHEEL, distance);
		
		aut.textColor = 0xFFFF00;
			aut.text = "Alckevich Entertainment";
			aut.autoSize = TextFieldAutoSize.CENTER;
			aut.height = 20;
			
		aut_m.addChild(aut);
			table.graphics.beginFill(0x000000, 0);
			table.graphics.drawRect(0, 0, 130, 20);
			table.buttonMode = true;
			table.addEventListener(MouseEvent.CLICK, to_site);
			table.x = table.x - 15;
			aut_m.addChild(table);
			aut_m.x = -stage.fullScreenWidth / 2 + 400 + stage.fullScreenWidth / 2-45;
			aut_m.y = 400 * 2 - stage.fullScreenHeight / 2 - 550 + stage.fullScreenHeight / 2 + 300;
			addChild(aut_m);
		addChild(aut_m);
		
		score_t.textColor = 0xFFFFFF;
		score_t.text = "SCORE = "+String(total_score);
		score_t.autoSize = TextFieldAutoSize.CENTER;
		score_t.height = 20;
		score_t.x = -stage.fullScreenWidth / 2 + 400 + stage.fullScreenWidth / 2-30;
		score_t.y = aut_m.y - 50;
		addChild(score_t);
		}
		private function move_Aster(e:Event):void {
			time_w+=0.01;
			e.target.Container.x = e.target.R * Math.cos(2/180*e.target.w*time_w+e.target.f);
			e.target.Container.y = e.target.R * Math.sin(2/180*e.target.w*time_w+e.target.f);
		}
		private function scene_load(e:ProgressEvent):void {
			//load_line.scaleX=load_line.scaleX/Math.round((e.bytesLoaded/e.bytesTotal));
		}
		private function distance(e:MouseEvent):void 
		{
			camera.x -= e.delta;
			camera.z -= e.delta/2;
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
			
			localCamera(deltaX, deltaY);
			
			/*camera.z+=0.5;
			camera.x++;*/
		}
		
		private function localCamera(deltaX:Number, deltaY:Number):void 
		{
			CameraContainer.rotationZ -= deltaX / 2 * Math.PI / 180;
			//CameraContainer.rotationX -= deltaY / 2 * Math.PI / 180;
		}
		
		private function mouse_up(e:MouseEvent):void 
		{
			isDragging = false;
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
        addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, down);
	    stage.addEventListener(KeyboardEvent.KEY_UP, up); 
    }
	private function down(e:KeyboardEvent):void {
			if (e.keyCode == 81) {
				if (sip.mode == true && sip.pos > 14) {
					sip.mode = false;
				}else sip.mode = true;
			}
			if (e.keyCode == 65) go1 = true, go2=false;
			if (e.keyCode == 68) go2 = true, go1=false;
			if (e.keyCode == 87) go3 = true;
			if (e.keyCode == 83) go4 = true;
			if (e.keyCode == 32) {
				fire = true;
				if(sip.can_fire){
				sip.can_fire = false;
				
				ball.dy = mouseX-sip.Container.y;
				ball.dx = mouseY-sip.Container.x;
				ball.Rot=Math.atan2(ball.dy,ball.dx);
				
				ball = new Ball;
				ball.speed = 6 + Math.sqrt(sip.speedX * sip.speedX + sip.speedY * sip.speedY);;
				ball.Container.rotationZ = CameraContainer.rotationZ + 3.14;
				ball.Container.z = CameraContainer.z + sip.Container.z;
				ball.Container.x = CameraContainer.x + sip.Container.x * Math.cos(CameraContainer.rotationZ)+sip.Container.y * Math.cos(CameraContainer.rotationZ+3.14/2);
				ball.Container.y = CameraContainer.y + sip.Container.x * Math.sin(CameraContainer.rotationZ)+sip.Container.y * Math.sin(CameraContainer.rotationZ+3.14/2);
				ball.addEventListener(Event.ENTER_FRAME, move_my_ball);
				add_item(ball.Container, 1);
				Balls.push(ball);
				stage3D = stage.stage3Ds[0];
				for each (var resource:Resource in ball.Container.getResources(true)) {
				resource.upload(stage3D.context3D);
				blaster.play();
				}
			}
			}
		}
	private	function up(e:KeyboardEvent):void{
			if (e.keyCode == 65) go1 = false;
			if (e.keyCode == 68) go2 = false;
			if (e.keyCode == 87) go3 = false;
			if (e.keyCode == 83) go4 = false;
			if (e.keyCode == 32) fire = false;
		}
	private function move(e:Event):void {
		if (e.target != sun){
		e.target.a = G * 19889200 / ((sun.x - e.target.Container.x) * (sun.x - e.target.Container.x) + (sun.y - e.target.Container.y) * (sun.y - e.target.Container.y));
		
		e.target.dy = sun.y-e.target.Container.y;
		e.target.dx = sun.x-e.target.Container.x;
		e.target.Rot=Math.atan2(e.target.dy,e.target.dx);
		
		e.target.speedX += Math.cos(e.target.Rot) * e.target.a/slow;
		e.target.speedY += Math.sin(e.target.Rot) * e.target.a/slow;
		
		e.target.Container.x += e.target.speedX/slow;
		e.target.Container.y += e.target.speedY / slow;
		}
		
		/*sip.speedX += Math.cos(Math.atan2(e.target.y - CameraContainer.y, e.target.x - CameraContainer.x)) * G * 198892 / ((e.target.x - CameraContainer.x) * (e.target.x - CameraContainer.x) + (e.target.y - CameraContainer.y) * (e.target.y - CameraContainer.y));
		sip.speedY += Math.sin(Math.atan2(e.target.y - CameraContainer.y, e.target.x - CameraContainer.x)) * G * 198892 / ((e.target.x - CameraContainer.x) * (e.target.x - CameraContainer.x) + (e.target.y - CameraContainer.y) * (e.target.y - CameraContainer.y));
		
		var wish:Vector3D = new Vector3D();
		wish.x +=  Math.cos(Math.atan2(e.target.y - CameraContainer.y, e.target.x - CameraContainer.x))*sip.speedX, wish.y += Math.sin(Math.atan2(e.target.y - CameraContainer.y, e.target.x - CameraContainer.x)) * sip.speedY;
		var dest:Vector3D = collider.calculateDestination(new Vector3D(CameraContainer.x, CameraContainer.y, CameraContainer.z), wish, Textures);
		CameraContainer.x = dest.x;
        CameraContainer.y = dest.y;*/
		/*if (e.target == saturn) {
			D=Math.sqrt((sun.x - e.target.Container.x) * (sun.x - e.target.Container.x) + (sun.y - e.target.Container.y) * (sun.y - e.target.Container.y));
			trace(D);
			}*/
		}
		private function move_vrag(e:Event):void {

			e.target.dy = CameraContainer.y-e.target.Container.y;
			e.target.dx = CameraContainer.x-e.target.Container.x;
			e.target.Rot = Math.atan2(e.target.dy, e.target.dx);
			
			e.target.Container.rotationZ = e.target.Rot;
		
			e.target.speedX += Math.cos(e.target.Rot) * e.target.a/2;
			e.target.speedY += Math.sin(e.target.Rot) * e.target.a/2;
			
			if (e.target.speedX > 1) e.target.speedX = 1;
			if (e.target.speedX < -1) e.target.speedX = -1;
			if (e.target.speedY > 1) e.target.speedY = 1;
			if (e.target.speedY < -1) e.target.speedY = -1;
			
			var wish:Vector3D=new Vector3D();
			wish.x += e.target.speedX;
			wish.y += e.target.speedY;
			var dest:Vector3D = collider.calculateDestination(new Vector3D(e.target.Container.x,e.target.Container.y,e.target.Container.z),wish,Textures)
			e.target.Container.x = dest.x;
        	e.target.Container.y = dest.y;
			
			if(e.target.can_fire){
				e.target.can_fire = false;
				ball = new Ball;
				ball.speed = 6;
				ball.Container.rotationZ = e.target.Rot;
				ball.Container.z = e.target.Container.z;
				ball.Container.x = e.target.Container.x;
				ball.Container.y = e.target.Container.y;
				ball.addEventListener(Event.ENTER_FRAME, move_vrags_ball);
				Balls.push(ball);
				add_item(ball.Container, 1);
				//blaster.play();
			}
		}
		public function explosion(x:Number, y:Number, scale:Number):void{
			    var VZ:AnimSprite = new AnimSprite(10, 10, materials, false);
				VZ.x = x;
				VZ.y = y;
				VZ.scaleX = VZ.scaleY = 1 / scale;
				Expl.push(VZ);
				add_item(VZ, 1);
				
				for each (var resource:Resource in VZ.getResources(true)) {
				resource.upload(stage3D.context3D);
				}
		}
		public function add_item(object:Object3D, type:int):void {
			switch(type) {
			case 2:
				rootContainer.addChild(object);
				break;
			case 1:
				rootContainer.addChild(object);
				for each (var resource:Resource in object.getResources(true)) {
					resource.upload(stage3D.context3D);
				}
				break;
			case 0:
			if (rootContainer.contains(object)) {
				rootContainer.removeChild(object);
				for each (resource in object.getResources(true)) {
					resource.dispose();
				}
			}
			break;
			case -1:
				rootContainer.removeChildren(0);
			break;
			default:break;
			}
		}
		private function move_vrags_ball(e:Event):void {
			var collisionPlane:Vector3D = new Vector3D();
			if(e.target.collider.getCollision(new Vector3D(e.target.Container.x, e.target.Container.y, e.target.Container.z), new Vector3D(Math.cos(e.target.Container.rotationZ)*e.target.speed, Math.sin(e.target.Container.rotationZ)*e.target.speed, 0),new Vector3D(), collisionPlane, CameraContainer)){
					add_item(e.target.Container, 0);
					Balls.splice(Balls[Balls.indexOf(e.target)], 1);
					e.target.removeEventListener(Event.ENTER_FRAME, move_vrags_ball);
				
				if(life.scaleX>0){
				life.scaleX -= (1-1*sip.deffence) / 100;
				}else {
					for each (var resource:Resource in rootContainer.getResources(true)) {
						resource.dispose();
				}
				for (var i:int; i < Bots.length; i++) {
					add_item(Bots[i].Container, 0);
					Bots[i].removeEventListener(Event.ENTER_FRAME, move_vrag);
					}
				Bots.length = 0;
				
				for (i=0; i < Balls.length; i++) {
					Balls[i].removeEventListener(Event.ENTER_FRAME, move_vrags_ball);
					}
				Balls.length = 0;
				
			//explosion(CameraContainer.x, CameraContainer.y);
			vars['name']=current_name.text//current_name.text;
			vars['score'] = total_score;
			vars['Experiences'] = Math.floor(total_damage * 1 + total_score * 2.5);
			vars['Silver'] = Math.floor(total_damage * 5)+10;
			my_score.data=vars;
			my_score_loader.load(my_score);
			total_bots = 10;
			
			stage3D.removeEventListener(Event.CONTEXT3D_CREATE, init);
			add_item(rootContainer, -1);
			dispatchEvent(new StatusEvent(StatusEvent.STATUS, false, false, "", "gotoAngar"));
				}
			}
			}
		private function move_my_ball(e:Event):void {
			var collisionPlane:Vector3D = new Vector3D();
			for (var i:Number = 0; i < Bots.length; i++) {
			if(e.target.collider.getCollision(new Vector3D(e.target.Container.x, e.target.Container.y, e.target.Container.z), new Vector3D(Math.cos(e.target.Container.rotationZ)*e.target.speed, Math.sin(e.target.Container.rotationZ)*e.target.speed, 0),new Vector3D(), collisionPlane, Bots[i].Container)){
				e.target.x = -10000;
				e.target.y = -10000;
				e.target.removeEventListener(Event.ENTER_FRAME, move_my_ball);
				Bots[i].points -= sip.damage;
				total_damage += sip.damage;
				if(Bots[i].points<=0){
					explosion(e.target.Container.x, e.target.Container.y, 1);
					Bots[i].Container.x = d_star.Container.x + (d_star.R +20) * Math.cos(Math.atan2(d_star.Container.x - CameraContainer.x, d_star.Container.y - CameraContainer.y)+1.57);
					Bots[i].Container.y = d_star.Container.y -(d_star.R +20)* Math.sin(Math.atan2(d_star.Container.x - CameraContainer.x, d_star.Container.y - CameraContainer.y)+1.57);
					//Bots[i].Container.x = CameraContainer.x + 400*Math.cos(CameraContainer.rotationZ);
					//Bots[i].Container.y = CameraContainer.y + 400 * Math.sin(CameraContainer.rotationZ);
					Bots[i].points = 1;
					total_score++;
					score_t.text = "SCORE = "+String(total_score);
			}else	explosion(e.target.Container.x, e.target.Container.y, 10);
				
				
				add_item(e.target.Container, 0);
				Balls.splice(Balls[Balls.indexOf(e.target)], 1);
				for each (var resource:Resource in e.target.Container.getResources(true)){
					resource.dispose();
				}
				/*rootContainer.removeChild(Bots[i].Container);
				for each (resource in Bots[i].Container.getResources(true)){
					resource.dispose();
				}
				Bots[i].removeEventListener(Event.ENTER_FRAME, move_vrag);
				Bots.splice(i, 1);*/
				
			}
			}
		}
		private function enterFrameHandler(event:Event):void {
			
			for each (var explosion:AnimSprite in Expl) {
			explosion.frame++;
			if (explosion.frame == 29) {
				add_item(explosion, 0);
				for each (var resource:Resource in explosion.getResources(true)){
					resource.dispose();
				}
				Expl.splice(Expl[Expl.indexOf(explosion)], 1);
			}
		}
			//controller.update();
        camera.render(stage3D);
		
		/*if (Balls.length > 10) {
			Balls[0].removeEventListener(Event.ENTER_FRAME, move_my_ball);
			Balls.splice(0, 1);
		}*/
		
		var wish:Vector3D=new Vector3D();
			if (go1) CameraContainer.rotationZ += speed / 30;
			if (go2) CameraContainer.rotationZ -= speed / 30;
			if (go3) sip.speedX += sip.a, sip.speedY += sip.a;
			if (!go3) {
				if (sip.speedX > 0) sip.speedX -= (sip.a/2);
				if (sip.speedY > 0) sip.speedY -= (sip.a/2);
				if (sip.speedX < 0) sip.speedX += sip.a/2;
				if (sip.speedY < 0) sip.speedY += sip.a/2;
				if (sip.speedX > -sip.a/2 && sip.speedX < sip.a/2) sip.speedX = 0;
				if (sip.speedY > -sip.a/2 && sip.speedY < sip.a/2) sip.speedY = 0;
			}
			
			//sip.gravy_X -= G * 198892000 / ((sun.x - CameraContainer.x) * (sun.x - CameraContainer.x) + (sun.y - CameraContainer.y) * (sun.y - CameraContainer.y));
			//sip.gravy_Y -= G * 198892000 / ((sun.x - CameraContainer.x) * (sun.x - CameraContainer.x) + (sun.y - CameraContainer.y) * (sun.y - CameraContainer.y));
			
			//sip.gravy_X += Math.cos(CameraContainer.rotationZ) * sip.speedX;
			//sip.gravy_Y += Math.sin(CameraContainer.rotationZ) * sip.speedY;
			
			if (sip.speedX > sip.max) sip.speedX = sip.max;
			if (sip.speedY > sip.max) sip.speedY = sip.max;
			wish.x -= Math.cos(CameraContainer.rotationZ)*sip.speedX, wish.y -= Math.sin(CameraContainer.rotationZ)*sip.speedY;
			var dest:Vector3D = collider.calculateDestination(new Vector3D(CameraContainer.x, CameraContainer.y, CameraContainer.z), wish, Textures);
			CameraContainer.x = dest.x;
        	CameraContainer.y = dest.y;
			
			if (sip.speedX!=0 || sip.speedY!=0) {
				if (Y_1 > 0) Y_a = -0.02;
				if (Y_1 < 0) Y_a = 0.02;
				speedY += Y_a;
				sip.Container.rotationX += speedY * Math.sqrt(sip.speedX * sip.speedX + sip.speedY * sip.speedY)/10;
				Y_1 += speedY * Math.sqrt(sip.speedX * sip.speedX + sip.speedY * sip.speedY)/10;
			}else Y_1=0, speedY=0;
			
			if (go3 && X>-5) {
				sip.Container.x -= 0.05;
				X -= 0.05;
			}else if (!go3 && X<0) sip.Container.x += 0.15, X += 0.15;
			
			if (go1 && sip.Container.rotationX < Math.PI / 180 * 30 + Y_1) {
				sip.Container.rotationX += 0.02;
				sip.Container.y += 0.2;
			}else if (sip.Container.rotationX > Y_1 && !go1) sip.Container.rotationX -= 0.02, sip.Container.y -= 0.2;
			
			if (go2 && sip.Container.rotationX > -1*Math.PI / 180 * 30 +Y_1) {
				sip.Container.rotationX -= 0.02;
				sip.Container.y -= 0.2;
			}else if (sip.Container.rotationX < Y_1 && !go2) sip.Container.rotationX += 0.02, sip.Container.y += 0.2;
			
			if(!go3 && !go4){
			if (Z > 0.2) Z_a = -0.001;
			if (Z < 0.2) Z_a = 0.001;
			speedZ += Z_a;
			sip.Container.z += speedZ;
			Z += speedZ;
			sip.Container.rotationY += speedZ*2/10;
			}
			
		sun.rotationZ += earth.speedO/(29*60)/slow;
		}
	}

}
	
