package thx.svg;

/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 */

enum LineInterpolator
{
	Linear;
	Step;
	StepBefore;
	StepAfter;
	Basis;
	BasisOpen;
	BasisClosed;
	Cardinal(?tension : Float);
	CardinalOpen(?tension : Float);
	CardinalClosed(?tension : Float);
	Monotone;
}