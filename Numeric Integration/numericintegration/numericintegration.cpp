#include <stdio.h>
#define _USE_MATH_DEFINES
#include <math.h>
#include <stdlib.h>
#include <omp.h>

// print debugging messages?
#ifndef DEBUG
#define DEBUG	false
#endif

// setting the number of threads:
int NUMT = 4;

// setting the number of nodes:
int NUMNODES = 4096;

// constants
#define XMIN     -1.
#define XMAX      1.
#define YMIN     -1.
#define YMAX      1.

// function prototypes
float Height(int, int, int, float, float);	

int
main(int argc, char* argv[])
{
#ifndef _OPENMP
	fprintf(stderr, "No OpenMP support!\n");
	return 1;
#endif

	if (argc >= 2)
		NUMT = atoi(argv[1]);

	if (argc >= 3)
		NUMNODES = atoi(argv[2]);

	omp_set_num_threads(NUMT);    // set the number of threads to use in parallelizing the for-loop:

	// get ready to record the maximum performance and volumne:
	double  maxPerformance = 0.;
	float	volume = 0.;
	double  time0 = omp_get_wtime();

	// The code to evaluate the height at a given iu and iv is:
	const float N = 2.5f;
	const float R = 1.2f;
	
	// Collapse node loops
	#pragma omp parallel for collapse(2) default(none) shared(NUMNODES, N, R) reduction(+:volume)
	for (int iv = 0; iv < NUMNODES; iv++)
	{
		for (int iu = 0; iu < NUMNODES; iu++)
		{

			float z = Height(iu, iv, NUMNODES, N, R);
			float fullTileArea = (((XMAX - XMIN) / (float)(NUMNODES - 1)) *
				((YMAX - YMIN) / (float)(NUMNODES - 1)));
			
			if ((iu == 0 || iu == NUMNODES - 1) && (iv == 0 || iv == NUMNODES - 1))
				fullTileArea = fullTileArea * .25;

			else if ((iu == 0 || iu == NUMNODES - 1) || (iv == 0 || iv == NUMNODES - 1))
				fullTileArea = fullTileArea * .5;

			volume += z * fullTileArea * 2; // Double height equation for both sides of Z
		}
	}

	double time1 = omp_get_wtime();
	double megaNodesPerSecond = (double)NUMNODES * NUMNODES / (time1 - time0) / 1000000.;
	if (megaNodesPerSecond > maxPerformance)
		maxPerformance = megaNodesPerSecond;

	fprintf(stderr, "%2d threads, %8d nodes, volume = %6.2f, meganodes/sec = %6.2lf\n",
		NUMT, NUMNODES, volume, maxPerformance);
}

float Height(int iu, int iv, int NUMNODES, float N, float R) // iu,iv = 0 .. NUMNODES-1
{
	float x = -1. + 2. * (float)iu / (float)(NUMNODES - 1);	// -1. to +1.
	float y = -1. + 2. * (float)iv / (float)(NUMNODES - 1);	// -1. to +1.

	float xn = pow(fabs(x), (double)N);
	float yn = pow(fabs(y), (double)N);
	float rn = pow(fabs(R), (double)N);
	float r = rn - xn - yn;
	if (r <= 0.)
		return 0.;
	float height = pow(r, 1. / (double)N);
	return height;
}