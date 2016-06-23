# Scale all content 
Framer.Device.contentScale = 1


background = new Layer
	height: 2006
	width: 1216
	image: 'images/bg.jpg'
	backgroundColor: 'black'
	y: -672
	x: -237

background.states.add
	two:
		y: -400
		scale: 0.9
	three:
		y: -300
		scale: 0.8
background.states.animationOptions = curve:'bezier(400, 40, 0)'


# create base layer, centered
htmlLayer = new Layer
	x:0
	y:0
	width:750
	height:1336
	opacity: 1.00
	backgroundColor: "rgba(0, 0, 200, 0)"
	#image: 'images/bg.jpg'

htmlLayer.html = '<canvas></canvas>'
htmlLayer.center()

htmlLayer.states.add
	two:
		scale: 0.9
	three:
		scale: 0.8
htmlLayer.states.animationOptions = curve:'bezier(400, 40, 0)'

# set up the scene, camera, and renderer as global variables
scene = new THREE.Scene();
camera = new THREE.PerspectiveCamera(50, htmlLayer.width/htmlLayer.height,0.1, 1000);

# camera.position.x = 5;
# camera.position.y = 2;
camera.position.z = 10;

renderer = new THREE.WebGLRenderer({ canvas: htmlLayer._elementHTML.childNodes[0], antialias: true });
renderer.setSize(htmlLayer.width, htmlLayer.height);

# and then there was light
directionalLight = new THREE.DirectionalLight( 'white', 0.7 );
directionalLight.position.set( 0.8, 0.2, 0.5);
scene.add( directionalLight );


scene.add( new THREE.AmbientLight( '#5ccaff' ) );


geometry = new THREE.CubeGeometry(1,2,1);
material = new THREE.MeshPhongMaterial( { color: 'magenta', specular: 0x009900, shininess: 30, shading: THREE.FlatShading} );

material2 = new THREE.MeshPhongMaterial( { color: '5ccaff', specular: 0x009900, shininess: 30, shading: THREE.FlatShading} );

cube = new THREE.Mesh(geometry, material);
scene.add(cube);

cube2  = new THREE.Mesh(geometry, material2);
#scene.add(cube2);

cube2.rotation.x = 100
cube2.rotation.y = 90
cube2.position.y = 2

scene.rotation.x = 0.3



cube3 = new THREE.Mesh(geometry, material)
cube3.rotation.x = 2
cube3.rotation.y = 25
cube3.position.y = 4




controls = new THREE.OrbitControls(camera, renderer.domElement);


# html layer controls
animate =  () ->
	requestAnimationFrame(animate);

	scene.rotation.y += 0.002
# 	cube.rotation.x += 0.01;
# 	cube.rotation.y += 0.01
# 	
# 	cube2.rotation.x += 0.01;
# 	cube2.rotation.y += 0.01

	renderer.render(scene, camera);
	#controls.update();

animate()
controls.update()

htmlLayer.onSwipeRight ->
	#print event.delta['x']
	#htmlLayer.opacity -= 0.5
	controls.update()
	controls.rotateLeft(0.1)
	
htmlLayer.onSwipeLeft ->
	#print event.delta['x']
	#htmlLayer.opacity -= 0.5
	controls.update()
	controls.rotateRight(0.1)

htmlLayer.onSwipeUp ->
	#print event.delta['x']
	#htmlLayer.opacity -= 0.5
	controls.update()
	controls.rotateDown(0.1)

htmlLayer.onSwipeDown ->
	#print event.delta['x']
	#htmlLayer.opacity -= 0.5
	controls.update()
	controls.rotateUp(0.1)


# Create layer
next = new Layer
	width: 200
	height: 100
	x: Align.center
	y: Align.bottom(-100)
	borderRadius: 20
	backgroundColor: '#3498db'

correct = new Layer
	width: 100
	height: 100
	backgroundColor: '#2ecc71'
	y: Align.bottom(-100)
	x: Align.right(-100)
	borderRadius: 50
	

incorrect = new Layer
	width: 100
	height: 100
	backgroundColor: '#e74c3c'
	y: Align.bottom(-100)
	x: Align.left(100)
	borderRadius: 50

next.onClick ->
	scene.add(cube2)
	scene.position.y = -1
	background.states.switch('two')
	htmlLayer.states.switch('two')
	
correct.onClick ->
	scene.add(cube3)
	scene.position.y = -2
	background.states.switch('three')
	htmlLayer.states.switch('three')
	
incorrect.onClick ->
	scene.remove(cube3)
	scene.position.y = -1
	background.states.switch('two')
	htmlLayer.states.switch('two')


	
