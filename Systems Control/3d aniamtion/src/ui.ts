import { GUI } from "lil-gui";
import * as math from "mathjs";
import { matrices, params } from "./logic";
import { setRodL } from "./scene";

function pushBy(phi) {
	let i = 0;
	const iter = 10;

	function anim() {
		const matrix = params.controller == "lqr" ? matrices.xLqr : matrices.xPID;
		matrix.set([0, 0], phi / iter + matrix.get([0, 0]));

		if (i++ < iter) requestAnimationFrame(anim);
	}
	anim();
}

export default function createUI() {
	const panel = new GUI({ width: 310 });

	const settings = {
		speed: 30,
		controller: params.controller,
		pushR: () => pushBy(0.4),
		pushL: () => pushBy(-0.4),

		...matrices.K.pid,
		rodLength: params.rodL,
		mass: params.mass,
		d: params.d,
		k: params.k,
		Lc: params.Lc,
		i0: params.i0,
		Res: params.Resistance,
	};
	setRodL(30);

	panel.add(settings, "pushR").name("Push ->");
	panel.add(settings, "pushL").name("<- Push");
	panel
		.add(settings, "speed", 0, 30, 1)
		.name("speed")
		.listen()
		.onChange((speed) => {
			params.frameTresh = 30 - speed;
		});

	// for (const el of ["Kp_phi", "Kd_phi", "Kp_i", "Ki_i"]) {
	// 	panel
	// 		.add(settings, el as "Kp_phi" | "Kd_phi" | "Kp_i" | "Ki_i", 0, 500, 1)
	// 		.name(el)
	// 		.listen()
	// 		.onChange((val) => {
	// 			matrices.K.pid[el] = val;
	// 			matrices.xPID = math.matrix(
	// 				[
	// 					[0.2], // theta (rad)
	// 					[0], // theta_dot
	// 					[0],
	// 					[0],
	// 				], // current
	// 			);
	// 		});
	// }
	// panel
	// 	.add(settings, "controller", ["lqr", "pid"])
	// 	.name("controller")
	// 	.listen()
	// 	.onChange((c) => {
	// 		params.controller = c;
	// 	});
	// panel
	// 	.add(settings, "rodLength", 1, 50, 1)
	// 	.name("Rod Length")
	// 	.listen()
	// 	.onChange((l) => {
	// 		setRodL(l);
	// 		updateScene();
	// 	});
	// panel
	// 	.add(settings, "mass", 0, 300, 1)
	// 	.name("mass")
	// 	.listen()
	// 	.onChange((m) => {
	// 		params.mass = m * gr;
	// 		setMatrices();
	// 	});
	// panel
	// 	.add(settings, "d", 1, 10, 0.1)
	// 	.name("distance")
	// 	.listen()
	// 	.onChange((dist) => {
	// 		params.d = dist * cm;
	// 		setMatrices();
	// 	});
	// panel
	// 	.add(settings, "k", 1, 10, 0.1)
	// 	.name("k")
	// 	.listen()
	// 	.onChange((val) => {
	// 		params.k = val;
	// 		setMatrices();
	// 	});
	// panel
	// 	.add(settings, "Lc", 0, 0.1, 0.01)
	// 	.name("Lc")
	// 	.listen()
	// 	.onChange((val) => {
	// 		params.Lc = val;
	// 		setMatrices();
	// 	});
	// panel
	// 	.add(settings, "Res", 0, 1000, 1)
	// 	.name("Res")
	// 	.listen()
	// 	.onChange((val) => {
	// 		params.Resistance = val;
	// 		setMatrices();
	// 	});

	panel.open();
}
