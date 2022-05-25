#include <stdio.h>
#include <stdlib.h>
#define _USE_MATH_DEFINES
#include <math.h>
#include <omp.h>

// print debugging messages?
#ifndef DEBUG
#define DEBUG	false
#endif

// Define constants
const float GRAIN_GROWS_PER_MONTH = 12.0;	// inches
const float ONE_DEER_EATS_PER_MONTH = 1.0;
const float ONE_WOLF_EATS_PER_MONTH = 1.0;

const float AVG_PRECIP_PER_MONTH = 7.0;		// average in inches
const float AMP_PRECIP_PER_MONTH = 6.0;		// plus or minus
const float RANDOM_PRECIP = 2.0;			// plus or minus noise

const float AVG_TEMP = 60.0;				// average in Fahrenheit
const float AMP_TEMP = 20.0;				// plus or minus
const float RANDOM_TEMP = 10.0;				// plus or minus noise

const float MIDTEMP = 40.0;
const float MIDPRECIP = 10.0;

// Define global variables
unsigned int seed = 0;
int	NowYear = 2022;				// 2022 - 2027
int	NowMonth = 0;				// 0 - 11

float	NowPrecip = AVG_PRECIP_PER_MONTH;				// inches of rain per month
float	NowTemp = AVG_TEMP;				// temperature this month
float	NowHeight = 6;			// grain height in inches
int		NowNumDeer = 2;			// number of deer in the current population
int		NowNumWolves = 1;		// number of wolves in the current population

omp_lock_t	Lock;
volatile int	NumInThreadTeam;
volatile int	NumAtBarrier;
volatile int	NumGone;

// Define function prototypes
void	Deer();
void	Grain();
void	Watcher();
void	Wolves();
float   Ranf(float low, float high);
float	SQR(float x);
void	InitBarrier(int);
void	WaitBarrier();

int
main(int argc, char* argv[])
{
	#ifndef _OPENMP
		fprintf(stderr, "No OpenMP support!\n");
		return 1;
	#endif

	fprintf(stderr, "Month, Year, Grain Height, Number of Deer, Number of Wolves, Temperature, Precipitation\n");

	omp_set_num_threads(4);
	InitBarrier(4);
	#pragma omp parallel sections
		{
			#pragma omp section
			{
				Deer();
			}

			#pragma omp section
			{
				Grain();
			}

			#pragma omp section
			{
				Wolves();
			}

			#pragma omp section
			{
				Watcher();
			}
		}
}

void Deer() {
	while (NowYear < 2028)
	{
		// compute a temporary next-value for this quantity
		// based on the current state of the simulation:

		int nextNumDeer = NowNumDeer;
		int carryingCapacity = (int)(NowHeight);

		if (nextNumDeer < carryingCapacity)
			if (nextNumDeer * 3 < carryingCapacity)
				nextNumDeer += 2;
			else
				nextNumDeer++;
		else
			if (nextNumDeer > carryingCapacity)
				nextNumDeer--;

		nextNumDeer -= floor(NowNumWolves * ONE_WOLF_EATS_PER_MONTH);

		if (nextNumDeer < 0)
			nextNumDeer = 0;
		WaitBarrier();	// DoneComputing barrier

		NowNumDeer = nextNumDeer;
		WaitBarrier();	// DoneAssigning barrier
		WaitBarrier();	// DonePrinting barrier
	}
}

void Grain() {
	while (NowYear < 2028)
	{
		// compute a temporary next-value for this quantity
		// based on the current state of the simulation:
		float tempFactor = exp(-SQR((NowTemp - MIDTEMP) / 10.));
		float precipFactor = exp(-SQR((NowPrecip - MIDPRECIP) / 10.));
		float nextHeight = NowHeight;
		nextHeight += tempFactor * precipFactor * GRAIN_GROWS_PER_MONTH;
		nextHeight -= (float)NowNumDeer * ONE_DEER_EATS_PER_MONTH;
		if (nextHeight < 0.) nextHeight = 0.;
		WaitBarrier(); // DoneComputing barrier

		NowHeight = nextHeight;
		WaitBarrier();	// DoneAssigning barrier
		WaitBarrier();	// DonePrinting barrier
	}
}

void Wolves() {
	while (NowYear < 2028)
	{
		// compute a temporary next-value for this quantity
		// based on the current state of the simulation:
		int nextNumWolves = NowNumWolves;
		int carryingCapacity = (int)(NowNumDeer);

		if (nextNumWolves < carryingCapacity && NowMonth % 2 == 1)
			nextNumWolves++;
		else if (carryingCapacity == 0)
			nextNumWolves = 0;
		else if (nextNumWolves > carryingCapacity)
			nextNumWolves--;

		if (nextNumWolves < 0)
			nextNumWolves = 0;

		WaitBarrier();	// DoneComputing barrier

		NowNumWolves = nextNumWolves;
		WaitBarrier();	// DoneAssigning barrier
		WaitBarrier();	// DonePrinting barrier
	}
}

void Watcher() {
	while (NowYear < 2028)
	{
		// compute a temporary next-value for this quantity
		// based on the current state of the simulation:
		
		WaitBarrier();	// DoneComputing barrier
		WaitBarrier();	// DoneAssigning barrier

		fprintf(stderr, "%4d, %4d, %6.2f, %4d, %4d, %6.2f, %6.2f\n",
			NowMonth, NowYear, NowHeight, NowNumDeer, NowNumWolves, NowTemp, NowPrecip);

		NowMonth++;
		if (NowMonth >= 12) {
			NowMonth = 0;
			NowYear++;
		}

		float ang = (30. * (float)NowMonth + 15.) * (M_PI / 180.);
		float temp = AVG_TEMP - AMP_TEMP * cos(ang);
		NowTemp = temp + Ranf(-RANDOM_TEMP, RANDOM_TEMP);
		float precip = AVG_PRECIP_PER_MONTH + AMP_PRECIP_PER_MONTH * sin(ang);
		NowPrecip = precip + Ranf(-RANDOM_PRECIP, RANDOM_PRECIP);
		if (NowPrecip < 0.) NowPrecip = 0.;

		WaitBarrier();	// DonePrinting barrier
	}
}

float
Ranf(float low, float high)
{
	float r = (float)rand();				// 0 - RAND_MAX
	float t = r / (float)RAND_MAX;			// 0. - 1.

	return   low + t * (high - low);
}

int
Ranf(int ilow, int ihigh)
{
	float low = (float)ilow;
	float high = ceil((float)ihigh);

	return (int)Ranf(low, high);
}

float
SQR(float x)
{
	return x * x;
}

void
InitBarrier(int n)
{
	NumInThreadTeam = n;
	NumAtBarrier = 0;
	omp_init_lock(&Lock);
}

void
WaitBarrier()
{
	omp_set_lock(&Lock);
	{
		NumAtBarrier++;
		if (NumAtBarrier == NumInThreadTeam)
		{
			NumGone = 0;
			NumAtBarrier = 0;
			// let all other threads get back to what they were doing
			// before this one unlocks, knowing that they might immediately
			// call WaitBarrier( ) again:
			while (NumGone != NumInThreadTeam - 1);
			omp_unset_lock(&Lock);
			return;
		}
	}
	omp_unset_lock(&Lock);

	while (NumAtBarrier != 0);	// this waits for the nth thread to arrive

	#pragma omp atomic
	NumGone++;			// this flags how many threads have returned
}