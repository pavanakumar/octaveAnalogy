function [ src , e ] = pressureSource( pressure , srf , tau , obs )
% PRESSURESOURCE
% 
%    [ src , e ] = pressureSource( pressure , srf , tau , t , obs )
%    
%    Calculates the pressure source terms at the observer locations obs
%    integrated over all dofs of surface patch srf.

  %% Some index limits
  [ nobs , ndim ] = size(obs);
  ntau = length(tau);
  [ ndof , ndim_chk ] = size(srf);
  
  p_src    = zeros( ndof - 1 , 1 );
  dpdt_src = zeros( ndof - 1 , 1 );
  src      = zeros( nobs , ntau );

  %% Some input validation checks
  if( ndim ~= ndim_chk )
    error('Dimensions do not agree size(obs,2) ~= size(srf,2)');
  end
  
  %% Speed of sound
  c_speed = 330;

  %% Calculate the patch normals and patch length
  [ normal , mag_normal ] = patchNormal(srf);

  %% Get the time interpolator for p and dp/dt
  [ dpdt , p ] = patchDerivQuadrature( pressure , tau );

  %% Obtain the quadrature nodes on which we want
  %% to evaluate the source term
  qnodes = patchQuadrature( srf );

  %% Calculate the min/max observer time and create observer time array
  [ tmin , tmax ] = retartedTimeMinMax( qnodes , tau , obs , c_speed );
  t = linspace( tmin , tmax , ntau );
  t = t';
  
  %% First interpolate on to the quadrature nodes in space for
  %% each source time snapshot and then do the interpolation in
  %% time for the retarted time.

  %% For each observer point
  for i = 1 : nobs
    %% Find the vector connecting the dof to observer
    r       = bsxfun( @minus , qnodes , obs(i,:) );
    mag_r_2   = dot( r , r , 2 );
    mag_r     = norm( r , 'rows' );
    r_dot_n = dot( r , normal , 2 );
    %% For each observer time sample
    for j = 1 : ntau
      %% Calculate the retarted times for each
      %% souce panel
      t_ret = t(j) - sqrt(mag_r_2) / c_speed;
%      t_ret = t(j) - mag_r / c_speed;
      for k = 1 : ndof - 1
        %% Get the source values at the retarted
        %% time of the panel
        p_src(k)    = ppval( p(k)    , t_ret(k) );
        dpdt_src(k) = ppval( dpdt(k) , t_ret(k) );
%        src(i,j) = src(i,j) + r_dot_n(k) * ( 2.0 * p_src(k) / mag_r_2(k) + pi * dpdt_src(k) / c_speed ) * mag_normal(k);
%        src(i,j) = src(i,j) + r_dot_n(k) * ( 2.0 * p_src(k) / ( mag_r(k) * mag_r(k) ) ) * mag_normal(k);
      end
      src(i,j) = sum( r_dot_n .* ( 2.0 * p_src ./ mag_r_2 ...
                      + pi .* dpdt_src / c_speed ) .* mag_normal );
%      src(i,j) = sum( r_dot_n .* ( 2.0 .* p_src /
%                        ( dot( mag_r , mag_r ) )
%                        + pi .* dpdt_src / c_speed
%                      ) .* mag_normal );
    end
  end
end
 
