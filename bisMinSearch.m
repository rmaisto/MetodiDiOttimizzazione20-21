function [Pmin, Imin, Niter, points, gradients, functionValues] = bisMinSearch(R, I0, Xo, NiterMax)

syms i1 i2 alfa 'real';
I = [i1 i2]';
C = R' * I0;
Istar = I - I0;
f = C' * Istar + Istar' * R * Istar; %Funzione Obbiettivo
g = 2 * R * Istar + C; %Gradiente

points = [];
gradients = [];
functionValues = [];

%Grafico della superficie
fsurf(f);
hold on;
%Grafico curve equilivello
fcontour(f);

Niter = 1;
Xold = Xo;

while true
   gXold = subs(g, I, Xold); %Gradiente valutato nel punto Xold
   %Derivata direzionale della funzione rispetto alla direzione opposta a
   %quella del gradiente valutato nel punto Xold
   falfa = subs(f, I, Xold + alfa * (-gXold));
   dfalfa = diff(falfa);
   
   %Necessito di due punti opportuni per l'intervallo in cui applicare la
   %bisezione
   a = solve(dfalfa < 0);
   b = solve(dfalfa > 0);
   alfa0 = bisezione(dfalfa, a, b, NiterMax);
   
   Xnew = Xold + alfa0 * (-gXold);
   
   %La ricerca del minimo si arresterà dopo un numero massimo di iterazioni
   %oppure quando la distanza tra il nuovo punto e quello precedente sarà
   %zero
   if norm(Xold - Xnew) <= 1e-6 || Niter >= NiterMax
       break;
   end
   
   Xold = Xnew;
   
   points = [points; double(Xnew')];
   gradients = [gradients; double(gXold')];
   functionValues(end+1) = double(subs(f, I, Xnew));
   
   
   Niter = Niter + 1;
end

Imin = double(Xold);
Pmin = double(subs(f, I, Imin));
points = [points; double(Xnew')];
gradients = [gradients; double(gXold')];
functionValues(end+1) = double(subs(f, I, Xnew));
functionValues=functionValues';
end