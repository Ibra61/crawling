% Pilot program for calulating volumes
% Kevin & Ibrahim
% 14/11/15

function vol3 = volume3_calculator(path)

nii = load_untouch_nii(path);
dat = nii.img;
mask = dat~=0;
voxel_dim = nii.hdr.dime.pixdim (2)* nii.hdr.dime.pixdim (3)* nii.hdr.dime.pixdim (4);
vol3 = sum(mask(:))*prod(voxel_dim);
end

