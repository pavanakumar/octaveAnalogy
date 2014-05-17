function [ normal , mag ] = patchNormal( S , xadj , adjncy )
%
% PATCHNORMAL
%
%    normal = patchNormal( S , xadj , adjncy )
% 
%    Calculates the normals of the given source surface S.
%    For elements other than 2D line elements the user has
%    to specify the xadj and adjncy for giving the connectivity
%    information. Only linear elements supported.
%    
%    Note: The magnitude mag for 2d is just the lenght of the element
%          and for 3d it is the element area.

  %% Some checks
  if( nargin > 1 )
    error( 'Only 2D line elements supported' );
  end

  %% Obtain sizes
  [ ndof , ndim ] = size(S);

  %% Rotate by 90degs counter clockwise to create the normal
  normal = S(2:ndof,[2 1]) - S(1:ndof-1,[2 1]);
  normal(:,1) = -normal(:,1);

  %% Element length
  mag = norm( normal , 'rows' );
end

