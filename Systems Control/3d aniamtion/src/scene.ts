import * as THREE from "three";
import { OrbitControls } from "three/addons/controls/OrbitControls.js";
import { cm, matrices, params, stepState } from "./logic";

/* Pendulum rod */
const rod = new THREE.Mesh(new THREE.BoxGeometry(0, 0, 0), new THREE.MeshStandardMaterial({ color: 0x00aaff }));

const ball = new THREE.Mesh(
	new THREE.SphereGeometry(0.15, 24, 24),
	new THREE.MeshStandardMaterial({ color: 0xffcc00 }),
);
const camera = new THREE.PerspectiveCamera(60, innerWidth / innerHeight, 0.1, 100);
const renderer = new THREE.WebGLRenderer({ antialias: true });
const magnet = new THREE.Group();

export function setRodL(l) {
	params.rodL = l * cm;

	l = params.rodL * 10;

	magnet.position.set(0, l + 0.5, 0);

	rod.position.y = l / 2;
	((rod.geometry = new THREE.CylinderGeometry(0.05, 0.05, l, 10, 10)),
		new THREE.MeshStandardMaterial({ color: 0x00aaff }));
	rod.geometry.translate(0, -l, 0);
}

export function updateScene() {
	const theta = (params.controller == "lqr" ? matrices.xLqr : matrices.xPID).get([0, 0]);

	ball.position.set(Math.sin(theta) * params.rodL * 10, Math.cos(theta) * params.rodL * 10, 0);
	ball.rotation.z = -theta;
}

window.addEventListener("resize", () => {
	camera.aspect = innerWidth / innerHeight;
	camera.updateProjectionMatrix();
	renderer.setSize(innerWidth, innerHeight);
});

export default function setUpScene() {
	const scene = new THREE.Scene();
	scene.background = new THREE.Color(0x111111);

	camera.position.set(0, 1.5, 10);

	renderer.setSize(innerWidth, innerHeight);
	document.body.appendChild(renderer.domElement);

	const controls = new OrbitControls(camera, renderer.domElement);
	scene.add(new THREE.HemisphereLight(0xffffff, 0x444444, 1.2));

	/* Ground */
	const ground = new THREE.Mesh(new THREE.PlaneGeometry(100, 100), new THREE.MeshStandardMaterial({ color: 0x2e7d32 }));
	ground.rotation.x = -Math.PI / 2;
	ground.position.y = -0.05;
	scene.add(ground);

	// pivot
	const greyMat = new THREE.MeshStandardMaterial({ color: "#a8a8a8ff" });
	const cylGeo = new THREE.CylinderGeometry(0.1, 0.1, 0.05, 16);
	const boxGeo = new THREE.BoxGeometry(0.3, 0.1, 0.05);

	const pivot = new THREE.Object3D();
	pivot.position.set(0, 0, 0);
	scene.add(pivot);

	pivot.add(new THREE.Mesh(new THREE.SphereGeometry(0.05, 10), greyMat));

	// ----- LEFT
	const boxL = new THREE.Mesh(boxGeo, greyMat);
	boxL.position.z = 0.05;
	pivot.add(boxL);
	const cylLeft = new THREE.Mesh(cylGeo, greyMat);
	cylLeft.rotation.z = Math.PI / 2; // rotate to align
	cylLeft.rotation.y = Math.PI / 2; // rotate to align
	cylLeft.position.z = -0.05; // offset left
	pivot.add(cylLeft);

	// ----- RIGHT
	const boxR = new THREE.Mesh(boxGeo, greyMat);
	boxR.position.z = -0.05;
	pivot.add(boxR);
	const cylRight = new THREE.Mesh(cylGeo, greyMat);
	cylRight.rotation.z = Math.PI / 2;
	cylRight.rotation.y = Math.PI / 2; // rotate to align
	cylRight.position.z = 0.05; // offset right
	pivot.add(cylRight);

	ball.material = greyMat;
	scene.add(ball);

	ball.add(rod);

	// Magnet
	magnet.rotateX(Math.PI / 2);
	scene.add(magnet);

	// ---------- OUTER CYLINDER ----------
	const outerGeo = new THREE.CylinderGeometry(0.3, 0.3, 0.2, 32);
	const outerCyl = new THREE.Mesh(outerGeo, greyMat);
	outerCyl.rotation.x = Math.PI / 2; // horizontal
	magnet.add(outerCyl);
	const outerGeo2 = new THREE.CylinderGeometry(0.4, 0.3, 0.2, 32);
	const outerCyl2 = new THREE.Mesh(outerGeo2, greyMat);
	outerCyl2.rotation.x = Math.PI / 2; // horizontal
	magnet.add(outerCyl2);

	// ---------- INNER BLACK CYLINDER ----------
	const innerBlackGeo = new THREE.CylinderGeometry(0.2, 0.2, 0.2, 32);
	const innerBlackMat = new THREE.MeshStandardMaterial({ color: 0x000000, metalness: 0.5, roughness: 0.5 });
	const innerBlackCyl = new THREE.Mesh(innerBlackGeo, innerBlackMat);
	innerBlackCyl.rotation.x = Math.PI / 2;
	innerBlackCyl.position.z = 0.03;
	magnet.add(innerBlackCyl);

	let frame = 0;
	/* ---------- ANIMATION ---------- */
	function animate() {
		requestAnimationFrame(animate);
		controls.update();
		renderer.render(scene, camera);

		if (params.frameTresh === 30 || frame++ % params.frameTresh) return;

		for (let i = 0; i < 10; i++) {
			stepState();
		}
		updateScene();
	}

	animate();
}
