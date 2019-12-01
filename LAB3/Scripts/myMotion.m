function [Res] = myMotion(I,n,angle)
%n := length of the motion; angle := angle of motion
H = 1/2*[0,0,0;
         1,1,0;
         0,0,0];
     
H = imrotate(H,angle);

Res = I; 
J = imfilter(Res,H);
for i = 1:n
    Res = Res+J;
    J = imfilter(J,H);
end


end

