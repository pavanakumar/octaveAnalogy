function qnodes = patchQuadrature( S , xadj , adjncy )

  if( nargin > 1 )
    error( 'Only 2d linear element implemented' );
  end

  %% Take the min-point as the quadrature node
  [ ndof , ndim ] = size(S);
  qnodes = 0.5 * ( S(1:ndof-1,:) + S(2:ndof,:) );

end
