
%-- plot data from example in class17_Stat_overview_Matlab.ppt

h = [8, 7, 4, 10, 8, 6, 8, 9, 9, 7, 3, 7, 6, 5, 0, ...
     9, 10, 7, 7, 3, 6, 7, 5, 2, 1, 6, 7, 10, 8, 8]; %-- sample data
 

figure; hist( h ,1:1:10)
figure; hist( h ,1:3:10) %-- plot histograms using different binning     
figure; plot( h,'.' )
figure; plot( sort( h ),'.' )

%-- normal distrib
g = randn( 1, 10000 )
figure; plot( g,'.' )
figure; hist( g, 20 )

mean( g) 
std( g) 
median( g )

%-- bimodal distributions ---

g= 0.7 + ( 1.3-0.7).*rand(100,1)
r= 3.7 + ( 6.3-3.7).*rand(100,1)

figure; plot(g, '.')
hold on
plot(r, '.')
g2 = [ g; r ];
figure;hist( g2, 50 )


g2 = [randn( 1, 1000 )  randn( 1, 1000 )+4]; %-- similar as above but done in 1 line
figure;plot( g2,'.' )
figure;hist( g2, 50 )


%--- skewed distributions ---

a1 = 3 + .2.*randn(1, 500);
a2 = 1 + 2.*rand(1, 500);
figure; hist([a1 a2], 50)

g = randn(1,500).^2 % - square values
figure;plot( g,'.')
figure;hist(g)

g = abs(randn(1,500))
figure;plot( g,'.')
figure;hist(g)

g = randn(1,500);
f = find( g < 0 ); 
g( f ) =[]; %-- delete negative  values from normal distribution
figure;plot( g,'.')
figure;hist(g)

g = pearsrnd(0, 1, 0.7, 3, 1, 1000)
figure; hist(g, 20)

g = [rand(1,20) rand(1,5)+1]
figure; hist(g, 10)

%-- hypothesis testing

g = randn(1,500) + 1 ;
figure; hist(g, 50)
[h p] = ttest( g, 1 ) 


g1 = randn(1,500) + 1 ;
g2 = randn(1,500) + 4 ;
[h p] = ttest2( g1, g2 ) %-- use t-test to check if 2 populations have significantly different mean



%-- correlation coefficient  --

c1 = randn(1,50);
c2 = randn(1,50) + c1 ;
figure;plot( c1,c2,'.')
[cc pp] = corrcoef( c1,c2)


c1 = [c1 20]; %-- add outlier
figure;plot( c1,'.')
c2 = [c2 -20];%-- add outlier
figure;plot( c2,'.')

figure;plot( c1,c2,'.')
[cc pp] = corrcoef( c1,c2)













