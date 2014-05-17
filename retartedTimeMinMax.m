function [ tmin , tmax ] = retartedTimeMinMax( S, tau, obs , c_speed )
%        [ tmin , tmax ] = retartedTimeMinMax( S, tau, obs , c_speed )
%
%           Calculates the observer time min/max for each source time
%           and returns in tMinMax. The observer (obs) is the spatial
%           location in 2d space (x,y) it is a matrix of size (2,nobs)
%           S is the source surface which is of size (2,ndof)
%
%           nobs = Total number of observer points

  %% Find the minimum and maximum source time
  tau_min = min(tau);
  tau_max = max(tau);
  nobs = size( obs , 1 );
  [ ndof , ndim ] = size(S);

  %r = zeros( ndof , 1 );
  %% Calculate the minimum and maximum panel distance
  for i = 1 : nobs
    %% New version (Matlab compatible)
    r = norm( bsxfun( @minus , S , obs(i,:) ) , 'rows' );
    %% New version (Octave only)
    % r = norm( S - obs(i,:) , 'rows' );
    %% Old version 
    %    for j = 1 : ndof
    %      r(j) = norm( ( S(j,:) - obs(i,:) ) );
    %    end
    r_max = max(r);
    r_min = min(r);
    tmin_temp(i) = tau_min + r_min / c_speed;
    tmax_temp(i) = tau_max + r_max / c_speed;
  end
  tmin = min(tmin_temp);
  tmax = max(tmax_temp);
end

