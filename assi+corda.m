close all, clear all ;syms v1a v2a ;assume(v1a,'real');assume(v2a,'real')
Vo=[2 5]'; G=10^-3*[0.1 0.05 ; 0.05 0.5]; Vast=[v1a v2a]';V=Vast+Vo;
Ct=(Vo'*G);Pat=Ct*Vast+Vast'*G*Vast;
intervallo=[-10,10]; a=intervallo(1);
s= v2a+Vo(2)==0;
xnew1=0;xnew2=solve(s,v2a);
fcontour(Pat,[-10 10 -10 10]), hold on;
figure, fsurf(Pat),hold on;
figure(2), scatter3(xnew1,xnew2,vpa(subs(subs(Pat,v2a,xnew2),v1a,xnew1)))
figure(1), scatter(xnew1,xnew2) 
for i=0:10
xk=intervallo(2);
if(mod(i,2)==0)
pat=subs(Pat,v2a,xnew2);g=gradient(pat,[v1a v2a]);
while abs(subs(g(1),v1a,xk))>0.001
xnew1=a-subs(g(1),v1a,a)*(a-xk)/(subs(g(1),v1a,a)-subs(g(1),v1a,xk));xk=(xnew1);
end
else
pat=subs(Pat,v1a,xnew1);g=(gradient(pat, [v1a, v2a]));
while abs(subs(g(2),v2a,xk))>0.001
xnew2=a-subs(g(2),v2a,a)*(a-xk)/(subs(g(2),v2a,a)-subs(g(2),v2a,xk));xk=(xnew2);
end
end
figure(2), scatter3(xnew1,xnew2,vpa(subs(subs(Pat,v2a,xnew2),v1a,xnew1)))
figure(1), scatter(xnew1,xnew2)
end
xx=vpa([xnew1,xnew2])
pat=vpa(subs(subs(Pat,v2a,xnew2),v1a,xnew1))
% fsurf(Pat) fcontour(Pat,[-3 0  -3 0])
