a1=2; a2=0.5; a=2^0.5; t=10000; bins=-15:1:15;

%% Part A
rand1=rand(1,t);
X1=zeros(1,t);
X2=zeros(1,t);

for i=1:1:t
    if rand1(i)>0.5
        X1(i)=-log(2-2*rand1(i))/a1;
        X2(i)=-log(2-2*rand1(i))/a2;
    else
        X1(i)=log(2*rand1(i))/a1;
        X2(i)=log(2*rand1(i))/a2;
    end
end

cnt=hist (X1,bins);
subplot(2,1,1);
plot (bins,cnt./(t));
title('a = 2, pdf');xlabel('x');ylabel('pdf');
subplot(2,1,2);
cdf1=cumsum(cnt./t);
plot(bins,cdf1);
title('a = 2, cdf');xlabel('x');ylabel('cdf');
figure;
subplot(2,1,1);
cnt2=hist(X2,bins);
plot(bins,cnt2./(10000));
title('a = 0.5, pdf');xlabel('x');ylabel('pdf');
cdf2=cumsum(cnt2./t);
subplot(2,1,2);
plot(bins,cdf2);
title('a = 0.5, cdf');xlabel('x');ylabel('cdf');

%% Part B
X3 = zeros(1,t);
error=0;
for i=1:1:t
    if rand1(i)>0.5
        X3(i)=-log(2-2*rand1(i))/a;
    else
        X3(i)=log(2*rand1(i))/a;
    end
    if i<=5000
        if X3(i) <-2
            error= 1 + error;
        end
    else
        if X3(i) >+2
            error= 1 + error;
        end
    end
end

fprintf('Emprical Error Probability = %i%%\n', error/t*100);