close all;
clear all;
clc;

%imagen sin procesar
figure;
for a=1:4
filename = ['Pruebas/prueba (' num2str(a) ').bmp'];
J = imread(filename);
str = strcat('Imagen- ', num2str(a),' sin Procesar');
subplot(2, 2, a);
imshow(J),title(str);
end
str = strcat('Histograma Imagen- ', num2str(4),' sin Procesar');
figure,histogram(J),title(str),xlabel('Pixel Intensity(0-255)'),ylabel('Frecuency'),xlim([0 255]);
%%

%imagen ecualizada
figure;
for a=1:4
filename = ['Pruebas/prueba (' num2str(a) ').bmp'];
J = imread(filename);
I = histeq(J);
str = strcat('Imagen- ', num2str(a),' Ecualizada');
subplot(2, 2, a);
imshow(I),title(str);
end
str = strcat('Histograma Imagen- ', num2str(a),' Ecualizada');
figure,histogram(I),title(str),xlabel('Pixel Intensity(0-255)'),ylabel('Frecuency'),xlim([0 255]);
%%

%Imagen tras deteccion de cara
faceDetector = vision.CascadeObjectDetector('ClassificationModel','FrontalFaceLBP');
figure;
for a=1:4
    filename = ['Pruebas/prueba (' num2str(a) ').bmp'];
    J = imread(filename);
    I = histeq(J);
    bboxes = step(faceDetector, I);
    IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, 'Face');
    if(size(bboxes,1)>0)
        if (size(bboxes,1)>1)
           [M,index] = max(bboxes(:,3));
           bboxes=bboxes(index,:);
           str = strcat('Imagen- ', num2str(a),', Detecci�n M�ltiple');
           subplot(2, 2, a);
           imshow(IFaces),title(str);
        else
            str = strcat('Imagen- ', num2str(a),' con Detecci�n de Cara');
            subplot(2, 2, a);
            imshow(IFaces),title(str);
        end
    else
        str = strcat('Imagen- ', num2str(a),', Cara no Detectada');
        subplot(2, 2, a);
        imshow(I),title(str);
    end
end
%%

%Recorte de caras
faceDetector = vision.CascadeObjectDetector('ClassificationModel','FrontalFaceLBP');
figure;
for a = 1:4
   filename = ['Pruebas/prueba (' num2str(a) ').bmp'];
   J = imread(filename);
   I = histeq(J);
   bboxes = step(faceDetector, I);
   IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, 'Face');
   if(size(bboxes,1)>0)
       if (size(bboxes,1)>1)
           [M,index] = max(bboxes(:,3));
           bboxes=bboxes(index,:);
       end        
        IfaceDetected = I((bboxes(1,2):(bboxes(1,2)+bboxes(1,4)-1)),(bboxes(1,1):(bboxes(1,1)+bboxes(1,3)-1)));
        str = strcat('Imagen- ', num2str(a),' Cara Recortada');
        subplot(2, 2, a);
        imshow(IfaceDetected),title(str);
        %segunda ecualizacion debido a fondos muy contrastados(claros u
        %oscuros)
        Prueba = histeq(IfaceDetected);
        filename2=['CarasMujeres/mujer (' num2str(a) ').bmp'];
        imwrite(Prueba, filename2);
   end
end
str = strcat('Histograma Imagen- ', num2str(a),' Cara Recortada');
figure,histogram(IfaceDetected),title(str),xlabel('Pixel Intensity(0-255)'),ylabel('Frecuency'),xlim([0 255]);
%%

%Recorte de caras con ecualizaci�n
faceDetector = vision.CascadeObjectDetector('ClassificationModel','FrontalFaceLBP');
figure;
for a = 1:4
   filename = ['Pruebas/prueba (' num2str(a) ').bmp'];
   J = imread(filename);
   I = histeq(J);
   bboxes = step(faceDetector, I);
   IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, 'Face');
   if(size(bboxes,1)>0)
       if (size(bboxes,1)>1)
           [M,index] = max(bboxes(:,3));
           bboxes=bboxes(index,:);
       end        
        IfaceDetected = I((bboxes(1,2):(bboxes(1,2)+bboxes(1,4)-1)),(bboxes(1,1):(bboxes(1,1)+bboxes(1,3)-1)));

        %segunda ecualizacion debido a fondos muy contrastados(claros u
        %oscuros)
        Eq = histeq(IfaceDetected);
        str = strcat('Imagen- ', num2str(a),' Cara Recortada Ecualizada');
        subplot(2, 2, a);
        imshow(Eq),title(str);
   end
end
str = strcat('Histograma Imagen- ', num2str(a),' Ecualizada');
figure,histogram(Eq),title(str),xlabel('Pixel Intensity(0-255)'),ylabel('Frecuency'),xlim([0 255]);
%%

%Creador de Base de Datos
DataBaseCreator('BaseDeDatos');



