Vtn=0.5; %NMOS eşik gerilimi
Vtp=-0.5; %PMOS eşik gerilimi
Kn=4; Kp=2; %mnCox değerleri
WLRn=2; %NMOS için W/L oranı
WLRp=4; %PMOS için W/L oranı
Bn=Kn*WLRn;
Bp=Kp*WLRp;
%Bn/Bp =1 ve Vtn=abs(Vtp) --> Match Transistor
lp=0.05;
ln=0.04;
VDD=5;
y = zeros(1,5/0.005+1);
i=1;
for V=(0:0.005:5)
    if(V>=0)&&(V<0.5)
        %NMOS kesim
        %PMOS doymasız
        y(i)=VDD;
    elseif(V>=0.5)&&(V<y(i-1)-0.5)
        %NMOS saturasyon
        %PMOS doymasız
        y(i)=V+abs(Vtp)+sqrt((VDD-abs(Vtp)-V)^2-(Bn/Bp)*(V-Vtn)^2);
    elseif(V>=y(i-1)-0.5)&&(V<y(i-1)+0.5)
        %NMOS saturasyon
        %PMOS saturasyon
        y(i)=((Bp*(1+lp*VDD)*(VDD-abs(Vtp)-V)^2)-Bn*(V-Vtn)^2)/(Bn*ln*(V-Vtn)^2+Bp*lp*(VDD-abs(Vtp)-V)^2);
    elseif(V>=y(i-1)-0.5)&&(V<4.3)
        %NMOS doymasız
        %PMOS saturasyon
        y(i)=V-Vtn-sqrt(abs((V-Vtn)^2-(Bp/Bn)*(VDD-abs(Vtn)-V)^2));
    elseif(V>=4.3)&&(V<5)   
        %NMOS doymasız
        %PMOS kesim
        y(i)=0;
    end
  i=i+1;
end
plot(0:0.005:5,y,'b');
title('EVIRICI KARAKTERISTIGI');
xlabel('Vin'); ylabel('Vout');
grid on;
axis square;
