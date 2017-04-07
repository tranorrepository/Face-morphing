
im1=imread('rsz_3airbrush_20161019032512.jpg');

im2=imread('zachgaliflanakis.png');
[im1_pts,im2_pts]=click_correspondences(im1,im2);


impoints=(1-0.5)*im1_pts+0.5*im2_pts;



im_X=impoints(:,1);
im_Y=impoints(:,2);

TRI=delaunay(im_X,im_Y);

n=60;
warp_frac=[0:(1/size(im1_pts,1)):1];
dissolve_frac=[0:(1/size(im1_pts,1)):1];
filename='vid.avi';
v=VideoWriter(filename,'Uncompressed AVI');
v.FrameRate=15;
open(v);
i=1;
while(n>0 && i<size(im1_pts,1))
morphed_im=morph(im1,im2,im1_pts,im2_pts,TRI,warp_frac(i),dissolve_frac(i));
v.writeVideo(morphed_im);
i=i+1;
n=n-1;
end
close(v);
