function [ Dderiv , Dinterp ] = patchDerivQuadrature( D , tau )
%   [ Dderiv , Dinterp , qnodes ] = patchDerivQuadrature( D , tau )
%    
%    This function returns the spline data for obtaining
%    the derivative and function value at any time t.
%    The spline is constructed using the surface data D sampled at
%    source-time tau for each element. The values in tau are
%    strictly in increasing order. The values obtained from the
%    splines are directly at the quadrature nodes of the element
%    give in the list qnodes.
%  
%                         x -> observer
%                         |
%      .............................................
%     /    |     |         |       |      |          \
%    *-----*-----*---------*-------*------*-----------*
%    1(t1) 2(t2)  ....                                ndof (t_ndof)
% 

  % Get total source time snaps (ntau)
  % and total number of dofs (ndof)
  [ ntau ndof ] = size( D );

  % Validate sizes
  if ( ntau ~= length(tau) )
    error( 'Source time snap sizes do not match ntau ~= length(tau)' );
  end

  % Interpolate snap shots to quadrature nodes
  Dquad = 0.5 * ( D(:,1:ndof-1) + D(:,2:ndof) );

  % Setup cubic spline interpolator 
  % for quadrature node data
  for i = 1 : ndof - 1
    Dinterp(i) = spline( tau , Dquad(:,i) );
  end

  % Get spline derivative coeffs
  for i = 1 : ndof - 1
    Dderiv(i) = ppder( Dinterp(i) , 1 );
  end

end

