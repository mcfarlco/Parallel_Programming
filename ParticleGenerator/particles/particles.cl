typedef float4 point;
typedef float4 vector;
typedef float4 color;
typedef float4 sphere;


vector
Bounce( vector in, vector n )
{
	vector out = in - n*(vector)( 2.*dot(in.xyz, n.xyz) );
	out.w = 0.;
	return out;
}

vector
BounceSphere( point p, vector v, sphere s )
{
	vector n;
	n.xyz = fast_normalize( p.xyz - s.xyz );
	n.w = 0.;
	return Bounce( v, n );
}

bool
IsInsideSphere( point p, sphere s )
{
	float r = fast_length( p.xyz - s.xyz );
	return  ( r < s.w );
}

kernel
void
Particle( global point *dPobj, global vector *dVel, global color *dCobj )
{
	const float4 G       = (float4) ( 0., 9.8, 0., 0. );
	const float  DT      = 0.05;
	const sphere Sphere1 = (sphere)( -850., 0., 0.,  600. );
	const sphere Sphere2 = (sphere)( 850., 0., 0.,  600. );
	const sphere Sphere3 = (sphere)( 0., 850., 0.,  600. );
	const sphere Sphere4 = (sphere)( 0., 0., -825.,  600. );
	const sphere Sphere5 = (sphere)( 0., 0., 825.,  600. );
	int gid = get_global_id( 0 );

	// extract the position and velocity for this particle:
	point  p = dPobj[gid];
	vector v = dVel[gid];
	color  c = dCobj[gid];

	// advance the particle:

	point  pp = p + v*DT + G*(point)( .5*DT*DT );
	vector vp = v + G*DT;
	pp.w = 1.;
	vp.w = 0.;

	// test against the spheres:

	if( IsInsideSphere( pp, Sphere1 ) )
	{
		vp = BounceSphere( p, v, Sphere1 );
		pp = p + vp*DT + G*(point)( .5*DT*DT );
	}

	if( IsInsideSphere( pp, Sphere2 ) )
	{
		vp = BounceSphere( p, v, Sphere2 );
		pp = p + vp*DT + G*(point)( .5*DT*DT );
	}

	if( IsInsideSphere( pp, Sphere3 ) )
	{
		vp = BounceSphere( p, v, Sphere3 );
		pp = p + vp*DT + G*(point)( .5*DT*DT );
	}

	if( IsInsideSphere( pp, Sphere4 ) )
	{
		vp = BounceSphere( p, v, Sphere4 );
		pp = p + vp*DT + G*(point)( .5*DT*DT );
	}

	if( IsInsideSphere( pp, Sphere5 ) )
	{
		vp = BounceSphere( p, v, Sphere5 );
		pp = p + vp*DT + G*(point)( .5*DT*DT );
	}

	dPobj[gid] = pp;
	dVel[gid]  = vp;
	dCobj[gid] = vp;
}
