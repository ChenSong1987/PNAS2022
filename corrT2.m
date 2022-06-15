function r=corrT2(T,N)

r=sign(T)*sqrt(1./((sqrt(N-2)./T).^2+1));