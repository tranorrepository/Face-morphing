function morphed_im = morph_tps_wrapper(im1, im2, im1_pts, im2_pts, warp_frac, dissolve_frac)


impoints=(1-warp_frac)*im1_pts+warp_frac*im2_pts;
im1_X=im1_pts(:,1);
im1_Y=im1_pts(:,2);
im2_X=im2_pts(:,1);
im2_Y=im2_pts(:,2);
%TPS parameters
[a1_x,ax_x,ay_x,w_x]=est_tps(impoints,im1_X);
[a1_x1,ax_x1,ay_x1,w_x1]=est_tps(impoints,im1_Y);
[a1_y,ax_y,ay_y,w_y]=est_tps(impoints,im2_Y);
[a1_x2,ax_x2,ay_x2,w_x2]=est_tps(impoints,im2_X);
sz1=[size(im1,2) size(im1,1) 3];
sz=[size(im2,2) size(im2,1) 3];
%two intermediate morphed images
img_XY1=morph_tps(im1,a1_x,ax_x,ay_x,w_x,a1_x1,ax_x1,ay_x1,w_x1,impoints,sz);
img_XY2=morph_tps(im2,a1_x2,ax_x2,ay_x2,w_x2,a1_y,ax_y,ay_y,w_y,impoints,sz);


target_img=zeros(size(im1));

target_img=(1-dissolve_frac)*img_XY1+dissolve_frac*img_XY2;
morphed_im=uint8(target_img);
end