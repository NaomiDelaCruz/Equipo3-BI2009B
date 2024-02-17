f=imread('radiograph1.jpg'); %archivo en misma carpeta

imshow(f); %mostrar imagen en escala de blanco y negro

%%
f=f(:,:,1); %1 canal
imshow(f); 

%%
f=double(f)/255; % double() ayuda a convertir valores simbólicos con doble precisión 
imshow(f);

%% Factor de 4
f=imresize(f,0.25); %cambiar escala o tamaño de la imagen a 1/4 de la inicial

figure(1);
subplot(2,2,1);%guardar la imagen en la primera
imshow(f,[]);
subplot(2,2,2);
mesh(f) %crear superficie 3D que tiene un sólido

%% Comvolución en el espacio - Función de distorsión
%h=10*fspecial('disk',10); --> hacer imagen borrosa
h=10*fspecial('gaussian',7,2); %filtro paso bajo

subplot(2,2,3);
mesh(h)

sum(sum(h));

%convolución: promedio los pixeles
g=conv2(f,h,"same");

subplot(2,2,4);
imshow(g,[]);

%siempre hay que integrar a 1
%%
%F=fft2(f,sz(1),sz(2));
%subplot(2,2,4);
%imshow(fftshift(log(abs(F))),[]);

%%
sz=size(f); %calcular el tamaño original
f=zeros(sz(1)); %matriz de ceros
f(int16(sz(1)/2),int16(sz(2)/2))=1;
f(int16(sz(1)/3),int16(sz(2)/2))=1;
f(int16(sz(1)/2),int16(sz(2)/3))=1;
subplot(2,2,2);
imshow(f,[]);

h=fspecial('gaussian',7,2);
subplot(2,2,3);
mesh(h)

g=conv2(f,h,"same");
subplot(2,2,4);
%imshow(g,[]);
mesh(g)

%%

for(x=1:sz(1))
    for(y=1:sz(2))
        f(y,x)=sin(y*0.7)*sin(x*0.5);
    end
end
subplot(2,2,1);
imshow(f,[]);

%% Transformada de Fourier
F=fft2(f,sz(1),sz(2));
subplot(2,2,2);
imshow(fftshift(log(abs(F))),[]);

subplot(2,2,3);
imshow(fftshift((abs(F))),[]);


