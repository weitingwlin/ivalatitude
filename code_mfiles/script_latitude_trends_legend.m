%%  scripts for making plot
% used in  **work\_explore\_latitude\_trend.m**

legend_handle = [];
legend_str = {} ;    
      % legend(h{4}, '3-month')
       for id = 1:3
           legend_handle = [ legend_handle h{id} ];
           legend_str = [ legend_str num2month(id+5)] ;
           if ~isempty( h2{id} )
               legend_handle = [legend_handle  h2{id}];
               legend_str = [legend_str , ' '];
           end
       end
      legend(legend_handle,  legend_str  ); 