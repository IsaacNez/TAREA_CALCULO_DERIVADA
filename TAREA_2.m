#!/usr/bin/octave
#Isaac Núñez Araya
#Agosto, 2017
#Error total

pkg load symbolic
#--------------------------------#
#Global variables
steph = 1/10; #El paso de como se va reduciendo h

changeH = []; #Acumula los pasos usados en el ploteo
errorH = []; #Acumula el error del cálculo de la diferenciación hacia adelante
errorHBack = []; #Acumula el error del cálculo de la diferenciación hacia atrás
errorCentered = []; #Acumula el error del cálculo de la diferenciación centrada
indpower = 1; #Index de cuántos valores habrá en el vector de pasos, inicializado en 1
inderror = 1; #Index que obtiene los valores del vector de pasos
numPoints = 1000; #Número de puntos por década
#--------------------------------#
#Funciones básicas y el valor téorico de la derivada
x_0 = 1; #Valor donde se desea calcular la derivada de la función
f = @(x)(0.3*x.^4-0.15*x.^2); #Función usada para calcular el valor de la derivada
df = @(x)(1.2*x.^3-0.30*x); #Derivada de la función
valuef = df(1); #Derivada evaluada para obtener el valor "teórico"
#--------------------------------#
#Cálculos de valores generales
#Calcula todos los pasos utilizados para el ploteo
while (indpower < numPoints)
	changeH(end+1) = (steph.^(1/(numPoints/10))).^(indpower-1);
	indpower++;
	
endwhile
#--------------------------------#
#Diferenciación en sus tres formas
#Calcula el valor de la derivada usando la fórmula, además que calcula el error relativo y los guarda para luego plotear los datos
while (inderror <numPoints)
	tmp = ( f( 1+changeH(inderror)) - f( x_0 ) )/changeH(inderror); #Diferenciación hacia adelante
	tmp1 = ( f( x_0 )-f( 1-changeH(inderror)))/changeH(inderror); #Diferenciación hacia atrás
	tmp2 = (f( 1+changeH(inderror))-f( 1-changeH(inderror)))/(2*changeH(inderror)); #Diferenciación centrada
	errorH(end+1) = abs(valuef -tmp);
	errorHBack(end+1) = abs(valuef-tmp1);
	errorCentered(end+1)= abs(valuef-tmp2);
	inderror++;
endwhile
#--------------------------------#
#Ploteo de los datos calculados anteriormente.
set(gca,"fontsize", 40);
loglog(changeH,errorH, '-r', changeH,errorHBack, '-g',changeH,errorCentered, '-b' ); #Mostratá un gráfico de error vs h tomando en cuenta los tres casos de cálculo.
title("Plot del error vs h al calcular una derivada");
xlabel("h_i");
ylabel("Error relativo");
legend("Adelante", "Atrás", "Centrada"); #La línea roja corresponde al cálculo hacia adelante, la verde es hacia atrás y la azul es al cálculo centrada.
saveas (1, "figure1.png")
