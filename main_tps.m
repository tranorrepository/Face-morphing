
im1=imread('rsz_3airbrush_20161019032512.jpg');

im2=imread('zachgaliflanakis.png');
[im1_pts,im2_pts]=click_correspondences(im1,im2);

impoints=(1-0.5)*im1_pts+0.5*im2_pts;
warp_frac=[0:(1/size(im1_pts,1)):1];
dissolve_frac=[0:(1/size(im1_pts,1)):1];
filename='vidabcd.avi';
v=VideoWriter(filename,'Uncompressed AVI');
v.FrameRate=30;
open(v);
i=1;
n=60;
while(n>0 && i<size(im1_pts,1))
morphed_im=morph_tps_wrapper(im1,im2,im1_pts,im2_pts,warp_frac(i),dissolve_frac(i));
v.writeVideo(morphed_im);
i=i+1;
n=n-1;
end
close(v);
