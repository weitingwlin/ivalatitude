   l_styles = [3 2 2];
   l_colors = [1  17 7];
   p_styles = [1.5 17 7];
   
      myplot([1.1, 1.5], [-0.2, -0.2 ], 'L', 1, 1, 5); hold on
      mytext(1.6, -0.25, '(Final model does not \n include month)', 18, 4);
   for i = 1:3
       myplot(1, (4 - i)/2, 'S', p_styles(i), i, 5);hold on
       myplot([1.1, 1.5], [4 - i, 4 - i]/2, 'L', l_colors(i), l_styles(i), 5);
       mytext(1.6, (4-i)/2, num2month(i+5), 18, 4);
   end
    
   axis([0.5 2.5 -1 3])
   box off
   axis off