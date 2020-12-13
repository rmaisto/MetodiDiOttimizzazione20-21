function c = bisezione(f, a, b, NiterMax)

if subs(f, a) * subs(f, b) >= 0
    error('Intervallo non corretto!');
else
    Niter = 1;
    while true
        c = (a + b) / 2;
        if subs(f, a) * subs(f, c) < 0
            b = c;
        else
            a = c;
        end

        %La ricerca del nullo si arresterà quando f(c) sarà zero oppure dopo un
        %numero massimo di iterazioni
        if abs(subs(f, c)) <= 1e-6 || Niter >= NiterMax
            break;
        end
        Niter = Niter + 1;
    end
end

end