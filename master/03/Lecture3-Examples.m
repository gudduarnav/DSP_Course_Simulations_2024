
%% 
subplot(2,1,1)
x = [1 zeros(1,100)] ; 
stem(x) ;

subplot(2,1,2) 
y = filter([1 0.8], [1 0.5], x) ;
stem(y,'r')  

