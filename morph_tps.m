function morphed_im=morph_tps(im_source,a1_x,ax_x,ay_x,w_x,a1_y,ax_y,ay_y,w_y,ctr_pts,len)
target=zeros(len(1),len(2),3);
img_XY=cell(size(target,2),size(target,1));

for i=1:size(target,2)
    for k=1:size(target,1)

            
            X_2=[ctr_pts(:,1),ctr_pts(:,2)];
            iter=[i,k];
            d_2=bsxfun(@minus,X_2,iter);
            d_2_norm=zeros(size(d_2,1),1);
            U_2_norm=zeros(size(d_2,1),1);
            for l=1:size(d_2,1)
                d_2_norm(l)=norm(d_2(l,:));
                if d_2_norm(l) == 0 || isnan(d_2_norm(l))
                    d_2_norm(l)=1e-15;
                end
                U_2_norm(l)= -(d_2_norm(l)*d_2_norm(l))*log(d_2_norm(l)*d_2_norm(l));
            end
             
            img_X1= a1_x + ax_x*i+ ay_x*k + sum(w_x.*U_2_norm);
            img_X1=round(img_X1);
            if(isnan(img_X1))
                img_X1=i;
            end
            if(img_X1<=0)
                img_X1=1;
            end
            if(img_X1>size(im_source,2))
                img_X1=size(im_source,2);
            end
            
            img_Y1= a1_y + ax_y*i+ ay_y*k + sum(w_y.*U_2_norm);
            img_Y1=round(img_Y1);
            if(isnan(img_Y1))
                img_Y1=k;
            end
            if(img_Y1<=0)
                img_Y1=1;
            end
            if(img_Y1>size(im_source,1))
                img_Y1=size(im_source,1);
            end
            img_XY{i,k}=[img_X1,img_Y1];
           
            target(k,i,:)=im_source(img_XY{i,k}(2),img_XY{i,k}(1),:);
            
    end
end


morphed_im=target;
