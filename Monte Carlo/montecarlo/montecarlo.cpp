#include <stdio.h>
#define _USE_MATH_DEFINES
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>

// print debugging messages?
#ifndef DEBUG
#define DEBUG	false
#endif

// setting the number of threads:
int NUMT = 2;

// setting the number of trials in the monte carlo simulation:
int NUMTRIALS =  50000;

// how many tries to discover the maximum performance:
#ifndef NUMTIMES
#define NUMTIMES	20
#endif

// ranges for the random numbers:
const float TX_MIN =    -10.;
const float TX_MAX =     10.;
const float TXV_MIN =    10.;
const float TXV_MAX =    30.;
const float TY_MIN =     45.;
const float TY_MAX =     55.;
const float SV_MIN =     10.;
const float SV_MAX =     30.;
const float THETA_MIN =  10.;
const float THETA_MAX =  90.;

// Other constants
const float T_HLEN = 20.;

// degrees-to-radians:
inline
float Radians(float d)
{
    return (M_PI / 180.f) * d;
}

// Function declarations
void    TimeOfDaySeed();
float   Ranf(float low, float high);
int     Rani(int ilow, int ihigh);

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
        NUMTRIALS = atoi(argv[2]);

    TimeOfDaySeed();               // seed the random number generator
    omp_set_num_threads(NUMT);    // set the number of threads to use in parallelizing the for-loop:`

    // better to define these here so that the rand() calls don't get into the thread timing:
    float* txs = new float[NUMTRIALS];
    float* tys = new float[NUMTRIALS];
    float* txvs = new float[NUMTRIALS];
    float* svs = new float[NUMTRIALS];
    float* sths = new float[NUMTRIALS];

    // fill the random-value arrays:
    for (int n = 0; n < NUMTRIALS; n++)
    {
        txs[n] = Ranf(TX_MIN, TX_MAX);
        tys[n] = Ranf(TY_MIN, TY_MAX);
        txvs[n] = Ranf(TXV_MIN, TXV_MAX);
        svs[n] = Ranf(SV_MIN, SV_MAX);
        sths[n] = Ranf(THETA_MIN, THETA_MAX);
    }

    // get ready to record the maximum performance and the probability:
    double  maxPerformance = 0.;    // must be declared outside the NUMTIMES loop
    int     numHits;                // must be declared outside the NUMTIMES loop

    // looking for the maximum performance:
    for (int times = 0; times < NUMTIMES; times++)
    {
        double time0 = omp_get_wtime();

        numHits = 0;

        #pragma omp parallel for default(none) shared(txs,tys,txvs,svs,sths,NUMTRIALS) reduction(+:numHits)
        for (int n = 0; n < NUMTRIALS; n++)
        {
            // randomize everything:
            float tx = txs[n];
            float ty = tys[n];
            float txv = txvs[n];
            float sv = svs[n];
            float stheta_deg = sths[n];
            float stheta_rads = Radians(stheta_deg);
            float svx = sv * cos(stheta_rads) ;
            float svy = sv * sin(stheta_rads); ;

            // how long until the snowball reaches the y depth:
            float t = ty / svy ;

            // how far the truck has moved in x in that amount of time:
            float truckx = tx + txv * t ;

            // how far the snowball has moved in x in that amount of time:
            float sbx = svx * t;

            // does the snowball hit the truck (just check x distances, not height):
            if (fabs(sbx - truckx) < T_HLEN)
            {
                numHits++;
                if (DEBUG)  fprintf(stderr, "Hits the truck at time = %8.3f\n", t);
            }
        } // for( # of  monte carlo trials )

        double time1 = omp_get_wtime();
        double megaTrialsPerSecond = (double)NUMTRIALS / (time1 - time0) / 1000000.;
        if (megaTrialsPerSecond > maxPerformance)
            maxPerformance = megaTrialsPerSecond;

    } // for ( # of timing tries )

    float probability = (float)numHits / (float)(NUMTRIALS);        // just get for last NUMTIMES run
    fprintf(stderr, "%2d threads : %8d trials ; probability = %6.2f%% ; megatrials/sec = %6.2lf\n",
        NUMT, NUMTRIALS, 100. * probability, maxPerformance);

    //. . .

}


float
Ranf(float low, float high)
{
    float r = (float)rand();               // 0 - RAND_MAX
    float t = r / (float)RAND_MAX;       // 0. - 1.

    return   low + t * (high - low);
}

int
Rani(int ilow, int ihigh)
{
    float low = (float)ilow;
    float high = ceil((float)ihigh);

    return (int)Ranf(low, high);
}

// call this if you want to force your program to use
// a different random number sequence every time you run it:
void
TimeOfDaySeed()
{
    struct tm y2k = { 0 };
    y2k.tm_hour = 0;   y2k.tm_min = 0; y2k.tm_sec = 0;
    y2k.tm_year = 100; y2k.tm_mon = 0; y2k.tm_mday = 1;

    time_t  timer;
    time(&timer);
    double seconds = difftime(timer, mktime(&y2k));
    unsigned int seed = (unsigned int)(1000. * seconds);    // milliseconds
    srand(seed);
}