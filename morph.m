function morphed_im=morph(im1, im2, im1_pts, im2_pts, tri, warp_frac, dissolve_frac)

img2=im2;
img1=im1;
movingPoints=im1_pts;
fixedPoints=im2_pts;
inter_moving_X=movingPoints(:,1);
inter_moving_Y=movingPoints(:,2);
inter_fixed_X=fixedPoints(:,1);
inter_fixed_Y=fixedPoints(:,2);

impoints=(1-warp_frac)*movingPoints+warp_frac*fixedPoints;

im_X=impoints(:,1);
im_Y=impoints(:,2);



img3=zeros(size(img1,2),size(img1,1),3);


    inter_T_img1={size(tri)};
    inter_inv_T_img1={size(tri)};
    inv_coords_img1={size(tri)};
    inv_coords_img2={size(tri)};

for i=1:size(tri,1)
        img1_ind=tri(i,:);
        img1_coords_X=[im_X(img1_ind(1)) im_X(img1_ind(2)) im_X(img1_ind(3))];
        img1_coords_Y=[im_Y(img1_ind(1)) im_Y(img1_ind(2)) im_Y(img1_ind(3))];
        inter_T_img1{i}=[img1_coords_X;img1_coords_Y;1 1 1];
        
        inter_inv_T_img1{i}=inv(inter_T_img1{i});
        
        inv_ind=tri(i,:);
        inv_coords_X_img1=[inter_moving_X(inv_ind(1)) inter_moving_X(inv_ind(2)) inter_moving_X(inv_ind(3))];
        inv_coords_Y_img1=[inter_moving_Y(inv_ind(1)) inter_moving_Y(inv_ind(2)) inter_moving_Y(inv_ind(3))];
        inv_coords_img1{i}=[inv_coords_X_img1;inv_coords_Y_img1;1 1 1];
        
        
        
        inv_coords_X_img2=[inter_fixed_X(inv_ind(1)) inter_fixed_X(inv_ind(2)) inter_fixed_X(inv_ind(3))];
        inv_coords_Y_img2=[inter_fixed_Y(inv_ind(1)) inter_fixed_Y(inv_ind(2)) inter_fixed_Y(inv_ind(3))];
        inv_coords_img2{i}=[inv_coords_X_img2;inv_coords_Y_img2;1 1 1]; %*B{i+j};
        
        
        
    
end

T=zeros(size(img3,1),size(img3,2));

XY_img1={size(img3,1)};
XY_img2={size(img3,1)};
for i=1:size(img3,2)
    for j=1:size(img3,1)
        
        T(i,j)=tsearchn(impoints,tri,[i j]);
               
    end
end
for i=1:size(img3,2)
    for j=1:size(img3,1)
        if isnan(T(i,j)) == 0
        B{i,j}=inter_inv_T_img1{T(i,j)}*[i;j;1];
     
        XY_img1{i,j}=inv_coords_img1{T(i,j)} * B{i,j};
        XY_img2{i,j}=inv_coords_img2{T(i,j)}*B{i,j};
        
        if (XY_img1{i,j}(3) > 0 && XY_img2{i,j}(3) > 0)
        XY_img1{i,j} = XY_img1{i,j} ./ XY_img1{i,j}(3);
        XY_img2{i,j} = XY_img2{i,j} ./ XY_img2{i,j}(3);
        end
        XY_img1{i,j}=round(XY_img1{i,j});
        XY_img2{i,j}=round(XY_img2{i,j});
        
        
        %Clamping
        if XY_img1{i,j}(1) <=0
            
            XY_img1{i,j}(1)= 1;
        else if XY_img1{i,j}(1) > size(img3,1)
                XY_img1{i,j}(1)=size(img3,1);
            end 
        end
        if XY_img1{i,j}(2) <=0
            XY_img1{i,j}(2)= 1;
        else if XY_img1{i,j}(2) > size(img3,2)
                XY_img1{i,j}(2)=size(img3,2);
            end 
        end 
        if XY_img2{i,j}(1) <=0
            XY_img2{i,j}(1)= 1;
        else if XY_img2{i,j}(1) > size(img3,1)
                XY_img2{i,j}(1)=size(img3,1);
            end 
        end
        if XY_img2{i,j}(2) <=0
            XY_img2{i,j}(2)= 1;
        else if XY_img2{i,j}(2) > size(img3,2)
                XY_img2{i,j}(2)=size(img3,2);
            end 
        end
        img3(j,i,:)=(1-dissolve_frac)*img1(XY_img1{i,j}(2),XY_img1{i,j}(1),:)+dissolve_frac*img2(XY_img2{i,j}(2),XY_img2{i,j}(1),:);
        end
    end
end
img3=uint8(img3);
morphed_im=img3;
end