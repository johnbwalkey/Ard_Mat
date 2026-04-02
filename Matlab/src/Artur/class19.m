
%-- test if average height of basketball players is significantly different from general student population
 
clear all
 
h = round(  randn(1, 100)*10 + 175 ); %-- generate height data for 100 students
 
figure;plot( h , '.')
figure;hist( h )
 
b = [ 185 178 192 199 179 200 192 177 193 188]; %-- height of basketball players 
 
figure;plot( b , '.')
 
figure;hist( h ); hold on
hist( b )
 
[hp p] = ttest2( h, b) %-- apply t-test to check if both populations are significantly different
 
 
%% -- doing t-test 'by-hand'  ---
 
m=[];
for i = 1:100 
   r = ceil( rand(1,10) * length( h )); %-- choose 10 random students 
   m(i) = mean( h( r ));   %-- compute average height of that random subgroup
   
end  %-- repeat it 100 times 
 
figure;hist( m ) %-- distribution of means
mean_b = mean( b )
 
( mean_b - mean( m )) / std( m ) %-- expressing average height of players as z scores of distribution of means
% z-score of ~3 means that chance of observing it by chance is only around 1 in 1000 
 
% The above exercise shows that it is very unlikely to chose by random 10 students 
% whose average height would equal or exceed average height of basket ball players
% 
 
 
%% --- randomization test ----
 
h_all = [ h b ]; %-- combine heights of students and players in single vector
gr = [ ones(1,length(h))  ones(1,length(b))*2 ]; %-- corresponding group vector
 
m1=[]; m2=[];
for i = 1:100 
    r = randperm( length( gr ));
    gr_perm = gr( r ); %-- permute (randomize) group assignment
    
    m1(i) = mean( h_all( gr_perm == 1 )); %-- calculate average height for both random groups
    m2(i) = mean( h_all( gr_perm == 2 ));
    
end %-- repeat it 100 times
 
figure; hist( m2 - m1) %-- distribution of height differences between groups 
 
diff_hight = mean(b) - mean( h ); %-- height difference between students and players
hold on; plot( diff_hight,1,'*r') 
 
%-- this plot shows that it is very unlikely ( <0.1% ) to get such height difference between groups just by chance
% thus average height of players is significantly higher that students 
 
 
 
 
 
 
