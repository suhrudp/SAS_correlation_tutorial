/*IMPORT DATA*/
proc import datafile="/home/u62868661/Datasets/Correlation/Album Sales.csv"
dbms=csv
out=df
replace;
run;

/*DESCRIPTIVE TABLE*/
proc means data=df chartype mean std min max median n range vardef=df clm 
		alpha=0.05 q1 q3 qrange qmethod=os;
	var adverts sales airplay attract;
run;

/*HISTOGRAMS*/
proc univariate data=df vardef=df noprint;
	var adverts sales airplay attract;
	histogram adverts sales airplay attract / normal(noprint) kernel;
	inset mean std min max median n range q1 q3 qrange / position=nw;
run;

/*CORRELATION ANALYSIS*/
proc corr data=df pearson spearman kendall rank plots=matrix;
	var adverts airplay attract;
	with sales;
run;

/*LINEAR PLOTS*/
proc sgplot data=df;
	reg x=adverts y=sales / nomarkers cli alpha=0.05;
	scatter x=adverts y=sales /;
	xaxis grid;
	yaxis grid;
run;
proc sgplot data=df;
	reg x=airplay y=sales / nomarkers cli alpha=0.05;
	scatter x=airplay y=sales /;
	xaxis grid;
	yaxis grid;
run;
proc sgplot data=df;
	reg x=attract y=sales / nomarkers cli alpha=0.05;
	scatter x=attract y=sales /;
	xaxis grid;
	yaxis grid;
run;

/*NON-LINEAR PLOTS (PENALIZED CUBIC B-SPLINES)*/
proc sgplot data=df;
	pbspline x=adverts y=sales / nomarkers;
	scatter x=adverts y=sales /;
	xaxis grid;
	yaxis grid;
run;
proc sgplot data=df;
	pbspline x=airplay y=sales / nomarkers;
	scatter x=airplay y=sales /;
	xaxis grid;
	yaxis grid;
run;
proc sgplot data=df;
	pbspline x=attract y=sales / nomarkers;
	scatter x=attract y=sales /;
	xaxis grid;
	yaxis grid;
run;