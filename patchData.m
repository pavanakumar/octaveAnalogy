function [ D , tau ] = patchData( fname )
%PATCHDATA     D = patchData( fname );
%
%           PATCHDATA returns the surface element flow data D by
%           reading the file name fname. If the total number
%           of elements is N then D is a (nt,N+1) matrix
%           containing the flow variable pressure of each node of
%           the elements in a contiguous order for all time samples nt.
%           The samples can be non-uniform in time and tau array is used
%           to indicate the data at a particular time (source).
%      
%            EXAMPLE
%
%         p1(1:nt)  p2(1:nt)  p3(1:nt)  p4(1:nt) pN(1:nt) pN+1(1:nt)
%            *---------*----------*---------* ... *--------* 
%               e1          e2         e3             eN 
%
%           D = [ p1 ; p2 ; ... ; pN+1 ];
%
%           NOTE: Presently only 2D linear elements are supported.

  %% Open file for reading
  [ myfile , err_msg ] = fopen( fname , 'r' );

  %% Check if file is valid
  if( myfile == -1 )
    disp(err_msg)
    return
  end

  %% Read the total number of elements in file
  [ N , count , err_msg ] = fscanf( myfile , '%d' , 1 );
  disp( 'Total dofs in file = ' ) , disp(N)
    
  %% Check for errors in reading file
  if( count <= 0 )
    disp(err_msg)
    return
  end

  %% Read the total number of time samples in file
  [ nt , count , err_msg ] = fscanf( myfile , '%d' , 1 );
  disp( 'Total time snaps in file = ' ) , disp(nt)
  
  %% Check for errors in reading file
  if( count <= 0 )
    disp(err_msg)
    return
  end
  
  %% Read time samples from file
  D   = zeros( nt , N+1 );
  tau = zeros( nt , 1 );
  for i = 1 : nt
    [ tau(i) , count , err_msg ] = fscanf( myfile , '%f' , 1 );
    %% Check for errors in reading file
    if( count <= 0 )
      disp(err_msg)
      return
    end
    for j = 1 : N+1
      [ D(i,j) , count , err_msg ] = fscanf( myfile , '%f' , 1 );
      %% Check for errors in reading file
      if( count <= 0 )
        disp(err_msg)
        return
      end
    end
  end
   
  %% Close file
  fclose(myfile);
  disp('Finished reading file') , disp(fname)
end

