import * as math from "mathjs";

// Units
export const cm = 1e-2;
export const gr = 1e-3;

// Physical parameters
export const params = {
	g: 9.81,
	rodL: 30 * cm,
	mass: 150 * gr,
	d: 2 * cm,

	// Electrical parameters
	k: 3300,
	Lc: 0.02,
	i0: 1e-7,
	Resistance: 4,
	alpha: 0,

	frameTresh: 1,
	controller: "lqr",
};
params.alpha = (2 * params.k * params.i0) / ((params.mass * params.rodL * params.d) ^ 2);

export const matrices = {
	A: math.matrix([]),
	B: math.matrix([]),

	xLqr: math.matrix(
		[
			[0.2], // theta (rad)
			[0], // theta_dot
			[0],
		], // current
	),

	xPID: math.matrix(
		[
			[0.2], // theta (rad)
			[0], // theta_dot
			[0],
			[0],
		], // current
	),
	K: {
		lqr: math.matrix([[10.9315, 1.2634, 6.7703]]),
		pid: {
			Kp_phi: 40,
			Kd_phi: 8,
			Kp_i: 20,
			Ki_i: 400,
		},
	},
};

export function setMatrices() {
	matrices.A = math.matrix([
		[0, 1, 0],
		[params.g / params.rodL, 0, (2 * params.k * params.i0) / (params.mass * params.rodL * params.d * params.d)],
		[0, 0, -params.Resistance / params.Lc],
	]);
	matrices.B = math.matrix([[0], [0], [1 / params.Lc]]);
}
setMatrices();

const dt = 0.005;

function dxdt(x: math.Matrix) {
	// u = -K*x
	const u = math.multiply(-1, math.multiply(matrices.K.lqr, x));
	return math.add(math.multiply(matrices.A, x), math.multiply(matrices.B, u));
}
function rk4Step(x: math.Matrix, dt: number) {
	const k1 = dxdt(x);
	const k2 = dxdt(math.add(x, math.multiply(k1, dt / 2)));
	const k3 = dxdt(math.add(x, math.multiply(k2, dt / 2)));
	const k4 = dxdt(math.add(x, math.multiply(k3, dt)));

	return math.add(x, math.multiply(math.add(k1, math.multiply(2, k2), math.multiply(2, k3), k4), dt / 6));
}

/* ---------- INTEGRATOR ---------- */
export function stepState() {
	if (params.controller === "lqr") {
		matrices.xLqr = rk4Step(matrices.xLqr, dt);
	} else {
		matrices.xPID = rk4StepPID(matrices.xPID, dt);
	}
}

function lqrODE(x: math.Matrix, K: math.Matrix) {
	console.assert(x.size()[1] === 1, "x must be column vector");
	console.assert(K.size()[0] === 1, "K must be row vector");

	// u = -Kx
	const Ax = math.multiply(matrices.A, x); // (n×1)
	const u = math.multiply(K, x); // (1×1)
	const Bu = math.multiply(matrices.B, u); // (n×1)

	const dx = math.subtract(Ax, Bu);

	return dx;
}

function pidODE(x: math.Matrix, Kp_phi: number, Kd_phi: number, Kp_i: number, Ki_i: number) {
	const phi = x.get([0, 0]);
	const phiDot = x.get([1, 0]);
	const i = x.get([2, 0]);
	const z_i = x.get([3, 0]); // integrator (inner loop)

	// Outer loop (angle PD)
	const e_phi = -phi;
	const i_ref = Kp_phi * e_phi - Kd_phi * phiDot;

	// Inner loop (current PI)
	const e_i = i_ref - i;
	const u = Kp_i * e_i + Ki_i * z_i;

	//  Plant dynamics
	const phiDot_dot = (params.g / params.rodL) * phi + params.alpha * i;
	const i_dot = -(params.Resistance / params.Lc) * i + (1 / params.Lc) * u;

	// Integrator dynamics
	const z_i_dot = e_i;

	// State derivative
	return math.matrix([[phiDot], [phiDot_dot], [i_dot]]);
}

function dxdtPID(x: math.Matrix) {
	const phi = x.get([0, 0]);
	const phiDot = x.get([1, 0]);
	const i = x.get([2, 0]);
	const z_i = x.get([3, 0]); // integrator for inner loop

	// Outer loop (angle PD)
	const e_phi = -phi; // error relative to upright
	const i_ref = matrices.K.pid.Kp_phi * e_phi - matrices.K.pid.Kd_phi * phiDot;

	// Inner loop (current PI)
	const e_i = i_ref - i;
	const u = matrices.K.pid.Kp_i * e_i + matrices.K.pid.Ki_i * z_i;

	// Plant dynamics
	const phiDot_dot = (params.g / params.rodL) * phi + params.alpha * i;
	const i_dot = -(params.Resistance / params.Lc) * i + (1 / params.Lc) * u;

	// Integrator derivative
	const z_i_dot = e_i;

	return math.matrix([[phiDot], [phiDot_dot], [i_dot], [z_i_dot]]);
}

function rk4StepPID(x: math.Matrix, dt: number) {
	const k1 = dxdtPID(x);
	const k2 = dxdtPID(math.add(x, math.multiply(k1, dt / 2)));
	const k3 = dxdtPID(math.add(x, math.multiply(k2, dt / 2)));
	const k4 = dxdtPID(math.add(x, math.multiply(k3, dt)));

	return math.add(x, math.multiply(math.add(k1, math.multiply(2, k2), math.multiply(2, k3), k4), dt / 6));
}
