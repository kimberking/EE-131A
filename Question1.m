%% Part A
thicM  = zeros(52, 100000);
inda = zeros(1, 100000);
indb = zeros(1, 100000);
indc = zeros(1, 100000);

for i = 1:100000
    thicM(:,i) = s();
    inda(i) = tupletoind([thicM(5,i), thicM(20,i)]);
    indb(i) = tupletoind([thicM(45,i), thicM(51,i)]);
    indc(i) = tupletoind([thicM(2,i), thicM(32,i)]);
end
    
answer1a = thicM;
pos = zeros(52, 52); 
for i = 1:52
        tab = tabulate(thicM(i, :));
        pos(:, i) = tab(: , 2);
end

figure;
subplot(2,2,1);
histogram1 =  bar3(pos);
xlabel('Card Number (1-52)'); ylabel('Frequency Count')
title('Histogram of Count of Each Card');

subplot(2,2,2);
hist1 = histogram( inda, 'BinWidth', 53.04, 'FaceColor', 'r');
xlabel('Bins (1 - 2652)'); ylabel('Frequency Count');
title('Histogram of Pair (5, 20)'); 
    
subplot(2,2,3);
hist2 = histogram( indb, 'BinWidth', 53.04, 'FaceColor', 'g' );
xlabel('Bins (1 - 2652)'); ylabel('Frequency Count');
title('Histogram of Pair (45, 51)');
    
subplot(2,2,4);
hist3 = histogram(indc, 'Binwidth', 53.04, 'FaceColor', 'b');
xlabel('Bins (1 - 2652)'); ylabel('Frequency Count');
title('Histogram of Pair (2, 32)');

%% Part B
x = zeros(1,200);
for i = 1:100000
   failed = 0; atp = 0;
   while failed == 0
       it = 1;
       shuffle = randperm(52);
       atp = 1 + atp;
       next = 0;
       
       while next == 0
           card = shuffle(it);
           if (shuffle(it) == 4 || shuffle(it) == 3 || shuffle(it) == 2 || shuffle(it) == 1)
               next = 1;
           end
           if (shuffle(it) == 8 || shuffle(it) == 7 || shuffle(it) == 5 || shuffle(it) == 6)
               next = 1;
               if  (shuffle(it+1) == 2 || shuffle(it+1) == 1 || shuffle(it+1) == 4 || shuffle(it+1) == 3)
                 failed = 1;
              end
           end
           it = it + 1;
       end
   end
   if (atp < 200)
        x(atp) = x(atp)+1;
   end
end

n = linspace(1,200,200);
figure(); plot(n, x,'.');
xlabel('n'); ylabel('N_n');
title('N_n Versus n');

d = 0;
for i = 1:200
    d = d + x(i)*i;
end

%% Part C
%See Report


%% Part D
%Part Di
p =  100000./d

%Part Dii for 30
m30 = zeros(1,100);
for i = 1:100
    p = 30./newd30(30);
    m30(i) = p;
end


%Part Dii for 100
m100 = zeros(1,100);
for i = 1:100
    p = 100./newd30(100);
    m100(i) = p;
end

%Part Dii for 300
m300 = zeros(1,100);
for i = 1:100
    p = 300./newd30(300);
    m300(i) = p;
end

%Part Dii for 1000
m1000 = zeros(1,100);
for i = 1:100
    p = 1000./newd30(1000);
    m1000(i) = p;
end

%Part Dii for 3000
m3000 = zeros(1,100);
for i = 1:100
    p = 3000./newd30(3000);
    m3000(i) = p;
end

figure();
boxplot(m30); 
ylim([0.02 0.08]) 
xlabel('m'); ylabel('Distribution');
title('m=30');

figure();
boxplot(m100); 
ylim([0.02 0.08])
xlabel('m'); ylabel('Distribution');
title('m=100');

figure();
boxplot(m300);
ylim([0.02 0.08])
xlabel('m'); ylabel('Distribution');
title('m=300');

figure();
boxplot(m1000); 
ylim([0.02 0.08])
xlabel('m'); ylabel('Distribution');
title('m=1000');

figure();
boxplot(m3000);
ylim([0.02 0.08])
xlabel('m'); ylabel('Distribution');
title('m=3000');

%% Part E
len = max(x);
ind = 1; new_Nn = []; new_n = [];
for i = 1:200
    if x(i) == 0
        continue;
    end
    
    new_Nn = cat(1, new_Nn, x(i));
    new_n = cat(1, new_n, n(i));
    ind = ind+1;
end

log_Nn = log(new_Nn);
figure();
slope = polyfit(new_n, log_Nn, 1);
p_slope = slope(1)

hold on;
plot(new_n,log_Nn,'.',1:0.1:500,polyval(slope,1:0.1:500),'-');
xlabel('n'); ylabel('log(N)'); title('log(N) vs n');

%% Part F
%See Report

%% Functions
function shuf = s()
    shuf = randperm(52, 52);
end

function ind = tupletoind(tuple)
remainder = tuple(2);

if remainder >= tuple(1)
    remainder = remainder - 1;
end

ind = (tuple(1)-1).*52 - remainder;
end

function y = newd30(z)
x = zeros(1,200);
for i = 1:z
   failed = 0;
   atp = 0;
   while failed == 0
       it = 1;
       shuffle = randperm(52);
       atp = atp + 1;
       next = 0;
       while next == 0
           card = shuffle(it);
           if (shuffle(it) == 1 || shuffle(it) == 2 || shuffle(it) == 3 || shuffle(it) == 4)
               next = 1;
           end
           if (shuffle(it) == 5 || shuffle(it) == 6 || shuffle(it) == 7 || shuffle(it) == 8)
               next = 1;
               if  (shuffle(it+1) == 1 || shuffle(it+1) == 2 || shuffle(it+1) == 3 || shuffle(it+1) == 4)
                 failed = 1;
              end
           end
           it = it + 1;
       end
   end
   
   if (atp < 200)
        x(atp) = x(atp)+1;
   end
end

d = 0;
for i = 1:200
    d = d + x(i)*i;
end
y = d;
end