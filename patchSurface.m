function S = patchSurface( fname , ndim )
%PATCHSURFACE     S = patchSurface( fname , ndim );
%
%           PATCHSURFACE returns the surface elements S by
%           reading the file name fname. If the total number
%           of elements is N then S is a ( ndim x (N+1) ) matrix 
%           containing the co-ordinates (x,y) of each node of
%           the elements in a contiguous order.
%
%            EXAMPLE
%
%         (x1,y1)   (x2,y2)    (x3,y3)  (x4,y4) (xN,yN)   (xN+1,yN+1)
%            *---------*----------*---------* ... *--------* 
%               e1          e2         e3             eN 
%
%           S = [ x1 , y1 ; x2 , y2 ; ... ; xN+1 ,yN+1 ];
%
%           NOTE: Presently only 2D linear elements are supported.

  %% Default is 2D
  if( nargin == 1 )
    ndim = 2;
  end
  %% Open file for reading
  [ myfile , err_msg ] = fopen( fname , 'r' );

  %% Check if file is valid
  if( myfile == -1 )
    disp(err_msg)
    return
  end

  %% Read the total number of elements in file
  [ N , count , err_msg ] = fscanf( myfile , '%d' , 1 );
  disp('Total dofs in file = ' ), disp(N)
  
  %% Check for errors in reading file
  if( count <= 0 )
    disp(err_msg)
    return
  end

  %% Read the data into S matrix
  [ S , count , err_msg ] = fscanf( myfile , '%f' , [ndim,N+1] );
  S = S';

  %% Check for errors in reading file
  if( count <= 0 )
    disp(err_msg)
    return
  end

  %% Close file
  fclose(myfile);
  disp('Finished reading file') , disp( fname );
end

