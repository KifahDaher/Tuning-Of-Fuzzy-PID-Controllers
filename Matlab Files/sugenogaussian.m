a = newfis('a','sugeno');


a = addvar(a,'input','E',[-100 100]);
a = addmf(a,'input',1,'Negative','gaussmf', [42.73 -100]);
a = addmf(a,'input',1,'zero','gaussmf', [-42.73 0]); 
a = addmf(a,'input',1,'Positive','gaussmf', [42.73 100]);


a = addvar(a,'input','CE',[-100 100]);
a = addmf(a,'input',2,'Negative','gaussmf', [42.73 -100]);
a = addmf(a,'input',2,'zero','gaussmf', [-42.73 0]); 
a = addmf(a,'input',2,'Positive','gaussmf', [42.73 100]);


a = addvar(a,'output','u',[-200 200]);
a = addmf(a,'output',1,'NB','constant',-200);
a = addmf(a,'output',1,'N','constant',-100);
a = addmf(a,'output',1,'Z','constant',0);
a = addmf(a,'output',1,'P','constant',100);
a = addmf(a,'output',1,'PB','constant',200);

ruleList = [1 1 1 1 1;   
            1 2 2 1 1;                         
            1 3 3 1 1;  
            2 1 2 1 1;   
            2 2 3 1 1;   
            2 3 4 1 1;   
            3 1 3 1 1;   
            3 2 4 1 1;   
            3 3 5 1 1];  
a = addrule(a,ruleList);
figure
plotmf(a,'input',1);
figure
plotmf(a,'input',2);
figure
gensurf(a)

Step = 50; 
E = -100:Step:100;
CE = -100:Step:100;
N = length(E);
LookUpTableData = zeros(N);
for i=1:N
   for j=1:N
      % compute output u for each combination of break points
      LookUpTableData(i,j) = evalfis([E(i) CE(j)],a)
   end
end

