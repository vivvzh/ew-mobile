// Welcome to Framer

// This is just demo code. Feel free to delete it all.
htmlLayer = new Layer({x:0, y:0, width:200, height:200})
htmlLayer.html = '<canvas></canvas>'
htmlLayer.center()

// Define a set of states with names (the original state is 'default')
htmlLayer.states.add({
	second: {y:100, scale:0.6, rotationZ:100},
	third:  {y:300, scale:1.3},
	fourth:	{y:200, scale:0.9, rotationZ:200},
})

// Set the default animation options
htmlLayer.states.animationOptions = {
	curve: "spring(500,12,0)"
}

// On a click, go to the next state
htmlLayer.on(Events.Click, function() {
	htmlLayer.states.next()
})


var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera(75, 1, 0.1, 1000);

var renderer = new THREE.WebGLRenderer({ canvas: htmlLayer._elementHTML.childNodes[0], antialias: true });
renderer.setSize(htmlLayer.width, htmlLayer.height);


var geometry = new THREE.CubeGeometry(1,1,1);
var material = new THREE.MeshBasicMaterial({color: 0x00ff00});
var cube = new THREE.Mesh(geometry, material);
scene.add(cube);

camera.position.z = 5;

var render = function () {
	requestAnimationFrame(render);

	cube.rotation.x += 0.1;
	cube.rotation.y += 0.1;

	renderer.render(scene, camera);
};

render();
