function [a1,ax,ay,w]=est_tps(ctr_pts,target_value)

K=zeros(size(ctr_pts,1));

for i=1:size(ctr_pts,1)
   for j=1:size(ctr_pts,1)
            r=ctr_pts(i,:)-ctr_pts(j,:);
            if(r==0)
                U_norm=0;
            else
                U_norm=-(norm(r)^2)*log(norm(r)^2);
            end
                K(i,j)=U_norm;
    
            
   end
end
        
  
P=[ctr_pts(:,1),ctr_pts(:,2),ones(size(ctr_pts,1),1)];
    

Z=zeros(3,3);
Q=[K,P;P',Z];
lambda=1e-25;
I=eye(size(Q));
lon=size(Q,1)-size(target_value,1);
target_value=[target_value;zeros(lon,1)];
W=inv(Q+lambda*I)* target_value;

a1=W(length(W));
ay=W(length(W)-1);
ax=W(length(W)-2);
w=W(1:length(W)-3);
end


