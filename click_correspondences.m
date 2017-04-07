function [im1_pts,im2_pts]=click_correspondences(im1,im2)

img1=im2double(im1);
img2=im2double(im2);


[im1_pts,im2_pts]=cpselect(img1,img2,'Wait',true);

end