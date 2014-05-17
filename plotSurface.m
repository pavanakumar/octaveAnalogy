function plotSurface( S , periodic=false , fig=1 )
%PLOTSURFACE    fig  = plotSurface( S );
%
%           PLOTSURFACE plots the source elements defined by
%           matrix S. If the total number of elements is N 
%           then S is a ( 2 x (N+1) ) matrix containing the
%           co-ordinates (x,y) of each node of the elements
%           in a contiguous order.
%
%           If periodic=true then the last element is drawn 
%           using N+1 and 1.
%           
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
  figure(fig);
  hold off;
  plot( S(1:2,1) , S(1:2,2) , '-*');
  hold on;

  for i = 2 : size(S,1) - 1
    plot( S(i:i+1,1) , S(i:i+1,2) ,'-*' );
  end

  if( periodic == true )
    elem_x = [ S(size(S,1),1) , S(1,1) ];
    elem_y = [ S(size(S,1),2) , S(1,2) ];
    plot( elem_x , elem_y , 'r' );
  end
  
  hold off;

end
