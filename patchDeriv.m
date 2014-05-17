function [ Dderiv , Dinterp ] = patchDeriv( D , tau )
%   [ Dderiv , Dinterp ] = patchDeriv( D , tau )
%    
%    This function returns the spline data for obtaining
%    the derivative and function value at any time t.
%    The spline is constructed using the surface data D sampled at
%    source-time tau for each element. The values in tau are
%    strictly in increasing order.
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

  % Setup cubic spline interpolator
  for i = 1 : ndof
    Dinterp(i) = spline( tau , D(:,i) );
  end

  % Get spline derivative coeffs
  for i = 1 : ndof
    Dderiv(i) = ppder( Dinterp(i) , 1 );
  end

end

