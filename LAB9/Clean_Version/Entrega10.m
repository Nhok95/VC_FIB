%Reconeixement

I = imread('Joc_de_caracters.jpg');
I2 = imread('Joc_de_caracters_deformats.jpg');
I3 = imread('Joc_de_caracters_deformats II.png');
Caract = ObtenirCaract(I); %Obtenim 8 caracteristiques per cada lletra de I
Caract2 = ObtenirCaract(I2); %El mateix pero amb I2
Caract3 = ObtenirCaract(I3); %El mateix pero amb I3 


M1 = ConfusionMatrix(Caract,Caract2); %Construim la matriu de confusio (Volem reconeixer I2 mitjançant I)
Errors = GetError(M1);  %Calculem el error (Asignacions fora de la diagonal)
Encerts = GetSuccess(M1); %Encerts (Asignacions a la diagonal)

M2 = ConfusionMatrix(Caract,Caract3);
Errors2 = GetError(M2);  %Calculem el error (Asignacions fora de la diagonal)
Encerts2 = GetSuccess(M2);

Weakest1 = WeakestCharact(Caract,Caract2);
Weakest2 = WeakestCharact(Caract,Caract3);



