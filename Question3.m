t = 10000; n = [1 5 15 50]; S = zeros(1,t); Seq= zeros(4,t); Seq2= zeros(4,t);

%% Part A
for i = 1:1:4    
    if i==1
          X = 5.*rand(1,t)+1; 
          Seq(i,:) = X;
     else
         Seq(i,:) = Seq(i-1,:);
         
         for j = n(i-1)+1:1:n(i)
              X = 5.*rand(1,t)+1; 
              Seq(i,:) = Seq(i,:) + X;
         end
     end

     dom = min(Seq(i,:))-1:0.2:max(Seq(i,:))+1;
     pdfe = histc(Seq(i,:),dom)/t; cdfe = cumsum(pdfe);
     
     figure
     plot(dom,pdfe); xlabel('x');ylabel('f_S_n(x)');
     title({sprintf('PDF of S_n for n = %d', n(i))});

     figure
     plot(dom,cdfe); xlabel('x'); ylabel('F_S_n(x)');
     title({sprintf('CDF of S_n for n = %d', n(i))});
     
     %% Part B
     for j = 1:1:4
         display (mean(Seq(j,:)), sprintf('Mean, n = %g', n(j)));
         display (var(Seq(j,:)),  sprintf('Variance, n = %g', n(j)));
     end
     
     %% Part C
     G = std(Seq(i,:))*randn(1,t)+ mean(Seq(i,:));
     pdfn = histc(G,dom)/t; cdfn=cumsum(pdfn);
     
     figure;
     hold on
     plot (dom, pdfe); plot (dom, pdfn);
     hold off 
     xlabel('x'); ylabel('f_X (x)'); legend ('S_n','G_n');
     title ({'PDF of S_n and G_n',sprintf('n = %g', n(i))});
     
     figure;
     hold on
     plot (dom, cdfe); plot (dom,cdfn);
     xlabel('x'); ylabel('F_X (x)'); legend ('S_n','G_n');
     title ({'CDF of S_n and G_n',sprintf('n = %g', n(i))});

end

%% Part D
DMat = zeros(1, 10000);

for i = 1:10000
    for j = 1:50
        DMat(1, i) = exprnd(1) + DMat(1,i);
    end
end

figure;
x1 = 1:.1:100;
subplot(2,1,1);
graphs = histogram(DMat(1,:), 50, 'Normalization', 'probability');  
title('PDF n = 50 Exponential RV'); xlabel('Sum (S)'); ylabel('P[X = x]'); 
subplot(2,1,2); tab1 = tabulate(DMat(1,:)); plot(tab1(:,1),cumsum(tab1(:,2))./10000);
title('CDF n = 50 Exponential RV'); xlabel('Sum (S)'); ylabel('P[X = x]'); 
subplot(2,1,1); hold on; gaussian = normpdf(x1, 50, sqrt(20)); 
plot(x1, gaussian); legend ('Gaussian','S'); subplot(2,1,2); hold on;
plot(x1, normcdf(x1, 50, sqrt(20))); legend ('Gaussian','S');